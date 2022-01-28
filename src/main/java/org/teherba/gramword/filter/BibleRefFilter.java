/*  Links bible references to the first verse in online bibles
 *  @(#) $Id: BibleRefFilter.java 805 2011-09-20 06:41:22Z gfis $
 *  2016-09-19: old package was gramword.filters
 *  2010-10-19: transformer.initialize()
 *  2007-02-27: copied from WordTypeFilter
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
import  org.teherba.gramword.MorphemList;
import  org.apache.logging.log4j.Logger;
import  org.apache.logging.log4j.LogManager;

/** Links bible references like "Joh 1,1" to a fragment URLs in online bibles.
 *  The algorithm is as follows:
 *  <ul>
 *  <li>Check segment[-12] for names of bible books (or their abbreviations)
 *  in table INFOS, with MORPH=de.name,
 *  which are followed by a numeric segment in the queue.</li>
 *  <li>If MOREL is non-empty (a small digit),
 *  try to find a digit segment before the book name, and select the corresponding
 *  morphem in the result list. Tags are stored as empty segments to prevent
 *  a misinterpretation of "Mt 1,1 &lt;/td&gt;&lt;td&gt;Joh 17..." as "1 Joh 17".
 *  </li>
 *  <li>Get ENREL, which is the normalized book number (01..73).</li>
 *  <li>Fetch the URL pattern with <em>code</em>.00,
 *  where <em>code</em> is the code for the desired online bible</li>
 *  <li>Prefix the normalized book number with that code, too,</li>
 *  <li>and use it as a key to select another ENTRY in INFOS.</li>
 *  <li>The corresponding MORPH is the link specific book name.</li>
 *  <li>Build the complete link.</li>
 *  <li>Skip over all following numeric segments (and single letters a, b, ...) in the queue.</li>
 *  <li>Insert the "a" start and end tags around the whole bible reference.</li>
 *  </ul>
 *  @author Dr. Georg Fischer
 */
public class BibleRefFilter extends BaseFilter {
    public final static String CVSID = "@(#) $Id: BibleRefFilter.java 805 2011-09-20 06:41:22Z gfis $";

    /** Debugging switch */
    private static final boolean DEBUG = false;
    /** log4j logger (category) */
    private Logger log;

    /** Constructor.
     */
    public BibleRefFilter() {
        super();
        setFormatCodes("bibleref");
        setDescription("Links bible references to online bibles");
        setFileExtensions("html");
    } // Constructor()

    /** Initializes the (quasi-constant) global structures and variables.
     *  This method is called by the {@link org.teherba.xtrans.XtransFactory} once for the
     *  selected generator and serializer.
     */
    public void initialize() {
        super.initialize();
        log = LogManager.getLogger(BibleRefFilter.class.getName());
        queue = new SegmentQueue(12, this);
    } // initialize

    /*===========================*/
    /* SAX handler for XML input */
    /*===========================*/

    /** Eventually modifies some previous queue element(s),
     *  append a new segment to the queue and
     *  prints the segment which is shifted out of the queue.
     *  @param segment the new segment to be appended to the queue
     *  <p>
     *  This implementation tries to find a bible reference, and if found,
     *  surrounds it with an "a" HTML element pointing to an online bible
     *  fragment URL.
     */
    protected void enqueue(Segment segment) {
        int istart = - queue.getLookAhead();
        Segment startSegment = queue.get(istart);
        String word0 = startSegment.getMorphem().getEntry();
        int iend   = istart - 1;
        if (word0.length() <= 0) {
            // ignore empty words which were inserted for tags
        } else if (Character.isUpperCase(word0.charAt(0))) {
            MorphemList morphems = tester.getInfos(word0);
            if (morphems.size() > 0) {
                String normBookNo = null;
                int imorph = 0;
                boolean busy = true;
                while (busy && imorph < morphems.size()) {
                    // search for the proper one with "de.name"
                    // and the right book number prefix
                    if (DEBUG) {
                        StringBuffer trace = new StringBuffer(64);
                        for (int iseg = - queue.getLookAhead() - 1; iseg < - queue.getLookAhead() + 10; iseg ++) {
                            trace.append(' ');
                            trace.append(queue.get(iseg).getMorphem().getEntry());
                        }
                        log.debug("for \"" + word0 + "\" look at:" + trace.toString()
                                + " with " + morphems.size() + " result(s)");
                    }
                    Morphem morphem = (Morphem) morphems.get(imorph);
                    if (morphem.getMorph().equals("de.name")) {
                        normBookNo = "bibo." + morphem.getEnrel(); // normalized book number
                        String numPrefix = morphem.getMorel(); // optional book numeric prefix
                        if (DEBUG) {
                            log.debug("morphem(" + word0 + ", " + morphem.getMorph()
                                    + ", " + normBookNo + ", " + numPrefix + ")");
                        }
                        // possible entry, but now check for numeric book prefix
                        Segment segm_1 = queue.get(istart - 1);
                        String word_1 = segm_1.getMorphem().getEntry();
                        if (numPrefix.length() == 0) {
                            if (! word_1.matches("\\A\\d\\Z") || segm_1.getSuffix().indexOf('\n') >= 0) {
                                busy = false;
                            }
                        } else {
                            if (word_1.equals(numPrefix)) {
                                // with proper book numeric prefix ("1 Joh")?
                                busy = false;
                                istart --;
                                startSegment = segm_1;
                            } else {
                            }
                        }
                    } // if "de.name"
                    imorph ++;
                } // while imorph

                if (! busy) { // start was found, now scan for the end
                    String chaptNo  = "1";
                    String verseNo  = "1";
                    StringBuffer href = new StringBuffer(128);
                    Segment endSegment = null;
                    href.append("http://www.bibel-online.net/buch/");
                    iend = - queue.getLookAhead();
                    int isegm = - queue.getLookAhead() + 1;
                    busy = true;
                    while (busy && isegm < -1) {
                        endSegment = queue.get(isegm);
                        String word9 = endSegment.getMorphem().getEntry();
                        if (word9.matches("\\A\\d+[a-z]?\\Z")) {
                            if (false) {
                            } else if (isegm == - queue.getLookAhead() + 1) {
                                chaptNo = word9;
                            } else if (isegm == - queue.getLookAhead() + 2) {
                                verseNo = word9;
                            }
                            iend = isegm;
                        } else { // empty or no digits nor single letter
                            busy = false;
                            iend = isegm - 1;
                        }
                        if (endSegment.getSuffix().indexOf('\n') >= 0) {
                            busy = false;
                        }
                        isegm ++;
                    } // while isegm
                    if (iend >= - queue.getLookAhead() + 1) { // at least one number behind
                        endSegment = queue.get(iend);
                        // build the link tags and surround the reference with them
                        morphems = tester.getInfos(normBookNo);
                        if (morphems.size() != 1) {
                            log.error(morphems.size()
                                    + " instead of 1 entry for normalized book number " + normBookNo);
                        } else {
                            Morphem morphem = (Morphem) morphems.get(0);
                            href.append(morphem.getMorph()); // technical book file/subdirectory
                            href.append('/');
                            href.append(chaptNo);
                            href.append(".html#");
                            href.append(chaptNo);
                            if (verseNo.length() > 0) {
                                href.append(',');
                                href.append(verseNo);
                            }
                            startSegment.appendBefore("<a href=\"" + href + "\">");
                            endSegment .prependBehind("</a>");
                        if (DEBUG) {
                                log.debug("link " + href + " found for " + word0 + ": " + istart + ".." + iend);
                            }
                        }
                    } // iend >= - queue.getLookAhead()() + 1
                    else {
                        if (DEBUG) {
                            log.debug("no number behind " + word0);
                        }
                    }
                } // start was found
                else {
                    if (DEBUG) {
                        log.debug("start was not found for \"" + word0 + "\"");
                    }
                }
            } // morphems.size() > 0
            else {
                if (DEBUG) {
                    log.debug("no morphems found for " + word0);
                }
            }
        } // uppercase, non-empty word

        if (inA) {
            segment.setInLink(inA);
        }
        queue.add(segment);
    } // enqueue

} // BibleRefFilter
