/*  Servlet which checks the parameters and calls pages for different views
    @(#) $Id: GramwordServlet.java 976 2013-02-02 16:44:18Z gfis $
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
import  org.teherba.gramword.web.GrammarPage;
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
            String lang = "en";
            String view = basePage.getFilesAndFields(request, new String[]
                    { "view"    , "index"
                    , "lang"    , "en"   // user interface
                    , "language", "de"   // of input file
                    , "format"  , "html"
                    , "encoding", "UTF-8"
                    , "strategy", "all"
                    } );
            lang            = basePage.getFormField("lang"      );
            String language = basePage.getFormField("language"  );
            String format   = basePage.getFormField("format"    );
            String encoding = basePage.getFormField("encoding"  );
            String strategy = basePage.getFormField("strategy"  );
            if (false) {

            } else if (view.equals("index"   ))   { // start page
                    (new IndexPage()).dialog(request, response, basePage);

            } else if (view.equals("grammar" ))   { // former result page
                log.info("view=" + view + ", language=" + language + ", format=" + format + ", encoding=" + encoding + ",strategy=" + strategy);
                String fileName = "";
                if (false) {
                } else if (",html,text,dict,".indexOf("," + format + ",") < 0) {
                    basePage.writeMessage(request, response, lang, new String[]
                            { "401", format, "format" } );
                } else if (",de,".indexOf("," + language + ",") < 0) {
                    basePage.writeMessage(request, response, lang, new String[]
                            { "401", language, "language" } );
                } else if (",all,prsplit,sasplit,".indexOf("," + strategy + ",") < 0) {
                    basePage.writeMessage(request, response, lang, new String[]
                            { "401", strategy, "strategy" } );
                } else if (",ISO-8859-1,UTF-8,".indexOf(("," + encoding.toUpperCase() + ",")) < 0) {
                    basePage.writeMessage(request, response, lang, new String[]
                            { "401", encoding, "encoding" } );
                } else if (basePage.getFormFileCount() <= 0) { // no file was uploaded
                    basePage.writeMessage(request, response, lang, new String[] { "406" } );
                } else {
                    (new GrammarPage()).dialog(request, response, basePage);
                } // there was an uploaded file
         /*
            } else if (view.equals("index2")) { // do the main transform
                String options = ""; //  = "-test 2 ";
                int ifmt  = 0;
                int ifile = 0;
                // get all commandline parameters
                while (iarg < args.length) {
                    log.debug("args[" + iarg + "]=\"" + args[iarg] + "\"");
                    if (args[iarg].length() == 0) { // parameter String[]
                        iarg ++;
                    } else if (args[iarg].startsWith("-")) { // is an option
                        String option = args[iarg ++].substring(1); // without the hyphen
                        BaseTransformer base = factory.getTransformer(option);
                        if (base != null) { // valid format code
                            if (ifmt < MAX_FILE) {
                                if (ifmt == 0) {
                                    generator  = base;
                                } else {
                                    serializer = base;
                                }
                                ifmt ++;
                            }
                        } else { // other option
                            String value = "1";
                            if (iarg < args.length && ! args[iarg].startsWith("-")) {
                                value = args[iarg ++];
                            }
                            options += "-" + option + " " + value + " ";
                            // log.debug("addOption(\"" + option + "\", \"" + value + "\");");
                        }
                    } else { // no option -> filename
                        if (ifile < MAX_FILE) {
                            fileNames[ifile ++] = args[iarg];
                        }
                        iarg ++;
                    }
                } // while commandline
                
                generator  = factory.getTransformer(format); // try whether the format is valid
                if (generator == null) {
                    basePage.writeMessage(request, response, lang, new String[] { "401", "format", format } );
                } else { // valid generator
                    serializer   = factory.getTransformer(resultFormat); // xml
                    generator .parseOptionString(options);
                    generator .setSourceEncoding(generator .getOption("enc1", "UTF-8")); // should be symmetrical for testing
                    serializer.parseOptionString(options);
                    serializer.setResultEncoding(serializer.getOption("enc2", "UTF-8"));
                    generator .setContentHandler(serializer);
                    generator .setLexicalHandler(serializer);
                    response.setCharacterEncoding(serializer.getResultEncoding());

                    this.doTransform(generator, serializer, fileItem, intext, response);
                } // valid generator
        */
            } else if (view.equals("table" ))   { // show the contents of table 'temp'
                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/classify.jsp");
                dispatcher.forward(request, response);

            } else if (view.equals("toggle"))   { // switch the attribute of a table element
                generateToggleResponse(request, response);

            } else if (view.equals("license")
                    || view.equals("manifest")
                    || view.equals("notice")
                    ) {
                lang            = basePage.getFormField("lang"      );
                (new MetaInfPage()).showMetaInf (request, response, basePage, lang, view, this);

            } else {
                lang            = basePage.getFormField("lang"      );
                basePage.writeMessage(request, response, lang, new String[] { "401", view, "view" });
            }
        } catch (Exception exc) {
            log.error(exc.getMessage(), exc);
        }
    } // generateResponse

    /** Runs the transformation.
     *  @param generator parser for the input format
     *  @param serializer generates the output format
     *  @param fileItem handle for an uploaded file
     *  @param intext input String from a form field, overtakes <em>fileItem</em> if non-empty
     *  @param response wher to write the output
     */
    private void doTransform(BaseTransformer generator
            , BaseTransformer serializer
            , FileItem fileItem
            , String intext
            , HttpServletResponse response
            ) {
        try {
            if (serializer instanceof XMLTransformer) {
                generator.setMimeType("text/xml"); // is needed sometimes because of "&amp;" multiplication
                response.setHeader("Content-Disposition", "inline; filename=\"" + fileItem.getName() + ".xml\"");
                // to XML
            } else { // from XML
                String name = fileItem.getName();
                name = (name.endsWith(".xml"))
                        ? name.substring(0, name.length() - 4) // remove ".xml"
                        : name + "." + generator.getFileExtension(); // append default extension
                response.setHeader("Content-Disposition", "attachment; filename=\"" + name + "\"");
            } // from XML
            
            response.setContentType(generator.getMimeType());
            generator.setCharReader(new StringReader(fileItem.getString(generator.getSourceEncoding())));
            serializer.setCharWriter(response.getWriter      ());
            generator.generate();
            generator .closeAll();
            serializer.closeAll();
            /*
                    ifile = 0;
                    generator .parseOptionString(options);
                    generator .openFile(ifile, fileNames[ifile]);
                    ifile ++;
                    serializer.parseOptionString(options);
                    serializer.openFile(ifile, fileNames[ifile]);
                    generator.setCharWriter(serializer.getCharWriter());

                    generator .setContentHandler(serializer);
                    serializer.setContentHandler(generator );
                    generator .generate();

                    generator .closeAll();
                    serializer.closeAll();
            */
        } catch (Exception exc) {
            log.error(exc.getMessage(), exc);
        }
    } // doTransform
    
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
