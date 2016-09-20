/*  SimpleTypePage.java - show results from GrammarHandler
 *  @(#) $Id: 57d01d0860aef0c2f2783647be70c3c381710c86 $
 *  2016-09-20, Dr. Georg Fischer: former GrammarPage.java
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
import  org.teherba.gramword.handler.GrammarHandler;
import  org.teherba.common.web.BasePage;
import  java.io.PrintWriter;
import  java.io.StringReader;
import  java.io.Serializable;
import  java.util.Iterator;
import  javax.servlet.http.HttpServletRequest;
import  javax.servlet.http.HttpServletResponse;
import  org.apache.commons.fileupload.FileItem;
import  org.apache.log4j.Logger;

/** Starts a transformation with {@link GrammarHandler},
 *  and shows the web page with the response.
 *  This class is the predecessor for the filters bases on <em>QueueTransformer</em>.
 *  @author Dr. Georg Fischer
 */
public class SimpleTypePage implements Serializable {
    public final static String CVSID = "@(#) $Id: 57d01d0860aef0c2f2783647be70c3c381710c86 $";
    public final static long serialVersionUID = 19470629;

    /** log4j logger (category) */
    private Logger log;

    /** No-args Constructor
     */
    public SimpleTypePage() {
        log = Logger.getLogger(SimpleTypePage.class.getName());
    } // Constructor

    /** Starts a transformation with {@link GrammarHandler},
     *  and shows the web page with the response.
     *  @param request request with header fields
     *  @param response response with writer
     *  @param basePage reference to common methods and error messages
     */
    public void showResult(HttpServletRequest request, HttpServletResponse response
            , BasePage basePage
            ) {
        try {
            FileItem fileItem = basePage.getFormFile(0);
            String encoding = basePage.getFormField("enc"       );
            String format   = basePage.getFormField("format"    );
            String grammar  = basePage.getFormField("grammar"   );
            String language = basePage.getFormField("lang"      );
            String strategy = basePage.getFormField("strat"     );
            response.setHeader("Content-Disposition", "inline; filename=\""
                    + fileItem.getName() + ".xml\"");

            PrintWriter out = basePage.writeHeader(request, response, language);
            out.write("<title>" + basePage.getAppName() + " Handler Result</title>\n");
            out.write("</head>\n<body>\n");
            GrammarHandler handler = new GrammarHandler();
            handler.getOptions(new String []
                { "-l", grammar
                , "-m", format
                , "-e", encoding
                , "-s", strategy
                });
            handler.setReader(new StringReader(fileItem.getString(encoding)));
            handler.setWriter(out);
            handler.process(new String[] { fileItem.getName() });
            basePage.writeTrailer(language, "quest");
        } catch (Exception exc) {
            log.error(exc.getMessage(), exc);
        }
    } // showResult
    
    //================
    // Main method
    //================

    /** Test driver
     *  @param args language code: "en", "de"
     */
    public static void main(String[] args) {
        SimpleTypePage help = new SimpleTypePage();
        System.out.println("no messages");
    } // main

} // SimpleTypePage
