/*  GrammarPage.java - main web page for GramWord
 *  @(#) $Id: 57d01d0860aef0c2f2783647be70c3c381710c86 $
 *  2016-09-19, Dr. Georg Fischer: adopted from xslTrans.jsp
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
import  org.teherba.gramword.filter.GrammarFilter;
import  org.teherba.gramword.filter.WordTypeFilter;
import  org.teherba.common.web.BasePage;
import  java.io.PrintWriter;
import  java.io.StringReader;
import  java.io.Serializable;
import  java.util.Iterator;
import  javax.servlet.http.HttpServletRequest;
import  javax.servlet.http.HttpServletResponse;
import  org.apache.commons.fileupload.FileItem;
import  org.apache.log4j.Logger;

/** Xtrans main dialog page
 *  @author Dr. Georg Fischer
 */
public class GrammarPage implements Serializable {
    public final static String CVSID = "@(#) $Id: 57d01d0860aef0c2f2783647be70c3c381710c86 $";
    public final static long serialVersionUID = 19470629;

    /** log4j logger (category) */
    private Logger log;

    /** No-args Constructor
     */
    public GrammarPage() {
        log = Logger.getLogger(GrammarPage.class.getName());
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
            FileItem fileItem = basePage.getFormFile(0);
            String language = basePage.getFormField("language"  );
            String format   = basePage.getFormField("format"    );
            String encoding = basePage.getFormField("encoding"  );
            String strategy = basePage.getFormField("strategy"  );
            response.setHeader("Content-Disposition", "inline; filename=\""
                    + fileItem.getName() + ".xml\"");

            PrintWriter out = basePage.writeHeader(request, response, language);
            out.write("<title>" + basePage.getAppName() + " Main Page</title>\n");
            out.write("</head>\n<body>\n");
            GrammarFilter filter = new GrammarFilter();
            // WordTypeFilter filter = new WordTypeFilter();
            // filter.initialize();
            filter.getOptions(new String []
                { "-l", language
                , "-m", format
                , "-e", encoding
                , "-s", strategy
                });
            filter.setReader(new StringReader(fileItem.getString(encoding)));
            filter.setWriter(out);
            filter.process(new String[] { fileItem.getName() });
            basePage.writeTrailer(language, "quest");
        } catch (Exception exc) {
            log.error(exc.getMessage(), exc);
        }
    } // dialog

    /** Write the common part of the form with thr input fields.
     *  <ul>
     *  <li>options</li>
     *  <li>namespace</li>
     *  <li>source encoding</li>
     *  <li>target encoding</li>
     *  <li>name of input file</li>
     *  <li>input field</li>
     *  </ul>
     *  @param out PrintWriter for response
     *
     */
    public static void writeFormOptions(BasePage basePage, PrintWriter out
            , String language
            , String dir
            , String options
            , String namespace
            , String enc1
            , String enc2
            , String infile
            , String intext
        ) {
        String border = "0";
        int index = 0;
        String[] optDir     = new String []
                { "to"          // 0
                , "from"        // 1
                } ;
        String[] enDir      = new String []
                { "to"          // 0
                , "from"        // 1
                } ;
        String[] optTarget  = new String []
                { "xml"         // 0
                } ;
        String[] enTarget   = new String []
                { "XML"         // 0
                } ;
        String[] optEnc     = new String []
                { "UTF-8"       // 0
                , "ISO-8859-1"  // 1
                } ;
        String[] enEnc      = new String []
                { "UTF-8"       // 0
                , "ISO-8859-1"  // 1
                } ;

        out.write("                <table border=\"" + border + "\">\n");
        out.write("                    <tr>\n");
        out.write("                    <td>\n");
        out.write("                        <table border=\"" + border  + "\">\n");
                                           if (dir != null && dir.length() > 0) { // with dir
        out.write("                            <tr>\n");
        out.write("                                <td>\n");
        out.write("                                    <select name=\"dir\" size=\"" +  optDir.length  + "\">\n");
                                                       index = 0;
                                                       while (index < optDir.length) {
                                                           out.write("<option value=\""
                                                                   + optDir[index] + "\""
                                                                   + (optDir[index].equals(dir) ? " selected" : "")
                                                                   + ">"
                                                                   + enDir[index] + "</option>\n");
                                                           index ++;
                                                       } // while index
        out.write("                                    </select>\n");
        out.write("                                </td>\n");
        out.write("                                <td>\n");
        out.write("                                    <strong>XML</strong>"); // target
        out.write("                                </td>\n");
        out.write("                                <td>    \n");
        out.write("                                </td>\n");
        out.write("                            </tr>\n");
                                           } // with dir

        out.write("                            <tr>\n");
        out.write("                                <td colspan=\"3\">\n");
        out.write("                                    Options<br />\n");
        out.write("                                    <input name=\"opt\" maxsize=\"80\" size=\"40\" value=\"" + options + "\" />\n");
        out.write("                                </td>\n");
        out.write("                            </tr>\n");
        out.write("                            <tr>\n");
        out.write("                                <td colspan=\"3\">\n");
        out.write("                                    Namespace<br /> \n");
        out.write("                                    <input name=\"nsp\" maxsize=\"20\" size=\"40\" value=\"" + namespace + "\" />\n");
        out.write("                                </td>\n");
        out.write("                            </tr>\n");

        out.write("                            <tr>\n");
        out.write("                                <td>Source Encoding<br /> \n");
        out.write("                                    <select name=\"enc1\" size=\"" + optEnc.length + "\">\n");
                                                       index = 0;
                                                       while (index < optEnc.length) {
                                                           out.write("<option value=\""
                                                                   + optEnc[index] + "\""
                                                                   + (optEnc[index].equals(enc1) ? " selected" : "")
                                                                   + ">"
                                                                   + enEnc[index] + "</option>\n");
                                                           index ++;
                                                       } // while index
        out.write("                                    </select>\n");
        out.write("                                </td>\n");
        out.write("                                <td>Target Encoding<br /> \n");
        out.write("                                    <select name=\"enc2\" size=\"" + optEnc.length + "\">\n");
                                                       index = 0;
                                                       while (index < optEnc.length) {
                                                           out.write("<option value=\""
                                                                   + optEnc[index] + "\""
                                                                   + (optEnc[index].equals(enc2) ? " selected" : "")
                                                                   + ">"
                                                                   + enEnc[index] + "</option>\n");
                                                           index ++;
                                                       } // while index
        out.write("                                    </select>\n");
        out.write("                                </td>\n");
        out.write("                                <td>    \n");
        out.write("                                </td>\n");
        out.write("                            </tr>\n");

        out.write("                        </table>\n");
        out.write("                    </td>\n");
        out.write("                    <td>\n");
        out.write("                        <p />\n");

        out.write("                    </td>\n");
        out.write("                    </tr>\n");
        out.write("                    <tr>\n");
        out.write("                        <td colspan=\"3\">\n");
        out.write("                            <table border=\"" + border + "\">\n");
        out.write("                                <tr>\n");
        out.write("                                    <td>\n");
        out.write("                                    Name of Input File<br />\n");
        out.write("                                    <input name=\"infile\" type=\"file\" style=\"font-family: Courier, monospace\" \n");
        out.write("                                            maxsize=\"512\" size=\"80\" value=\"" + infile + "\"/> \n");
        out.write("                                    &nbsp;&nbsp;<em><strong>or</strong></em>\n");
        out.write("                                    <br />Input source text (non-binary formats only)<br />\n");
        out.write("                                    <textarea name=\"intext\" cols=\"80\" rows=\"10\">" + intext + "</textarea>\n");
        out.write("                                    <br /><input type=\"submit\" value=\"Transform\" />\n");
        out.write("                                    </td>\n");
        out.write("                                </tr>\n");
        out.write("                            </table>\n");
        out.write("                        </td>\n");
        out.write("                    </tr>\n");
        out.write("                    <tr>\n");
        out.write("                        <td colspan=\"3\">\n");
                                               basePage.writeAuxiliaryLinks(language, "main");
        out.write("                        </td>\n");
        out.write("                    </tr>\n");
        out.write("                </table>\n");
    } // writeFormOptions

    //================
    // Main method
    //================

    /** Test driver
     *  @param args language code: "en", "de"
     */
    public static void main(String[] args) {
        GrammarPage help = new GrammarPage();
        System.out.println("no messages");
    } // main

} // GrammarPage
