/*  Superclass for XHTML serializers which perform some
    modification (coloring, linking and the like) based on
    the local analysis of several words, which are surrounded by "glue"
    (HTML tags, whitespace and punctuation).
    @(#) $Id: BaseFilter.java 805 2011-09-20 06:41:22Z gfis $
    2016-09-20: this was the former QueueTransformer
    2016-09-11: javadoc
    2010-07-05: initialize()
    2007-04-19: no 'generate'
    2007-02-21: copied from xtrans.LineTransformer
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
package org.teherba.gramword.filter;
import  org.teherba.gramword.filter.Segment;
import  org.teherba.gramword.filter.SegmentQueue;
import  org.teherba.gramword.Morphem;
import  org.teherba.gramword.MorphemTester;
import  org.teherba.xtrans.CharTransformer;
import  org.teherba.xtrans.XMLTransformer;
import  java.io.BufferedReader;
import  java.io.FileInputStream;
import  java.io.FileOutputStream;
import  java.io.Reader;
import  java.io.PrintWriter;
import  java.util.Iterator;
import  java.util.TreeMap;
import  org.xml.sax.Attributes;
import  org.xml.sax.SAXParseException;
import  org.apache.log4j.Logger;

/** (Pseudo-abstract) superclass for XHTML filters which perform some
 *  modification (coloring, linking and the like) based on
 *  the local analysis of several queue elements.
 *  The queue contains words and numbers, which are surrounded by "glue"
 *  (HTML tags, whitespace and punctuation).
 *  @author Dr. Georg Fischer
 */
public class BaseFilter extends XMLTransformer { // but still uses plain CharWriter therein
    public final static String CVSID = "@(#) $Id: BaseFilter.java 805 2011-09-20 06:41:22Z gfis $";

    /** log4j logger (category) */
    private Logger log;

    /** Anchor element tag */
    protected static final String A_TAG     = "a";
    /** Body element tag */
    protected static final String BODY_TAG  = "body";
    /** Head element tag */
    protected static final String HEAD_TAG  = "head";
    /** HTML element tag */
    protected static final String ROOT_TAG  = "html";

    /** Queue for the analysis of a short sequence of words */
    protected SegmentQueue queue;
    /** Number of words read from a file */
    protected int cntWords;
    /** Number of words recognized */
    protected int cntKnown;
    /** Classificator used to determine morphologies of words */
    protected MorphemTester tester;
    /** Stores the number of occurrences of various morphems */
    protected TreeMap<String, Integer> morphCounts;

    /** Constructor.
     */
    public BaseFilter() {
        super();
        setFormatCodes("queue");
        setDescription("Test for subclasses of BaseFilter");
        setFileExtensions("html");
    } // Constructor()

    /** Initializes the (quasi-constant) global structures and variables
     *  common to generator and serializer.
     *  This method is called by the {@link org.teherba.xtrans.XtransFactory} once for the
     *  selected generator and serializer.
     */
    public void initialize() {
        super.initialize();
        log = Logger.getLogger(BaseFilter.class.getName());
        cntWords        = 0;
        cntKnown        = 0;
        queue           = new SegmentQueue(8, this);
        morphCounts     = new TreeMap<String, Integer>();
        tester          = new MorphemTester("all"); // default: apply all tests
     } // initialize

   /*===========================*/
    /* SAX handler for XML input */
    /*===========================*/

    /** Buffer for words */
    protected StringBuffer wordBuffer = new StringBuffer(128);
    /** Buffer for glue */
    protected StringBuffer glueBuffer = new StringBuffer(128);

    /** Indicates the class of the previous ćharacter during loop in {@link #characters} */
    private static  enum State
            { IN_WORD
            , IN_NUMBER
            , IN_PUNCT
            , IN_GLUE
            };
    /** State of previous character while scanning  words,numbers, punctuation or glue */
    protected State prevState;

    /*  accented and special letters */
    // private static final String LETTERS = "áéíóúýàèìòùâêîôûåëïÿçãñõªºµšžÞÁÉÍÓÚÝÀÈÌÒÙÂÊÎÔÛÅËÏŸÇÃÑÕªºµŠŽÞ";
    /** current enclosing element */
    protected String currentTag;
    /** whether content has been seen behind a start tag */
    protected boolean nonEmpty;
    /** whether in HTML "a" element */
    protected boolean inA;

    //--------------------------------------------------------
    /** Inserts some HTML before any &lt;/head&gt; tag.
     *  By default, a series of stylesheet references is included.
     *  These stylesheets must lay in the root directory of the container
     *  (gits/gramword/web/ resp. tomcat/webapps/gramword/).
     *  @param title title of the page
     */
    protected void writeHeadEnd  (String title) {
        queue.appendBehind("<title>" + title + "</title>"
        + "\n<link rel=\"stylesheet\" title=\"all\"    type=\"text/css\" href=\"all.css\"    />"
        + "\n<link rel=\"stylesheet\" title=\"vbav\"   type=\"text/css\" href=\"vbav.css\"   />"
        + "\n<link rel=\"stylesheet\" title=\"sbajar\" type=\"text/css\" href=\"sbajar.css\" />"
        + "\n<link rel=\"stylesheet\" title=\"nmnu\"   type=\"text/css\" href=\"nmnu.css\"   />"
        + "\n<link rel=\"stylesheet\" title=\"prcj\"   type=\"text/css\" href=\"prcj.css\"   />"
        + "\n<link rel=\"stylesheet\" title=\"puxy\"   type=\"text/css\" href=\"puxy.css\"   />"
        + "\n<script type=\"text/javascript\" src=\"javascript.js\"></script>\n"
        );
    } // writeHeadEnd

    /** Inserts some HTML after the &lt;body&gt; tag.
     *  By default, a header line is inserted.
     *  @param title title of the page
     */
    protected void writeBodyStart(String title) {
        queue.appendBehind("<h2>" + title + "</h2>\n"
        );
    } // writeBodyStart

    /** Inserts some HTML before the &lt;/body&gt; tag.
     *  There are several variations which are controlled by <em>features</em>.
     *  @param features comma-separated list of features:
     *  <ul>
     *  <li>code   - show the morphem codes with their colors and counts</li>
     *  <li>bar    - show the distribution as a colored bar</li>
     *  <li>sum -  - show the sum of total and recognized words</li>
     *  <li>switch - show the links for the activation of subsets of morphem code colors</li>
     *  </ul>
     */
    protected void writeBodyEnd  (String features) {
        features = "," + features + ",";

        if (features.indexOf("code"     ) >= 0) {
            queue.appendBehind("<br /><br />Morphems:\n");
            Iterator<String> miter = morphCounts.keySet().iterator();
            while (miter.hasNext()) {
                String morph = miter.next();
                int count = morphCounts.get(morph).intValue();
                queue.appendBehind("<span class=\"" + morph + "\">"
                        + morph + "</span> " + String.valueOf(count) + "\n");
            } // while iter
            queue.appendBehind("<br />\n");
        } // code

        if (features.indexOf("bar"      ) >= 0) {
        } // bar

        if (features.indexOf("sum"      ) >= 0) {
            queue.appendBehind("<strong>"      + String.format("%.1f", cntKnown * 100.0 / cntWords)
            + "%</strong> = "+ String.valueOf(cntKnown) + " recognized "
            + "and "         + String.valueOf(cntWords - cntKnown)  + " unknown "
            + "out of "      + String.valueOf(cntWords)  + " total words"
            + "<br />\n"
            );
        } // sum

        if (features.indexOf("switch"   ) >= 0) {
            queue.appendBehind("Highlight:\n"
            + "<a href=\"#\" title=\"Click to switch\" onclick=\"activateStyles('all');    return false;\">all found</a>, \n"
            + "<a href=\"#\" title=\"Click to switch\" onclick=\"activateStyles('vbav');   return false;\">Vb+Av</a>, \n"
            + "<a href=\"#\" title=\"Click to switch\" onclick=\"activateStyles('sbajar'); return false;\">Sb+Aj+Ar</a>, \n"
            + "<a href=\"#\" title=\"Click to switch\" onclick=\"activateStyles('nmnu');   return false;\">Nm+Nu</a>, \n"
            + "<a href=\"#\" title=\"Click to switch\" onclick=\"activateStyles('prcj');   return false;\">Pr+Cj+Cc+Un</a> \n"
            + "<a href=\"#\" title=\"Click to switch\" onclick=\"activateStyles('puxy');   return false;\">Pu+Xy</a> \n"
            );
            queue.appendBehind("<br />\n");
        } // switch

    } // writeBodyEnd
    //--------------------------------------------------------
    /** Receive notification of the beginning of the document.
     *  Initializes the queue.
     */
    public void startDocument() {
        fireStartDocument();
        wordBuffer  = new StringBuffer(128);
        glueBuffer  = new StringBuffer(128);
        prevState   = State.IN_GLUE; // start with no letter
        currentTag  = "";
        nonEmpty    = false;
        inA         = false;
    } // startDocument

    /** Receive notification of the end of the document.
     *  Flushes the queue.
     *  When the queue is totally filled with new elements, then
     *  all existing elements are moved out to the serializer.
     */
    public void endDocument() {
        int numElem = queue.size();
        while (numElem > 0) { // flush the queue
            enqueue(new Segment());
            numElem --;
        } // while flushing
    } // endDocument

    /** Receive notification of the start of an element.
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
        if (namespace.length() > 0 && qName.startsWith(namespace)) {
            qName = qName.substring(namespace.length());
        }
        inA = qName.toLowerCase().equals(A_TAG);
        tagBoundary();
        enqueue(new Segment(getStartTag(qName, attrs), new Morphem(), ""));
        currentTag = qName;
        nonEmpty = false;
    } // startElement

    /** Receive notification of the end of an element.
     *  Handles the special case of an empty XML element.
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

    /** Increments the count for the specified morphem type.
     *  @param morph type of morphem, "Aj", "Vb" ...
     */
    protected void morphIncr(String morph) {
        Object value = morphCounts.get(morph);
        morphCounts.put(morph, new Integer ((value == null)
                ? 1
                : ((Integer) value).intValue() + 1));
    } // morphIncr

    /** Terminates the word or the glue at
     *  the start of a new tag, comment, processing instruction
     *  or at the end of the document
     */
    protected void tagBoundary() {
        // copied from 'characters#isWhitespace(chi)
        switch (prevState) {
            case IN_GLUE: // append glue
                queue.appendBehind(glueBuffer.toString());
                glueBuffer.setLength(0);
                break;
            case IN_NUMBER:
                enqueue(new Segment(new Morphem(wordBuffer.toString(), Morphem.NUMBER)));
                wordBuffer.setLength(0);
                glueBuffer.setLength(0);
                break;
            default:
            case IN_PUNCT: // will not occur
            case IN_WORD:
                enqueue(new Segment(new Morphem(wordBuffer.toString(), Morphem.EMPTY  )));
                wordBuffer.setLength(0);
                glueBuffer.setLength(0);
                break;
        } // switch for whitespace
        prevState = State.IN_GLUE;
        // nd copy
    } // tagBoundary

    /** Eventually modifies some previous queue element(s),
     *  appends a new segment to the queue and
     *  serializes the previous content of the element just replaced in the ring buffer.
     *  @param segment the new segment to be appended to the queue
     *  <p>
     *  This implementation shows
     *  <ul>
     *    <li>all words starting with an uppercase letter on a chartreuse background,</li>
     *    <li>all words starting with a digit             on a lightblue  background.</li>
     *  </ul>
     */
    protected void enqueue(Segment segment) {
        Segment element = queue.getFocus();
        if (! element.isInLink()) {
            String entry = element.getMorphem().getEntry();
            if (entry.length() <= 0) {
                // ignore empty segments (for tags)
            } else if (Character.isUpperCase(entry.charAt(0))) {
                element.appendBefore("<span style=\"background-color: chartreuse\">");
                element.prependBehind("</span>");
            } else if (Character.isDigit(entry.charAt(0))) {
                element.appendBefore("<span style=\"background-color: lightblue\">");
                element.prependBehind("</span>");
            }
        }
        if (inA) {
            segment.setInLink(inA);
        }
        queue.add(segment); // serialize and overwrite
    } // enqueue

    /** Receive notification of character data inside an element.
     *  The method generates a new segment for
     *  <ul>
     *  <li>a word (consisting of letters only), and</li>
     *  <li>a number (consisting of digits only).</li>
     *  <li>a single punctuation character.</li>
     *  </ul>
     *  Whitespace is "glue" which is <strong>appended to the previous segment<strong>.
     *  HTML tags are also "glue" and are placed around queue elements such that they
     *  can still be wrapped into outer HTML elements.
     *  @param chars the characters.
     *  @param start the start position in the character array.
     *  @param len the number of characters to use from the character array.
     */
    public void characters(char[] chars, int start, int len) {
        int ichar     = start;
        int behind    = start + len;
        int segmStart = ichar;
        String entry  = null;
        while (ichar < behind) {
            char chi = chars[ichar];
            if (false) {

            } else if (Character.isLetter(chi)) { // word character
                switch (prevState) {
                    case IN_GLUE:
                        queue.appendBehind(glueBuffer.toString());
                        glueBuffer.setLength(0);
                        wordBuffer.append(chi);
                        break;
                    default:
                    case IN_PUNCT: // will not occur
                    case IN_NUMBER:
                        entry = wordBuffer.toString();
                        enqueue(new Segment(new Morphem(entry, Morphem.EMPTY)));
                        wordBuffer.setLength(0);
                        wordBuffer.append(chi);
                        break;
                    case IN_WORD:
                        wordBuffer.append(chi);
                        break;
                } // switch for letter
                prevState = State.IN_WORD;

            } else if (Character.isDigit(chi)) { // number character
                switch (prevState) {
                    case IN_GLUE: // append glue and start new Segment
                        queue.appendBehind(glueBuffer.toString());
                        glueBuffer.setLength(0);
                        wordBuffer.append(chi);
                        break;
                    default:
                    case IN_PUNCT: // will not occur
                    case IN_WORD:
                        entry = wordBuffer.toString();
                        enqueue(new Segment(new Morphem(entry, Morphem.NUMBER)));
                        wordBuffer.setLength(0);
                        wordBuffer.append(chi);
                        break;
                    case IN_NUMBER:
                        wordBuffer.append(chi);
                        break;
                } // switch for digit
                prevState = State.IN_NUMBER;

            } else if (Character.isWhitespace(chi)) { // glue character
                switch (prevState) {
                    case IN_GLUE: // append glue
                        glueBuffer.append(chi);
                        break;
                    default:
                    case IN_NUMBER:
                    case IN_PUNCT: // will not occur
                    case IN_WORD:
                        entry = wordBuffer.toString();
                        enqueue(new Segment(new Morphem(entry, Morphem.EMPTY)));
                        wordBuffer.setLength(0);
                        glueBuffer.setLength(0);
                        glueBuffer.append(chi);
                        break;
                } // switch for whitespace
                prevState = State.IN_GLUE;

            } else { // punctuation
                switch (prevState) {
                    default:
                    case IN_GLUE: // append glue and start new Segment
                        queue.appendBehind(glueBuffer.toString());
                        glueBuffer.setLength(0);
                        wordBuffer.append(chi);
                        entry = wordBuffer.toString();
                        enqueue(new Segment(new Morphem(entry, Morphem.PUNCT)));
                        wordBuffer.setLength(0);
                        break;
                    case IN_NUMBER:
                        entry = wordBuffer.toString();
                        enqueue(new Segment(new Morphem(entry, Morphem.NUMBER)));
                        wordBuffer.setLength(0);
                        wordBuffer.append(chi);
                        entry = wordBuffer.toString();
                        enqueue(new Segment(new Morphem(entry, Morphem.PUNCT)));
                        wordBuffer.setLength(0);
                        break;
                    case IN_WORD:
                        entry = wordBuffer.toString();
                        enqueue(new Segment(new Morphem(entry, Morphem.EMPTY)));
                        wordBuffer.setLength(0);
                        wordBuffer.append(chi);
                        entry = wordBuffer.toString();
                        enqueue(new Segment(new Morphem(entry, Morphem.PUNCT)));
                        wordBuffer.setLength(0);
                        break;
                } // switch for punctuation
                prevState = State.IN_GLUE;

            } // end of if cascade for current character
            ichar ++;
        } // while ichar
        nonEmpty = nonEmpty || len > 0;
    } // characters

    /** Receive notification of an XML comment.
     *  @param chars the characters.
     *  @param start the start position in the character array.
     *  @param len the number of characters to use from the character array.
     */
    public void comment(char[] chars, int start, int len) {
        tagBoundary();
        queue.appendBehind("<!--" + new String(chars, start, len) + "-->");
    } // comment

    /** Receive notification of a processing instruction.
     *  @param target The processing instruction target.
     *  @param data The processing instruction data, or null if none is supplied.
     */
    public void processingInstruction(String target, String data) {
        tagBoundary();
        queue.appendBehind("<!-- PI target=\"" + target + "\" data=\"" + data + "\" -->");
    } // processingInstruction

    /** Receive notification of a parser error
     *  @param exc exception describing the error
     */
    public void error(SAXParseException exc) {
        charWriter.println("\n<!-- error: " + exc + "-->");
    } // error

    /** Receive notification of a parser warning
     *  @param exc exception describing the error
     */
    public void warning(SAXParseException exc) {
        charWriter.println("\n<!-- warning: " + exc + "-->");
    } // warning

} // BaseFilter
