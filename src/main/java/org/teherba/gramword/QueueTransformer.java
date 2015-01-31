/*  Superclass for XHTML transformers which perform some 
    modification (coloring, linking and the like) based on
    the local analysis of several words, which are surrounded by "glue"
    (HTML tags, whitespace and punctuation).
    @(#) $Id: QueueTransformer.java 805 2011-09-20 06:41:22Z gfis $
	2010-07-05: initialize()
    2007-04-19: no 'generate'
    2007-02-21: copied from xtrans.LineTransformer
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
import  org.teherba.xtrans.CharTransformer;
import  org.teherba.gramword.Morphem;
import  org.teherba.gramword.MorphemTester;
import  org.teherba.gramword.Segment;
import  org.teherba.gramword.SegmentQueue;
import  java.io.BufferedReader;
import  java.util.TreeMap;
import  java.util.regex.Pattern;
import  org.xml.sax.Attributes;
import  org.xml.sax.SAXParseException;
import  org.apache.log4j.Logger;

/** (Pseudo-abstract) superclass for XHTML filters which perform some 
 *  modification (coloring, linking and the like) based on
 *  the local analysis of several queue elements.
 *	The queue contains words and numbers, which are surrounded by "glue"
 *  (HTML tags, whitespace and punctuation).
 *  @author Dr. Georg Fischer
 */
public class QueueTransformer extends CharTransformer { 
    public final static String CVSID = "@(#) $Id: QueueTransformer.java 805 2011-09-20 06:41:22Z gfis $";

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
    /** Stores the occurrences of various morphem */
    protected TreeMap/*<1.5*/<String, Integer>/*1.5>*/ morphCounts;
    /** Strategy to be used to classify the words */
    protected String strategy;
    /** Index of segment where to start checking; doesn't matter, look only at 1 segment */
    protected int segmentPivot;
    
    /** Constructor.
     */
    public QueueTransformer() {
        super();
        setFormatCodes("queue");
        setDescription("Test for subclasses of QueueTransformer");
        setFileExtensions("html");
    } // Constructor()
    
	/** Initializes the (quasi-constant) global structures and variables
	 *  common to generator and serializer.
	 *  This method is called by the {@link org.teherba.xtrans.XtransFactory} once for the
	 *  selected generator and serializer.
	 */
	public void initialize() {
		super.initialize();
        log = Logger.getLogger(QueueTransformer.class.getName());
        cntWords        = 0;
        cntKnown        = 0;
        strategy        = getOption("strat", "all");    // default: apply all tests
        morphCounts     = new TreeMap/*<1.5*/<String, Integer>/*1.5>*/();
        tester          = new MorphemTester(strategy);
		segmentPivot 	= -4;
	} // initialize
	
   /*===========================*/
    /* SAX handler for XML input */
    /*===========================*/

    /** Buffer for words */
    protected StringBuffer wordBuffer = new StringBuffer(128);
    /** Buffer for glue */
    protected StringBuffer glueBuffer = new StringBuffer(128);
    /** State for processing words or glue */
    protected boolean isGlue = true; // start with no letter
    /*  accented and special letters */
    // private static final String LETTERS = "áéíóúýàèìòùâêîôûåëïÿçãñõªºµšžÞÁÉÍÓÚÝÀÈÌÒÙÂÊÎÔÛÅËÏŸÇÃÑÕªºµŠŽÞ";
    /** current enclosing element */
    protected String currentTag;
    /** whether content has been seen behind a start tag */
    protected boolean nonEmpty;
    /** whether in HTML "a" element */
    protected boolean inA;
        
    /** Increments the count for the specified morphem type.
     *  @param morph type of morphem, Aj, Vb ...
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
        if (isGlue) { // still in glue
            queue.appendBehind(glueBuffer.toString());
        } else { // in word
            enqueue(new Segment("", new Morphem(wordBuffer.toString()), ""));
            wordBuffer.setLength(0);
            isGlue = true;
        }
        glueBuffer.setLength(0);
    } // tagBoundary
    
    /** Eventually modifies some previous queue element(s),
     *  append a new segment to the queue and 
     *  prints the segment which is shifted out of the queue.
     *  @param segment the new segment to be appended to the queue
     *  <p>
     *  This implementation shows all words starting with an uppercase letter
     *  on a lightblue background.
     */
    protected void enqueue(Segment segment) {
        Segment element = queue.get(-8);
        if (! element.getInLink()) {
            String word = element.getMorphem().getEntry();
            if (word.length() <= 0) {
                // ignore empty segments (for tags)
            } else if (Character.isUpperCase(word.charAt(0))) {
                element.appendBefore("<span style=\"background-color: chartreuse\">");
                element.prependBehind("</span>");
            } else if (Character.isDigit(word.charAt(0))) {
                element.appendBefore("<span style=\"background-color: lightblue\">");
                element.prependBehind("</span>");
            }
        }
        if (inA) {
            segment.setInLink(inA);
        }
        charWriter.print(queue.add(segment));
    } // enqueue

	/** Tests for &lt;head&gt; and &lt;body&gt; tags, and inserts 
	 *	the stylesheet links and table cells for the statistics on word types.
	 *	@param qName qualified tag name from the SAX parser
	 *	@param title title of the page
	 */
	protected void insertStylesheet(String qName, String title) {
        if (false) {
        } else if (qName.equals(BODY_TAG    )) { 
            // insert <table> start
            queue.appendBehind(""
            + "<table><tr><th width=\"85%\" align=\"left\">" + title + "</th>"
            + "<th align=\"left\">Morphem Codes</th></tr>"
            + "<tr><td>"
            + "<em>Move the mouse over the highlighted words:</em><br />"
            );
        } else if (qName.equals(HEAD_TAG    )) { 
            // insert special stylesheets
            String path = "file:///C|/var/www/teherba.org/gramword/web/"; // if not run in servlet container
            path = ""; // relative .css file paths in servlet container
            queue.appendBehind(""
            + "<link rel=\"stylesheet\" title=\"all\"    type=\"text/css\" href=\"" + path + "stylesheet.css\" />"
            + "<link rel=\"stylesheet\" title=\"vbav\"   type=\"text/css\" href=\"" + path + "vbav.css\"   />"
            + "<link rel=\"stylesheet\" title=\"sbajar\" type=\"text/css\" href=\"" + path + "sbajar.css\" />"
            + "<link rel=\"stylesheet\" title=\"nmnu\"   type=\"text/css\" href=\"" + path + "nmnu.css\"   />"
            + "<link rel=\"stylesheet\" title=\"prcj\"   type=\"text/css\" href=\"" + path + "prcj.css\"   />"
            + "<script type=\"text/javascript\" src=\"" + path + "/style.js\"></script>"
            );
        }
	} // insertStylesheet
	
    /** Receive notification of the beginning of the document.
     *	Initializes the queue.
     */
    public void startDocument() {
        fireStartDocument();
        queue       = new SegmentQueue();
        wordBuffer  = new StringBuffer(128);
        glueBuffer  = new StringBuffer(128);
        isGlue      = true;
        currentTag  = "";
        nonEmpty    = false;
        inA         = false;
    } // startDocument
    
    /** Receive notification of the end of the document.
     *	Flushes the queue.
     */
    public void endDocument() {
        int size = queue.getSize();
        while (size > 0) { // flush the queue
            enqueue(new Segment("", new Morphem(), "")); 
            size --;
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
    
    /** Receive notification of character data inside an element.
     *	The method generates a new segment for each word (consisting of
     *	letters only), and for each number (consisting of digits only).
     *	Whitespace and punctuation is appended to the previous segment.
     *	HTML tags are placed around queue elements such that they
     *	can still be wrapped into outer HTML elements.
     *  @param ch the characters.
     *  @param start the start position in the character array.
     *  @param length the number of characters to use from the character array. 
     */
    public void characters(char[] ch, int start, int length) {
        int ich = start;
        int endCh = start + length;
        int segmStart = ich;
        while (ich < endCh) {
            if (false) { 
            } else if (Character.isLetter(ch[ich])) { // new word character
                if (isGlue) { // append glue and start new word
                    queue.appendBehind(glueBuffer.toString());
                    glueBuffer.setLength(0);
                    isGlue = false;
                } else { // in word
                }
                wordBuffer.append(ch[ich]);
            } else if (Character.isDigit(ch[ich])) { // new word character
                if (isGlue) { // append glue and start new word
                    queue.appendBehind(glueBuffer.toString());
                    glueBuffer.setLength(0);
                    isGlue = false;
                } else { // in word
                }
                wordBuffer.append(ch[ich]);
            } else { // new glue character
                if (! isGlue) { // append word and start new glue
                    enqueue(new Segment("", new Morphem(wordBuffer.toString()), ""));
                    // System.out.println("\"" + wordBuffer.toString() + "\"");
                    wordBuffer.setLength(0);
                    isGlue = true;
                } else { // in glue
                }
                glueBuffer.append(ch[ich]);
            } 
            ich ++;
        } // while ich
        nonEmpty = nonEmpty || length > 0;
    } // characters

    /** Receive notification of an XML comment.
     *  @param ch the characters.
     *  @param start the start position in the character array.
     *  @param length the number of characters to use from the character array. 
     */
    public void comment(char[] ch, int start, int length) {
        tagBoundary();
        queue.appendBehind("<!--" + new String(ch, start, length) + "-->");
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

} // QueueTransformer
