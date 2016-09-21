/*  Servlet which checks the parameters and calls pages for different views
    @(#) $Id: GramwordServlet.java 976 2013-02-02 16:44:18Z gfis $
    2016-09-21: handler deprecated
    2016-09-19: previous name was GrammarServlet
    2016-09-12: moved to package gramword.web, use BasePage
    2016-09-11: javadoc
    2011-09-17: dbat.Configuration
    2010-10-19: Dbat with DBCP
    2008-05-16: evaluate the 'view' parameter; with log4j
    2007-02-16: adapted from xtrans.TransServlet
    2005-07-27, Georg Fischer

    For the discussion of "enctype=multipart/form-data" c.f.
    http://forum.java.sun.com/thread.jspa?threadID=329408&messageID=1340610

    Content-Disposition: attachment; filename="gfis.gif"
    Content-Type: image/gif
*/
/*
 * Copyright 2006 Dr. Georg Fischer <punctum at punctum dot kom>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.teherba.gramword.web;
import  org.teherba.gramword.web.ClassifyPage;
import  org.teherba.gramword.web.IndexPage;
import  org.teherba.gramword.web.Messages;
import  org.teherba.common.web.BasePage;
import  org.teherba.common.web.MetaInfPage;
import  org.teherba.dbat.Configuration;
import  org.teherba.xtrans.BaseTransformer;
import  org.teherba.xtrans.XMLTransformer;
import  java.io.IOException;
import  java.io.StringReader;
import  java.util.Iterator;
import  java.util.LinkedHashMap;
import  java.util.List;
import  java.sql.Connection;
import  java.sql.PreparedStatement;
import  java.sql.ResultSet;
import  javax.servlet.ServletConfig;
import  javax.servlet.ServletContext;
import  javax.servlet.ServletException;
import  javax.servlet.http.HttpServlet;
import  javax.servlet.http.HttpServletRequest;
import  javax.servlet.http.HttpServletResponse;
import  javax.sql.DataSource;
import  org.apache.commons.fileupload.FileItem;
import  org.apache.log4j.Logger;
/**
 *  This class is the servlet interface to the GramWord application
 *  and ressembles the functionality of the commandline interface.
 *  @author Dr. Georg Fischer
 */
public class GramwordServlet extends HttpServlet {
    public final static String CVSID = "@(#) $Id: GramwordServlet.java 976 2013-02-02 16:44:18Z gfis $";

    /** URL path to this application */
    private String applPath;
    /** log4j logger (category) */
    private Logger log;
    /** common code and messages for auxiliary web pages */
    private BasePage basePage;
    /** name of this application */
    private static final String APP_NAME = "gramword";
    /** Debugging switch */
    private static int debug = 1;
    /** Dbat configuration */
    private Configuration dbatConfig;
    /** Maps connection identifiers (short database instance ids) to {@link DataSource Datasources} */
    private LinkedHashMap<String, DataSource> dsMap;

    /** Called by the servlet container to indicate to a servlet
     *  that the servlet is being placed into service.
     *  @throws ServletException
     */
    public void init() throws ServletException {
        log = Logger.getLogger(GramwordServlet.class.getName());
        basePage = new BasePage(APP_NAME);
        Messages.addMessageTexts(basePage);

        dbatConfig = new Configuration();
        dbatConfig.configure(Configuration.WEB_CALL);
        dsMap = dbatConfig.getDataSourceMap();
        String connectionId = "worddb";
        // dbatConfig.addProperties(connectionId + ".properties");
        dbatConfig.setConnectionId(connectionId);
    } // init()

    /** Creates the response for a HTTP GET request.
     *  @param request fields from the client input form
     *  @param response data to be sent back the user's browser
     *  @throws IOException
     */
    public void doGet (HttpServletRequest request, HttpServletResponse response) throws IOException {
        generateResponse(request, response);
    } // doGet

    /** Creates the response for a HTTP POST request.
     *  @param request fields from the client input form
     *  @param response data to be sent back the user's browser
     *  @throws IOException
     */
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        generateResponse(request, response);
    } // doPost

    /** Creates the response for a HTTP GET or POST request.
     *  @param request fields from the client input form
     *  @param response data to be sent back the user's browser
     *  @throws IOException
     */
    public void generateResponse(HttpServletRequest request, HttpServletResponse response) throws IOException {
        dbatConfig.configure(dbatConfig.WEB_CALL, dsMap);
        try {
            String view = basePage.getFilesAndFields(request, new String[]
                    { "view"    , "index"
                    , "enc"     , "UTF-8"       // of infile
                    , "filter"  , "simple"      // filter to be applied
                    , "format"  , "html"        // for target output
                    , "grammar" , "de"          // for analysis of infile
                    , "lang"    , "en"          // for user interface
                    , "infile"  , ""
                    , "strat"   , "all"
                    } );
            String encoding = basePage.getFormField("enc"       );
            String filter   = basePage.getFormField("filter"    );
            String format   = basePage.getFormField("format"    );
            String grammar  = basePage.getFormField("grammar"   );
            String language = basePage.getFormField("lang"      );
            String infile   = basePage.getFormField("infile"    );
            String strategy = basePage.getFormField("strat"     );
            if (true) {
                log.info("view=" + view
                        + ", enc="      + encoding
                        + ", filter="   + filter
                        + ", format="   + format
                        + ", grammar="  + grammar
                        + ", lang="     + language
                        + ", infile="   + infile
                        + ", strat="    + strategy
                        );
            }
            //-------------------------------------
            // first check any parameters
            if (false) {
            } else if (",ISO-8859-1,UTF-8,"     .indexOf(("," + encoding.toUpperCase() + ",")) < 0) {
                basePage.writeMessage(request, response, language, new String[]
                        { "401", "enc"      , encoding  } );
            } else if (",html,text,dict,"       .indexOf("," + format   + ",") < 0) {
                basePage.writeMessage(request, response, language, new String[]
                        { "401", "format"   , format    } );
            } else if (",de,"                   .indexOf("," + grammar  + ",") < 0) {
                basePage.writeMessage(request, response, language, new String[]
                        { "401", "grammar"  , grammar   } );
            } else if (",de,en,"                .indexOf("," + language + ",") < 0) {
                basePage.writeMessage(request, response, language, new String[]
                        { "401", "lang"     , language  } );
            } else if (",all,prsplit,sasplit,"  .indexOf("," + strategy + ",") < 0) {
                basePage.writeMessage(request, response, language, new String[]
                        { "401", "strat"    , strategy  } );
            } else if (basePage.getFormFileCount() <= 0 && ! view.equals("index")) { // no file was uploaded
                basePage.writeMessage(request, response, language, new String[] { "406" } );
            //-------------------------------------
            // then switch for the different views
            } else if (view.equals("index"   ))   { // start page
                    (new IndexPage()).dialog(request, response, basePage);

            } else if (view.equals("index2"  ))   { // former result page
                if (false) {
                } else if (filter.equals("simple"  )
                        || filter.equals("queue"   )
                        || filter.equals("bibleref")
                //      || filter.equals("iban"    ) 
                        || filter.equals("konto"   ) 
                        || filter.equals("number"  ) 
                        || filter.equals("wordtype") ) {
                    (new FilterPage()).showResult(request, response, basePage);
                } else {
                    basePage.writeMessage(request, response, language, new String[]
                            { "401", "filter"    , filter } );
                }

            } else if (view.equals("table" ))   { // show the contents of table 'temp'
            //  RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/classify.jsp");
            //  dispatcher.forward(request, response);

            } else if (view.equals("toggle"))   { // switch the attribute of a table element
            //  generateToggleResponse(request, response);

            } else if (view.equals("license")
                    || view.equals("manifest")
                    || view.equals("notice")
                    ) {
                (new MetaInfPage()).showMetaInf (request, response, basePage, language, view, this);

            } else {
                basePage.writeMessage(request, response, language, new String[] { "401", view, "view" });
            }
        } catch (Exception exc) {
            log.error(exc.getMessage(), exc);
        }
    } // generateResponse

    /** Creates the response for a toggle request form JavaScript/Ajax.
     *  @param request fields from the client input form
     *  @param response data to be sent back the user's browser
     */
    public void generateToggleResponse(HttpServletRequest request, HttpServletResponse response) {
        PreparedStatement selectStmt = null;
        PreparedStatement updateStmt = null;
        try {
            Connection con = dbatConfig.getOpenConnection();
            selectStmt = con.prepareStatement("SELECT enrel FROM    temp where entry = ?");
            response.setContentType("text/plain");
            String id    = basePage.getInputField(request, "id",    "");
            String entry = basePage.getInputField(request, "entry", "");
            System.out.println("toggle id=\"" + id + "\" entry=\"" + entry + "\"");
            selectStmt.clearParameters();
            selectStmt.setString(1, entry);
            ResultSet resultSet = selectStmt.executeQuery();
            String enrel = "";
            while (resultSet.next()) {
                enrel = resultSet.getString(1);
            } // while resultSet
            if (enrel.equals("Aj")) {
                enrel = "Ir";
            } else {
                enrel = "Aj";
            }
            resultSet.close();

            updateStmt = con.prepareStatement("UPDATE temp set enrel = ? where entry = ?");
            updateStmt.clearParameters();
            updateStmt.setString(1, enrel);
            updateStmt.setString(2, entry);
            updateStmt.execute();
            if (updateStmt.getUpdateCount() >= 1) {
            } else {
                log.error("update failed");
            }
            response.getWriter().write(id + "," + enrel + ",");
        } catch (Exception exc) {
            log.error(exc.getMessage(), exc);
        } finally {
            try {
                selectStmt.close();
            } catch (Exception exc) {
               log.error(exc.getMessage(), exc);
            }
            try {
                updateStmt.close();
            } catch (Exception exc) {
               log.error(exc.getMessage(), exc);
            }
            dbatConfig.closeConnection();
        }
    } // generateToggleResponse

} // GramwordServlet
