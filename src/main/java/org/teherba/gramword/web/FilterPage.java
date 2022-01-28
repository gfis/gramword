/*  FilterPage.java - show the results of a filter
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
import  org.teherba.gramword.filter.FilterFactory;
import  org.teherba.common.web.BasePage;
import  org.teherba.xtrans.BaseTransformer;
import  org.teherba.xtrans.XMLTransformer;
import  java.io.PrintWriter;
import  java.io.StringReader;
import  java.io.Serializable;
import  javax.servlet.http.HttpServletRequest;
import  javax.servlet.http.HttpServletResponse;
import  org.apache.commons.fileupload.FileItem;
import  org.apache.logging.log4j.Logger;
import  org.apache.logging.log4j.LogManager;

/** Determines the proper filter for serialization,
 *  starts a transformation with that filter,
 *  and shows the web page with the response.
 *  @author Dr. Georg Fischer
 */
public class FilterPage implements Serializable {
    public final static String CVSID = "@(#) $Id: 57d01d0860aef0c2f2783647be70c3c381710c86 $";
    public final static long serialVersionUID = 19470629;

    /** log4j logger (category) */
    private Logger log;

    /** No-args Constructor
     */
    public FilterPage() {
        log = LogManager.getLogger(FilterPage.class.getName());
    } // Constructor

    /** Determines the proper filter for serialization,
     *  starts a transformation with that filter,
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
            String filter   = basePage.getFormField("filter"    );
            String format   = basePage.getFormField("format"    );
            String grammar  = basePage.getFormField("grammar"   );
            String language = basePage.getFormField("lang"      );
            String strategy = basePage.getFormField("strat"     );

            FilterFactory factory = new FilterFactory();
            BaseTransformer generator  = factory.getTransformer("xml");
            BaseTransformer serializer = factory.getTransformer(filter);
            if (generator == null) { // not found - bad software configuration
                basePage.writeMessage(request, response, language, new String[] { "401", "filter", filter } );
            } else { // generator was found
                generator .setSourceEncoding(encoding);
                serializer.setResultEncoding("UTF-8");
                response  .setCharacterEncoding(serializer.getResultEncoding());
            //  response  .setContentType(generator.getMimeType());
                response.  setContentType("text/html");
                generator .setCharReader(new StringReader(fileItem.getString(generator.getSourceEncoding())));
                serializer.setCharWriter(response.getWriter      ());
                generator .setCharWriter(serializer.getCharWriter());
                generator .setContentHandler(serializer);
                serializer.setContentHandler(generator );
            /*
                PrintWriter out = basePage.writeHeader(request, response, language);
                out.write("<title>" + basePage.getAppName() + " Filter Result</title>\n");
                out.write("</head>\n<body>\n");
            */
                generator .generate();
                generator .closeAll();
                serializer.closeAll();
            } // valid generator
            // basePage.writeTrailer(language, "quest");
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
        FilterPage help = new FilterPage();
        System.out.println("no messages");
    } // main

} // FilterPage
