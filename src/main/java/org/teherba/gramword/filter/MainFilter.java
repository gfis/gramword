/*  Commandline tool which
 *  transforms various file formats to and from XML.
 *  @(#) $Id: MainFilter.java 36 2008-09-08 06:05:06Z gfis $
 *  Copyright (c) 2007 Dr. Georg Fischer <punctum@punctum.com>
 *  2016-09-19: old package name was gramword
 *  2007-04-04: tested with XMLTransformer
 *  2007-02-27: copied from xtrans.MainTransformer
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

package org.teherba.gramword.filter;
import  org.teherba.gramword.filter.FilterFactory;
import  org.teherba.xtrans.BaseTransformer;
import  java.util.ArrayList;
import  java.util.Iterator;
import  org.apache.logging.log4j.Logger;
import  org.apache.logging.log4j.LogManager;

/** Commandline tool for the transformation of various file formats
 *  to and from XML.
 *  @author Dr. Georg Fischer
 */
public class MainFilter {
    public final static String CVSID = "@(#) $Id: MainFilter.java 36 2008-09-08 06:05:06Z gfis $";

    /** log4j logger (category) */
    private Logger log;

    /** Factory for transformers for different file formats */
    private FilterFactory factory = null;

    /**
     *  Constructor
     */
    public MainFilter() {
        log = LogManager.getLogger(MainFilter.class.getName());
        factory = new FilterFactory();
    } // MainFilter

    /** maximum number of files / formats / encodings */
    private static final int MAX_FILE = 2;
    /**
     *  Processes the commandline arguments and calls the applicable transformer
     *  @param args commandline arguments as strings
     */
    public void processArgs(String args[]) {
        try {
            BaseTransformer generator   = null;
            BaseTransformer serializer  = null;
            int iarg = 0; // index for command line arguments
            if (iarg >= args.length) { // usage, with known ISO codes and formats
                System.out.println("usage:\tjava org.teherba.gramword.MainFilter "
                        + " [-enc1 srcenc [-enc2 tarenc]]"
                        + " [-nsp namespace]"
                        + " [-xml] [-outformat]"
                        + " [infile [outfile]]");
                Iterator fiter = factory.getIterator();
                while (fiter.hasNext()) {
                    generator = (BaseTransformer) fiter.next();
                    System.out.println(String.format("    %-10s %s"
                            , generator.getFirstFormatCode()
                            , generator.getDescription    ()));
                } // while fiter
            } else { // >= 1 argument
                String[] fileNames = new String[] {null, null};
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
                if (generator == null || serializer == null) {
                    log.error("no known transformation format");
                } else {
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
                }
            } // args.length >= 1
        } catch (Exception exc) {
            log.error(exc.getMessage(), exc);
            exc.printStackTrace();
        }
    } // processArgs

    /** Main program, processes the commandline arguments
     *  @param args Arguments; if missing, print the following:
     *  <pre>
     *  usage:\tjava org.teherba.xtrans.MainFilter
     *  [-enc1 srcenc [-enc2 tarenc]]
     *  [-nsp namespace]
     *  [-informat|-xml] [-xml|-outformat]
     *  [infile [outfile]]
     *  </pre>
     */
    public static void main(String args[]) {
        (new MainFilter()).processArgs(args);
    } // main

} // MainFilter
