/*  Highlights German account and bank id numbers.
 *  @(#) $Id: KontoFilter.java 976 2013-02-02 16:44:18Z gfis $
 *  2016-09-19: old package name was gramword/filters
 *  2016-09-11: javaodc
 *  2010-10-19: transformer.initialize()
 *  2007-04-18: copied from BibleRefFilter
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
import  org.teherba.gramword.Morphem;
import  org.teherba.gramword.MorphemList;
import  org.teherba.gramword.QueueTransformer;
import  org.teherba.gramword.Segment;
import  org.teherba.checkdig.account.DeAccountChecker;
import  java.util.ArrayList;
import  java.net.URLEncoder;
import  java.io.UnsupportedEncodingException;
import  org.xml.sax.Attributes;
import  org.xml.sax.SAXParseException;
import  org.apache.log4j.Logger;

/** Highlights German account and bank id numbers.
 *  The algorithm is as follows:
 *  <ul>
 *  <li>Check for key words "BLZ", "Kto", "Kontonummer" etc.
 *  against a constant array.</li>
 *  <li>Insert the "span title=" start and end tags around the BLZ,
 *  and highlight the account number depending on the correct check digit.</li>
 *  </ul>
 *  @author Dr. Georg Fischer
 */
public class KontoFilter extends QueueTransformer {
    public final static String CVSID = "@(#) $Id: KontoFilter.java 976 2013-02-02 16:44:18Z gfis $";

    /** Debugging switch */
    private static final boolean DEBUG = true;
    /** log4j logger (category) */
    private Logger log;

    /** Array of key words "BLZ", "Kto" etc. */
    private ArrayList/*<1.5*/<String>/*1.5>*/ keyWords;
    /** Maximum index of "BLZ" key words */
    private int maxBlz;
    /** Maximum index of "Kto" key words */
    private int maxKto;
    /** Negative distance to {@link QueueTransformer#segmentPivot} element for "BLZ"   keyword */
    private int distBlz;
    /** Negative distance to {@link QueueTransformer#segmentPivot} element for "Konto" keyword */
    private int distKto;
    /** Size of queue */
    private int queueSize;
    /** Start of number span (offset to tail of queue) - side effect result of {@link #getNextNumber} */
    private int startSpan;
    /** End   of number span (offset to tail of queue) - side effect result of {@link #getNextNumber} */
    private int endSpan;
    /** initialize account object */
    private DeAccountChecker deAccountChecker;

    /** Constructor.
     */
    public KontoFilter() {
        super();
        setFormatCodes("konto");
        setDescription("Highlight German account and bank id numbers");
        setFileExtensions("html");
    } // Constructor()

    /** Initializes the (quasi-constant) global structures and variables.
     *  This method is called by the {@link org.teherba.xtrans.XtransFactory} once for the
     *  selected generator and serializer.
     */
    public void initialize() {
        super.initialize();
        log = Logger.getLogger(KontoFilter.class.getName());
        segmentPivot = -16;
        keyWords = new ArrayList/*<1.5*/<String>/*1.5>*/(8);
        keyWords.add("BLZ");
        maxBlz = keyWords.size();
        keyWords.add("KTO");
        keyWords.add("KTNR");
        keyWords.add("KONTO");
        keyWords.add("KONTONR");
        keyWords.add("KONTONUMMER");
        maxKto = keyWords.size();
        deAccountChecker = new DeAccountChecker();
    } // initialize

    /*===========================*/
    /* SAX handler for XML input */
    /*===========================*/

    /** Eventually modifies some previous queue element(s),
     *  append a new segment to the queue and
     *  prints the segment which is shifted out of the queue.
     *  @param segment the new segment to be appended to the queue
     *  <p>
     *  This implementation tries to find a German account and bank id number,
     *  and if found, surrounds them with "span" HTML elements.
     *  The result of the check digit algorithm is marked with a color
     *  over the account number (span class=), and the bank name is shown when
     *  the mouse is moved over the bank id (span title=).
     */
    protected void enqueue(Segment segment) {
        int istart = segmentPivot;
        Segment startSegment = queue.get(istart);
        String word0 = startSegment.getMorphem().getEntry().toUpperCase();
        if (word0.length() <= 0) {
            // ignore empty words which were inserted for tags
        } else if (Character.isLetter(word0.charAt(0))) {
            int pos = keyWords.indexOf(word0);
            if (pos < 0) { // not found - ignore
            } else if (pos < maxBlz) { // variation of "BLZ"
                startSegment.appendBefore ("<span style=\"background-color: gainsboro\">");
                startSegment.prependBehind("</span>");
                String blz = getNextNumber(istart); // side-effect: sets startSpan, endSpan
                if (blz.length() == 8) { // German BLZ
                    // http://www.google.com/search?q=goobly+googly+gook
                    String bankName = getBankName(blz);
                    String googleURL = "http://www.google.de/search?q="
                            + bankName.replaceAll("\\s+", "+");
                    try {
                        googleURL = "http://www.google.de/search?q="
                            + URLEncoder.encode(bankName, getResultEncoding());
                    } catch (UnsupportedEncodingException exc) {
                        // ignore, default was set above
                    }
                    int blzStartSpan = startSpan;
                    int blzEndSpan   = endSpan;

                    int ktoIndex = getNearestKto(istart);
                    if (ktoIndex != istart) { // KTO was found before or behind
                        String ktoNr = getNextNumber(ktoIndex);
                        if (ktoNr.length() <= 10 && ktoNr.length() >= 3) {
                            String newKtoNr = deAccountChecker.check(ktoNr, blz);
                            if (newKtoNr.indexOf(ktoNr) >= 0) { // checkdigit ok
                                queue.get(startSpan).appendBefore ("<span"
                                        + " style=\"background-color: lightgreen\">");
                                queue.get(  endSpan).prependBehind("</span>");
                            } else { // checkdigit wrong
                                queue.get(startSpan).appendBefore ("<span"
                                        + " title=\"" + newKtoNr + "\""
                                        + " style=\"background-color: lightsalmon\">");
                                queue.get(  endSpan).prependBehind("</span>");
                            }
                        }
                        Segment ktoSegment = queue.get(ktoIndex);
                        ktoSegment.appendBefore ("<span"
                                  + " style=\"background-color: khaki\">");
                        ktoSegment.prependBehind("</span>");
                    } // KTO was found
                    queue.get(blzStartSpan).appendBefore ("<a href=\"" + googleURL + "\">"
                            + "<span"
                            + " title=\"" + bankName + "\""
                            + " style=\"background-color: lightblue\">"
                            );
                    queue.get(blzEndSpan).prependBehind("</span></a>");
                } // German BLZ
            } else if (pos < maxKto) { // variation of "KTO"
            /*
                startSegment.appendBefore("<span style=\"background-color: khaki\">");
                startSegment.prependBehind("</span>");
            */
            }
        } // uppercase, non-empty word

        if (inA) {
            segment.setInLink(inA);
        }
        charWriter.print(queue.add(segment));
    } // enqueue

    /** Assembles the next number from numeric segments. There may be
     *  glue and at  most one word before the number, but no HTML tag.
     *  @param index negative offset to queue element which contains
     *  the keyword (BLZ or KTO) before the number.
     *  @return a sequence of digits, or the empty string if no number is found
     *  after the (over-)next word and before an HTML tag
     */
    protected String getNextNumber(int index) {
        StringBuffer result = new StringBuffer(16);
        int allowedWords = 1;
        startSpan = - queueSize; // invalid
        endSpan   = startSpan;
        boolean busy = true;
        index ++; // skip over keyword
        while (busy && index <= 0) {
            Segment element = queue.get(index);
            if (element.getPrefix().contains("<")) { // HTML tag - stops
                busy = false;
            } else { // no HTML prefix
                String entry = element.getMorphem().getEntry();
                if (entry.length() > 0) { // empty segments are ignored
                    if (Character.isLetter(entry.charAt(0)) && result.length() == 0) {
                        allowedWords --;
                        busy = allowedWords >= 0;
                    } else if (Character.isDigit(entry.charAt(0))) {
                        if (result.length() == 0) { // 1st number segment
                            startSpan = index;
                        }
                        endSpan = index;
                        result.append(entry);
                    } else {
                        busy = false;
                    }
                } // non-empty segment
            } // no HTML prefix
            index ++;
        } // while busy
        return result.toString();
    } // getNextNumber

    /** Starts at BLZ and searches for KTO in both directions, and takes the one
     *  which has the fewest words in between. Stops at the end of the queue,
     *  or at HTML tags.
     *  @param blzIndex negative offset to queue element which contains
     *  the keyword BLZ.
     *  @return the index (negative queue offset) of the
     *  KTO element which is nearer, or <em>blzIndex</em> if there is none
     */
    protected int getNearestKto(int blzIndex) {
        int result      = blzIndex;
        int ktoBefore   = result;
        int ktoBehind   = result;
        int wordsBefore = 0; // intermediate words before BLZ
        int wordsBehind = 0; // intermediate words behind BLZ
        boolean busy;
        int index;
        busy = true;
        index = blzIndex + 1;
        while (busy && index <= 0) { // search upwards - behind BLZ
            Segment element = queue.get(index);
            if (element.toString().contains("<")) { // HTML tag - stops
                busy = false;
            } else { // no HTML prefix
                String entry = element.getMorphem().getEntry();
                if (entry.length() > 0) { // empty segments are ignored
                    if (Character.isLetter(entry.charAt(0))) {
                        if (keyWords.indexOf(entry.toUpperCase()) >= maxBlz) { // variation of "KTO"
                            busy = false;
                            ktoBehind = index;
                        } else {
                            wordsBehind ++;
                        }
                    } // starts with letter
                } // non-empty segment
            } // no HTML prefix
            index ++;
        } // while upwards

        busy = true;
        index = blzIndex - 1;
        while (busy && index >= - queueSize) { // search downwards - before BLZ
            Segment element = queue.get(index);
            if (element.toString().contains(">")) { // HTML tag - stops
                busy = false;
            } else { // no HTML prefix
                String entry = element.getMorphem().getEntry();
                if (entry.length() > 0) { // empty segments are ignored
                    if (Character.isLetter(entry.charAt(0))) {
                        if (keyWords.indexOf(entry.toUpperCase()) >= maxBlz) { // variation of "KTO"
                            busy = false;
                            ktoBefore = index;
                        } else {
                            wordsBefore ++;
                        }
                    } // starts with letter
                } // non-empty segment
            } // no HTML prefix
            index --;
        } // while downwards
        if (false) {
        } else if (ktoBehind == blzIndex) {
            result = ktoBefore;
        } else if (ktoBefore == blzIndex) {
            result = ktoBehind;
        // 2 KTO were found here
        } else if (wordsBefore > wordsBehind) {
            result = ktoBehind;
        } else {
            result = ktoBefore;
        }
        return result;
    } // getNearestKto

    /** Determines the bank name for a bank id (BLZ).
     *  @param blz number with 8 digits
     *  @return the name of the bank, or "unknown" if not found
     */
    protected String getBankName(String blz) {
        String result = "unknown";
        MorphemList morphems = tester.getInfos(blz);
        if (morphems.size() > 0) {
            int imorph = 0;
            boolean busy = true;
            while (busy && imorph < morphems.size()) {
                // search for the proper one with "blz"
               if (DEBUG) {
                    StringBuffer trace = new StringBuffer(64);
                    for (int iseg = segmentPivot - 1; iseg < segmentPivot + 10; iseg ++) {
                        trace.append(' ');
                        trace.append(queue.get(iseg).getMorphem().getEntry());
                    }
                    log.debug("for \"" + blz + "\" look at:" + trace.toString()
                            + " with " + morphems.size() + " result(s)");
                }
                Morphem morphem = (Morphem) morphems.get(imorph);
                if (morphem.getMorph().equals("blz")) {
                    result = morphem.getEnrel();
                }
                imorph ++;
            } // while
        } // some morphems found
        return result;
    } // getBankName

    /** Receive notification of the beginning of the document.
     *  Initializes the queue.
     */
    public void startDocument() {
        super.startDocument();
        queueSize = queue.getSize();
        distBlz   = queueSize; // outside
        distKto   = queueSize; // outside
    } // startDocument

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
        } else if (qName.equals(BODY_TAG    )) {
        } else if (qName.equals(HEAD_TAG    )) {
            // insert special stylesheets
            String path = "file:///C|/var/www/teherba.org/gramword/web/"; // if not run in servlet container
            path = ""; // relative .css file paths in servlet container
            queue.appendBehind(""
            + "<link rel=\"stylesheet\" title=\"all\"    type=\"text/css\" href=\"" + path + "stylesheet.css\" />"
            );
        }
    } // startElement

} // KontoFilter
