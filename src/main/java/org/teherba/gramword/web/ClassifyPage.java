/*  IndexPage.java - main web page for GramwWord
 *  @(#) $Id: 57d01d0860aef0c2f2783647be70c3c381710c86 $
 *  2016-09-12, Dr. Georg Fischer: adopted from xslTrans.jsp
 *  2011-04-06: MultiFormatFactory
 *  2008-07-30: svn tests
 *  2008-05-31: with field 'view'
 *  2006-10-13: copied from numword
 */
/*
 * Copyright 2016 Dr. Georg Fischer <punctum at punctum dot kom>
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
import  org.teherba.common.web.BasePage;
import  org.teherba.dbat.Configuration;
import  java.io.PrintWriter;
import  java.io.Serializable;
import  java.util.Iterator;
import  java.sql.Connection;
import  java.sql.PreparedStatement;
import  java.sql.ResultSet;
import  java.util.Iterator;
import  javax.servlet.http.HttpServletRequest;
import  javax.servlet.http.HttpServletResponse;
import  javax.servlet.http.HttpSession;
import  org.apache.logging.log4j.Logger;
import  org.apache.logging.log4j.LogManager;

/** Xtrans main dialog page
 *  @author Dr. Georg Fischer
 */
public class ClassifyPage implements Serializable {
    public final static String CVSID = "@(#) $Id: 57d01d0860aef0c2f2783647be70c3c381710c86 $";
    public final static long serialVersionUID = 19470629;

    /** log4j logger (category) */
    private Logger log;

    /** No-args Constructor
     */
    public ClassifyPage() {
        log      = LogManager.getLogger(ClassifyPage.class.getName());
    } // Constructor

    /** Output the main dialog page for Xtrans
     *  @param request request with header fields
     *  @param response response with writer
     *  @param basePage refrence to common methods and error messages
     */
    public void dialog(HttpServletRequest request, HttpServletResponse response
            , BasePage basePage
            ) {
        try {
            HttpSession session = request.getSession();
            Object 
            field = session.getAttribute("format"   );  String format       = (field != null) ? (String) field : "html";
            field = session.getAttribute("lang"     );  String language     = (field != null) ? (String) field : "de";
            field = session.getAttribute("enc"      );  String encoding     = (field != null) ? (String) field : "ISO-8859-1";
            field = session.getAttribute("strat"    );  String strategy     = (field != null) ? (String) field : "all";
            field = session.getAttribute("infile"   );  String infile       = (field != null) ? (String) field : "";
            PrintWriter out = basePage.writeHeader(request, response, language);
            out.write("<title>" + basePage.getAppName() + " Main Page</title>\n");
            out.write("</head>\n<body>\n");
            String border = "0";
            int index = 0;

            Configuration dbatConfig = new Configuration();
            dbatConfig.configure(dbatConfig.CLI_CALL);
            Connection con = dbatConfig.getOpenConnection();
            PreparedStatement pstmt = con.prepareStatement("SELECT entry, enrel FROM temp order by 1");
            pstmt.clearParameters();
            // pstmt.setString(1, word);
            ResultSet resultSet = pstmt.executeQuery();
            out.write("<!-- format=\"" + format + "\", encoding=\"" + encoding
                    + "\", strategy=\"" + strategy + "\" -->\n");
            out.write("<h2>Classify Words</h2>\n");
            out.write("<table cellpadding=\"0\" cellspacing=\"0\">\n"); 
            index = 0;
            boolean busy = true;
            while (resultSet.next()) { 
            	index ++;
            	String id = "L" + Integer.toString(index);
                String entry = resultSet.getString(1);
                String enrel = resultSet.getString(2);
             	out.write("<tr><td onclick=\"toggle(\'" + id + "\',\'" + entry + "\');\"><span id=\"" 
             			+ id + "\" class=\"" + enrel + "\">" + entry + "</span></td></tr>\n");
            } // while next()
            resultSet.close();
            pstmt.close();
            dbatConfig.closeConnection();
            out.write("</table>\n");        

            basePage.writeTrailer(language, "quest");
        } catch (Exception exc) {
            log.error(exc.getMessage(), exc);
        }
    } // dialog

    //================
    // Main method
    //================

    /** Test driver
     *  @param args language code: "en", "de"
     */
    public static void main(String[] args) {
        ClassifyPage help = new ClassifyPage();
        System.out.println("no messages");
    } // main

} // ClassifyPage
