/*  Servlet which checks the parameters and calls GrammarFilter
    @(#) $Id: GrammarServlet.java 976 2013-02-02 16:44:18Z gfis $
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
import  org.teherba.gramword.GrammarFilter;
import  org.teherba.common.web.BasePage;
import  org.teherba.common.web.MetaInfPage;
import  org.teherba.dbat.Configuration;
import  java.io.IOException;
import  java.io.StringReader;
import  java.util.Iterator;
import  java.util.HashMap;
import  java.util.LinkedHashMap;
import  java.util.List;
import  java.sql.Connection;
import  java.sql.PreparedStatement;
import  java.sql.ResultSet;
import  javax.servlet.RequestDispatcher;
import  javax.servlet.ServletConfig;
import  javax.servlet.ServletContext;
import  javax.servlet.ServletException;
import  javax.servlet.http.HttpServlet;
import  javax.servlet.http.HttpServletRequest;
import  javax.servlet.http.HttpServletResponse;
import  javax.servlet.http.HttpSession;
import  javax.sql.DataSource;
import  org.apache.commons.fileupload.FileItem;
import  org.apache.commons.fileupload.FileItemFactory;
import  org.apache.commons.fileupload.disk.DiskFileItemFactory;
import  org.apache.commons.fileupload.servlet.ServletFileUpload;
import  org.apache.log4j.Logger;
/**
 *  This class is the servlet interface to {@link GrammarFilter},
 *  and ressembles the functionality of the commandline interface.
 *  @author Dr. Georg Fischer
 */
public class GrammarServlet extends HttpServlet {
    public final static String CVSID = "@(#) $Id: GrammarServlet.java 976 2013-02-02 16:44:18Z gfis $";

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
        log = Logger.getLogger(GrammarServlet.class.getName());
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
        String newPage      = ""; // no error so far
        try {
        	String language = "de";
            String view = basePage.getFilesAndFields(request, new String[]
                    { "view"    , "index"
                    , "language", "de"
                    , "format"  , "html"
                    , "encoding", "UTF-8"
                    , "strategy", "all"
                    } );
            if (false) {

            } else if (true || view.equals("index" ))   { // introductory page
                language        = basePage.getFormField("language"  );
                String format   = basePage.getFormField("format"    );
                String encoding = basePage.getFormField("encoding"  );
                String strategy = basePage.getFormField("strategy"  );
            	log.info("view=" + view + ", language=" + language + ", format=" + format + ", encoding=" + encoding + ",strategy=" + strategy);
                String fileName = "";
                if (false) {
                } else if (",html,text,dict,".indexOf("," + format + ",") < 0) {
                    basePage.writeMessage(request, response, language, new String[]
                            { "401", format, "format" } );
                } else if (",de,".indexOf("," + language + ",") < 0) {
                    basePage.writeMessage(request, response, language, new String[]
                            { "401", language, "language" } );
                } else if (",all,prsplit,sasplit,".indexOf("," + strategy + ",") < 0) {
                    basePage.writeMessage(request, response, language, new String[]
                            { "401", strategy, "strategy" } );
                } else if (",ISO-8859-1,UTF-8,".indexOf(("," + encoding.toUpperCase() + ",")) < 0) {
                    basePage.writeMessage(request, response, language, new String[]
                            { "401", encoding, "encoding" } );
                } else if (basePage.getFormFileCount() <= 0) { // no file was uploaded
                    basePage.writeMessage(request, response, language, new String[] { "406" } );
                } else {
                    (new IndexPage()).dialog(request, response, basePage);
                } // there was an uploaded file

            } else if (view.equals("table" ))   { // show the contents of table 'temp'
                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/classify.jsp");
                dispatcher.forward(request, response);

            } else if (view.equals("toggle"))   { // switch the attribute of a table element
                generateToggleResponse(request, response);

            } else {
                    basePage.writeMessage(request, response, language, new String[]
                            { "401", view, "view" } );
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

} // GrammarServlet
