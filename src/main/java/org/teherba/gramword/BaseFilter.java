/*  Superclass for all types of word filters
    @(#) $Id: BaseFilter.java 36 2008-09-08 06:05:06Z gfis $
	2008-02-13: Java 1.5 types    
    2007-02-21: copied from GrammarFilter
    must be stored in UTF-8 encoding äöüÄÖÜß!
*/
/*
 * Copyright 2007 Dr. Georg Fischer <punctum at punctum dot kom>
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
import  org.teherba.gramword.Morphem;
import  org.teherba.gramword.MorphemTester;
import  java.io.FileInputStream;
import  java.io.FileOutputStream;
import  java.io.BufferedReader;
import  java.io.Reader;
import  java.io.PrintWriter;
import  java.nio.channels.Channels;
import  java.nio.channels.ReadableByteChannel;
import  java.nio.channels.WritableByteChannel;
import  java.text.DecimalFormat;
import  java.util.Iterator;
import  java.util.regex.Pattern;
import  java.util.TreeMap;
import  javax.xml.parsers.SAXParser;
import  javax.xml.parsers.SAXParserFactory;
import  org.xml.sax.ext.DefaultHandler2;
import  org.xml.sax.InputSource;
import  org.apache.log4j.Logger;

/** Superclass for all types of word filters
 *  @author Dr. Georg Fischer
 */
public class BaseFilter extends DefaultHandler2 { 
    public final static String CVSID = "@(#) $Id: BaseFilter.java 36 2008-09-08 06:05:06Z gfis $";

    /** Newline string (CR+LF for Windows, LF for Unix) */
    protected String nl;

    /** Level of test output (0 = none, 1 = some, 2 = more ...) */
    protected int debug = 0;
    /** log4j logger (category) */
    protected Logger log;
    
    /** Regular Expression Pattern for punctuation at the end of a sentence */
    protected Pattern sentenceTerminator;
    /** Regular Expression Pattern for word boundary */ 
    protected Pattern wordBoundary;
    /** Regular Expression Pattern for word start */    
    protected Pattern wordStart;
    /** Regular Expression Pattern for uppercase word start */  
    protected Pattern wordUpperCase;
    
    /** Number of words read from a file */
    protected int cntWords;
    /** Number of words recognized */
    protected int cntKnown;
    
    /** Classificator used to determine morphologies of words */
    protected MorphemTester tester;

    /** Reader for the input file */
    protected Reader reader;
    /** Writer for the output file (maybe set by servlet) */
    protected PrintWriter writer;
    /** Output format */
    protected String mode;
    /** Natural language of the input text */
    protected String language;
    /** Encoding of the input file */
    protected String encoding;
    /** Strategy to be used to classify the words */
    protected String strategy;
    /** SAX handler for XML input file parsing */
    protected DefaultHandler2 handler;
    
    /** Whether at start of sentence (word is uppercased) */
    protected boolean sentenceStart;

    /** Stores the occurrences of various morphem */
    protected TreeMap/*<1.5*/<String, Integer>/*1.5>*/ morphCounts;

    /** No-args Constructor
     */
    public BaseFilter() {
        log = Logger.getLogger(BaseFilter.class.getName());
        nl  = System.getProperty("line.separator");
        sentenceTerminator  = Pattern.compile("[\\.\\:\\!\\?\\»]");
        wordBoundary        = Pattern.compile("\\b");
        wordStart           = Pattern.compile("[a-zA-Z0-9äöüÄÖÜ]");
        wordUpperCase       = Pattern.compile("[A-ZÄÖÜ]");
        cntWords        = 0;
        cntKnown        = 0;
        sentenceStart   = true;
        handler         = null;     // SAX handler is undefined so far
        mode            = "html";   // default output mode
        language        = "de";     // default source language
        encoding        = "ISO-8859-1"; // default input encoding (output is always in UTF-8)
        strategy        = "all";    // default: apply all tests
        tester          = null;
        morphCounts     = new TreeMap/*<1.5*/<String, Integer>/*1.5>*/();
    } // Constructor

    /** Increments the count for the specified morphem type.
     *  @param morph type of morphem, Aj, Vb ...
     */
    protected void morphIncr(String morph) { 
        Object value = morphCounts.get(morph);
        morphCounts.put(morph, new Integer ((value == null) 
                ? 1 
                : ((Integer) value).intValue() + 1));
    } // morphIncr

    /** Sets the reader for the input stream 
     *  @param reader reader to be used for the input stream
     */
    public void setReader(Reader reader) {
        this.reader = reader;
    } // setReader
    
    /** Sets the writer for the output stream 
     *  @param writer writer to be used for the output stream
     */
    public void setWriter(PrintWriter writer) {
        this.writer = writer;
    } // setWriter
    
    /** Gets the writer for the output stream 
     *  @return writer to be used for the output stream
     */
    public PrintWriter getWriter() {
        return this.writer;
    } // getWriter
    
    /** Evaluates the arguments of the command line, and processes them.
     *  @param args Arguments; if missing, print the following:
     *  <pre>
     *  usage:\tjava org.teherba.gramword.BaseFilter [-e encoding] [-l iso] [-m mode] [-s strategy] file 
     *  -e  ISO-8859-1 (default), UTF-8 : input encoding
     *  -l  de (default) : source language
     *  -m  html (default) | text | dict : output mode
     *  -s  all (default) | prsplit | sasplit : strategy for word recognition
     *  </pre>
     */
    public void getOptions(String args[]) {
        try {
            int iarg = 0;
            if (iarg >= args.length) { // usage, with known ISO codes and languages
                System.err.println("usage:\tjava org.teherba.gramword.BaseFilter "
                        + " [-e encoding] [-l iso] [-m mode] [-s strategy] [infile [outfile]]");
                System.out.println("  -e ISO-8859-1 (default) | UTF-8 : source encoding ");
                System.out.println("  -l source language code (default 'de')");
                System.out.println("  -m html(default) | text | dict : output mode ");
                System.out.println("  -s all (default) | prsplit | sasplit : strategy for word recognition");
            } else { // >= 1 argument 
                
                // get all options
                while (iarg < args.length && args[iarg].startsWith("-")) {
                    String option = args[iarg ++].substring(1);
                    if (false) {
                    } else if (option.startsWith("e")) {
                        if (iarg < args.length) {
                            encoding = args[iarg ++];
                        }
                    } else if (option.startsWith("l")) {
                        if (iarg < args.length) {
                            language = args[iarg ++];
                        }
                    } else if (option.startsWith("m")) {
                        if (iarg < args.length) {
                            mode = args[iarg ++];
                        }
                    } else if (option.startsWith("s")) {
                        if (iarg < args.length) {
                            strategy = args[iarg ++];
                        }
                    }
                } // while options
                
                if (iarg < args.length) { // with 1 or 2 additional (filename) arguments
                    ReadableByteChannel source = iarg < args.length 
                            ? (new FileInputStream (args[iarg ++])).getChannel()
                            : Channels.newChannel(System.in);
                    WritableByteChannel target = iarg < args.length 
                            ? (new FileOutputStream (args[iarg ++])).getChannel()
                            : Channels.newChannel(System.out);
                    reader = new BufferedReader(Channels.newReader(source, encoding));
                    writer = new PrintWriter   (Channels.newWriter(target, "UTF-8"));
                }
            } // args.length >= 1
        } catch (Exception exc) {
            log.error(exc.getMessage(), exc);
        }
    } // getOptions

    //--------------------------------------------------
    /** Sets the SAX handler
     *  @param handler a format specific SAX handler which 
     *  generates the output format 
     */
    public void setHandler(DefaultHandler2 handler) {
        this.handler = handler;
    } // setHandler

    /** Transforms from XML to the specified format
     *  @return whether the transformation was successful
     */
    public boolean serialize() {
        boolean result = true;
        if (handler == null) {
            log.error("BaseFilter.serialize - not implemented");
            result = false;
        } else {
            try {
                SAXParser saxParser = SAXParserFactory.newInstance().newSAXParser();
                saxParser.parse(new InputSource(reader), handler);
            } catch (Exception exc) {
                log.error(exc.getMessage(), exc);
                result = false;
            }
        }
        return result;
    } // serialize

} // BaseFilter
