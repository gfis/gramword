/*  Servlet which
    checks the parameters and calls GrammarFilter
    @(#) $Id: GrammarServlet.java 976 2013-02-02 16:44:18Z gfis $
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

package org.teherba.gramword;
import  org.teherba.gramword.GrammarFilter;
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

    /** log4j logger (category) */
    private Logger log;

    /** Debugging switch */
    private static int debug = 1;

    /** Maps connection identifiers (short database instance ids) to {@link DataSource Datasources} */
    // private HashMap/*<1.5*/<String, DataSource>/*1.5>*/ dsMap;
    private LinkedHashMap dsMap;

    /** Called by the servlet container to indicate to a servlet
     *  that the servlet is being placed into service.
     *  @param config object containing the servlet's configuration and initialization parameters
     *  @throws ServletException
     */
    public void init() throws ServletException {
        // super.init(config); // ???
        log = Logger.getLogger(GrammarServlet.class.getName());
        ServletContext context = getServletContext();
        try {
        //  dsMap = (HashMap/*<1.5*/<String, DataSource>/*1.5>*/) getServletContext().getAttribute("dsMap");
            dsMap = (LinkedHashMap) getServletContext().getAttribute("dsMap");
        } catch (Exception exc) {
            log.error(exc.getMessage(), exc);
        }
    } // init()

    /** Database configuration */
    private Configuration config;

    /** Sets the DataSource appropriate for a web call
     *  @param config instance to be configured
     */
    @SuppressWarnings(value="unchecked")
    private void uncheckedConfigure(Configuration config) {
        config.configure(config.WEB_CALL, dsMap);
    } // uncheckedConfigure

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

    /** Gets the value of an HTML input field, maybe as empty string
     *  @param request request for the HTML form
     *  @param name name of the input field
     *  @return non-null (but possibly empty) string value of the input field
     */
    private String getInputField(HttpServletRequest request, String name) {
        String value = request.getParameter(name);
        if (value == null) {
            value = "";
        }
        else if (value.length() > 256) { // sufficient for this application
            value = value.substring(0, 256);
        }
        return value;
    } // getInputField

    /** Creates the response for a HTTP GET or POST request.
     *  @param request fields from the client input form
     *  @param response data to be sent back the user's browser
     *  @throws IOException
     */
    public void generateResponse(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            String view = getInputField(request, "view");
            if (false) {
            } else if (view.equals("index" ))   { // introductory page
                generateIndexResponse (request, response);
            } else if (view.equals("table" ))   { // show the contents of table 'temp'
                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/classify.jsp");
                dispatcher.forward(request, response);
            } else if (view.equals("toggle"))   { // switch the attribute of a table element
                generateToggleResponse(request, response);
            } else {
                // generateIndexResponse (request, response);
            }
        } catch (Exception exc) {
            log.error(exc.getMessage(), exc);
        }
    } // generateResponse

    /** Creates the response for the introductory page.
     *  @param request fields from the client input form
     *  @param response data to be sent back the user's browser
     */
    public void generateIndexResponse(HttpServletRequest request, HttpServletResponse response) {
        try {
            String newPage      = ""; // no error so far
            HttpSession session = request.getSession();
            String format       = "html";
            String fileName     = "";
            String language     = "de";
            String encoding     = "UTF-8";
            String strategy     = "all";

            FileItemFactory fuFactory = new DiskFileItemFactory(); // Create a factory for disk-based file items
            ServletFileUpload upload = new ServletFileUpload(fuFactory); // Create a new file upload handler
            List /* FileItem */ items = upload.parseRequest(request); // Parse the request
            FileItem fileItem = null; // not seen so far
            Iterator iter = items.iterator();
            while (iter.hasNext()) { // Process the uploaded items
                FileItem item = (FileItem) iter.next();
                if (item.isFormField()) {
                    String name  = item.getFieldName();
                    String value = item.getString();
                    session.setAttribute(name, value);
                    if (false) {
                    } else if (name.equals("mode" )) {
                        format = value;
                        if (",html,text,dict,".indexOf("," + format + ",") < 0) {
                            newPage = "/message.jsp";
                            session.setAttribute("messno"  , "004"); // invalid format code
                        }
                    } else if (name.equals("lang")) {
                        language = value;
                        if (",de,".indexOf("," + language + ",") < 0) {
                            newPage = "/message.jsp";
                            session.setAttribute("messno"  , "003"); // invalid language code
                        }
                    } else if (name.equals("strat")) {
                        strategy = value;
                        if (",all,prsplit,sasplit,".indexOf("," + strategy + ",") < 0) {
                            newPage = "/message.jsp";
                            session.setAttribute("messno"  , "001"); // invalid strategy
                        }
                    } else if (name.equals("enc")) {
                         encoding = value;
                         if (",ISO-8859-1,UTF-8,".indexOf(("," + encoding + ",").toUpperCase()) < 0) {
                            newPage = "/message.jsp";
                            session.setAttribute("messno"  , "006"); // invalid encoding
                        }
                    } else { // unknown field name
                    }
                } else {
                    fileItem = item;
                }
            } // while uploaded items
            response.setCharacterEncoding(encoding);

            if (debug >= 1) {
                log.info("GrammarServlet.generateResponse"
                        + ", format=\"" + format + "\""
                        + ", lang=\""   + language + "\""
                        + ", strat=\"" + strategy + "\""
                        + ", enc=\"" + encoding + "\""
                        + ", infile=\"" + fileItem.getName() + "\""
                        + ", newPage=\"" + newPage + "\""
                        );
            }

            if (newPage.length() > 0) { // fall through
            } else if (fileItem == null) { // no file was uploaded
                newPage = "/message.jsp";
                session.setAttribute("messno"  , "005");
            } else {
                GrammarFilter filter = new GrammarFilter();
                response.setHeader("Content-Disposition", "inline; filename=\""
                        + fileItem.getName() + ".xml\"");
                response.setContentType("text/" + (format.equals("html") ? "html" : "plain"));
                // System.out.println("GrammarServlet.startFilter");
                filter.getOptions(new String []
                    { "-l", language
                    , "-m", format
                    , "-e", encoding
                    , "-s", strategy
                    });
                filter.setReader(new StringReader(fileItem.getString(encoding)));
                filter.setWriter(response.getWriter());
                filter.process(new String[] { fileItem.getName() });
                if (debug >= 1) {
                    response.getWriter().write("\n\n" + fileItem.getString(encoding));
                    response.getWriter().write("GrammarServlet.endFilter");
                }
            } // there was an uploaded file

            if (newPage.length() > 0) { // error message
                // System.out.println("newPage=\"" + newPage + "\", messno=" + session.getAttribute("messno"));
                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(newPage);
                dispatcher.forward(request, response);
            }
        } catch (Exception exc) {
            log.error(exc.getMessage(), exc);
        }
    } // generateIndexResponse

    /** Creates the response for a toggle request form JavaScript/Ajax.
     *  @param request fields from the client input form
     *  @param response data to be sent back the user's browser
     */
    public void generateToggleResponse(HttpServletRequest request, HttpServletResponse response) {
        config = new Configuration();
        uncheckedConfigure(config);
        Connection con = null;
        PreparedStatement selectStmt = null;
        PreparedStatement updateStmt = null;
        try {
            con = config.getOpenConnection();
            selectStmt = con.prepareStatement("SELECT enrel FROM    temp where entry = ?");
            response.setContentType("text/plain");
            String id    = getInputField(request, "id");
            String entry = getInputField(request, "entry");
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
            config.closeConnection();
        }
    } // generateToggleResponse

} // GrammarServlet
