/*  Shows the syntactical type of words in an HTML file by different background colors
 *  must be stored in UTF-8 encoding äöüÄÖÜß!
 *  @(#) $Id: WordTypeFilter.java 805 2011-09-20 06:41:22Z gfis $
 *  2016-09-19: old package name was gramword
 *  2010-10-19: transformer.initialize()
 *  2007-02-27: copied from GrammarFilter
 *  2007-02-21: general parts extracted to BaseFilter
 *  2007-02-14: refactored for teherba.org
 *  2006-08-02: strategies prsplit, sasplit
 *  2006-07-21: MorphemTester instead of Classificator
 *  2006-05-31: copied from NumberSpeller
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
import  org.teherba.gramword.filter.BaseFilter;
import  org.teherba.gramword.filter.Segment;
import  org.teherba.gramword.Morphem;
import  java.util.TreeMap;
import  java.util.regex.Pattern;
import  org.xml.sax.Attributes;
import  org.apache.log4j.Logger;

/** Shows the syntactical type of words in an HTML file by different background colors
 *  @author Dr. Georg Fischer
 */
public class WordTypeFilter extends BaseFilter { 
    public final static String CVSID = "@(#) $Id: WordTypeFilter.java 805 2011-09-20 06:41:22Z gfis $";

    /** log4j logger (category) */
    private Logger log;

    /** Constructor.
     */
    public WordTypeFilter() {
        super();
        setFormatCodes("wordtype");
        setDescription("word types in different colors");
        setFileExtensions("html");
    } // Constructor
    
    /** Initializes the (quasi-constant) global structures and variables.
     *  This method is called by the {@link org.teherba.xtrans.XtransFactory} once for the
     *  selected generator and serializer.
     */
    public void initialize() {
        super.initialize();
        log = Logger.getLogger(WordTypeFilter.class.getName());
    } // initialize
    
    /*===========================*/
    /* SAX handler for XML input */
    /*===========================*/

    /** Eventually modifies some previous queue element(s),
     *  append a new segment to the queue and 
     *  prints the segment which is shifted out of the queue.
     *  @param segment the new segment to be appended to the queue
     *  <p>
     *  This implementation shows all words starting with an uppercase letter
     *  and all numbers on a colored background.
     */
    protected void enqueue(Segment segment) {
        Segment element = queue.get(segmentPivot);
        Morphem morphem = element.getMorphem();
        String entry = morphem.getEntry();
        String morph = morphem.getMorph();
        if (entry.length() <= 0) {
            // ignore empty words - should never occur
        } else { // if (Character.isLetterOrDigit(entry.charAt(0))) {
            if (false) {
            } else if (morph.length() > 0) {
                // we know it already
            } else { 
                morphem = tester.test(entry); // database lookup
            }
            if (morphem != null && morphem.getMorph() != null) {
                String wordClass = morphem.getMorph();
                String morphCode = wordClass.substring(0, 2);
                element.appendBefore("<span class=\"" 
                            + morphCode
                            + "\" morph=\"" 
                            + wordClass.substring(morphCode.length())
                            + "\">");
                element.prependBehind("</span>");
                cntKnown ++;
                morphIncr(morphCode);
            } else {
            }
            cntWords ++;
        }
        if (inA) {
            segment.setInLink(inA);
        }
        charWriter.print(queue.add(segment));
    } // enqueue
    
    /** Receive notification of the start of an element.
     *  Looks for the element which contains raw lines.
     *  @param uri The Namespace URI, or the empty string if the element has no Namespace URI 
     *  or if Namespace processing is not being performed.
     *  @param localName the local name (without prefix), 
     *  or the empty string if Namespace processing is not being performed.
     *  @param qName the qualified name (with prefix), 
     *  or the empty string if qualified names are not available.
     *  @param attrs the attributes attached to the element. 
     *  If there are no attributes, it shall be an empty Attributes object.
     */
    public void startElement(String uri, String localName, String qName, Attributes attrs) {
        super.startElement(uri, localName, qName, attrs);
        if (namespace.length() > 0 && qName.startsWith(namespace)) {
            qName = qName.substring(namespace.length());
        }
        if (false) {
        } else if (qName.equals(HEAD_TAG    )) { 
            writeHeadEnd  ("Colored Word Types");
        } else if (qName.equals(BODY_TAG    )) { 
            writeBodyStart("Colored Word Types");
        }
    } // startElement
    
    /** Receive notification of the end of an element.
     *  Looks for the element which contains raw lines.
     *  Terminates the line.
     *  @param uri the Namespace URI, or the empty string if the element has no Namespace URI 
     *  or if Namespace processing is not being performed.
     *  @param localName the local name (without prefix), 
     *  or the empty string if Namespace processing is not being performed.
     *  @param qName the qualified name (with prefix), 
     *  or the empty string if qualified names are not available.
     */
    public void endElement(String uri, String localName, String qName) {
        if (namespace.length() > 0 && qName.startsWith(namespace)) {
            qName = qName.substring(namespace.length());
        }
        tagBoundary();
        if (qName.equals(BODY_TAG    )) { 
            writeBodyEnd("code,bar,sum,switch");
        }
        if (! nonEmpty && qName.equals(currentTag)) {
            // reduce start tag to empty element tag
            StringBuffer tail = new StringBuffer(128);
            tail.append(queue.get(0).toString());
            tail.insert(tail.length() - 1, " /");
            queue.set(0, new Segment(tail.toString(), new Morphem(), ""));
        } else {
            enqueue(new Segment(getEndTag(qName), new Morphem(), ""));
        }
        currentTag = "";
        nonEmpty = false;
        inA = false;
    } // endElement
    
} // WordTypeFilter
