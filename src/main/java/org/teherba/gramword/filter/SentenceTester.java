/*  Tries to detect grammatical structures at the end of the queue
    @(#) $Id$
    2016-09-25, Georg Fischer
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
package org.teherba.gramword.filter;
import  org.teherba.gramword.filter.Segment;
import  org.teherba.gramword.filter.SegmentQueue;
import  org.teherba.gramword.Morphem;
import  org.teherba.gramword.MorphemList;

/** Investigates the end of the {@link SegmentQueue} and tries
 *  to  recognize grammatical structures like:
 *  <ul>
 *  <li>relative sentences</li>
 *  </ul>
 Initially, all segments in the queue result in empty strings.
 *  @author Dr. Georg Fischer
 */
public class SentenceTester {
    public final static String CVSID = "@(#) $Id: SentenceTester.java 976 2013-02-02 16:44:18Z gfis $";

    /** Debugging switch */
    public int debug = 0;
    
    /** Number of morphems queued behind last dot.*/
    private int sentLen;

    /** No-args Constructor.
     *  Initially, all segments in the queue return empty strings.
     */
    public SentenceTester() {
        sentLen = 0;
    } // Constructor

   /** Gets the length of the sentence.
     *  @return number of morphems behind last dot
     */
    public int getLength() {
        return sentLen;
    } // getLength

    /** States of a DFA for relative clauses */
    private static enum Expect
            { RELCL_COMMA   // expect comma
            , RELCL_PREP    // expect optional preposition
            , RELCL_PNRELT  // expect relative pronoun
            , RELCL_VERB    // expect verb
            , RELCL_COMMA2  // expect comma or dot at end of relative clause
            };

    /** Adds a segement to the queue, and
     *  investigates the sentence at the end of the queue
     *  @param queue {@link SegmentQueue} to be examined
     *  @param newSegment the new {@link Segment} to be added and investigated
     *  @return current length of the sentence, which is incremented 
     */
    public int addAndTest(SegmentQueue queue, Segment newSegment) {
        queue.add(newSegment);
        sentLen ++;
        if (sentLen > queue.size()) { 
            queue.getTransformer().getCharWriter()
                    .println("<h3 class=\"Av\">sentence length " + String.valueOf(sentLen) 
                    + " exceeds queue size " + String.valueOf(queue.size()) + "</h3>");
        /*
        } else if (newSegment.isEmpty())    { // at the end
            sentLen = 0;
        */
        } else if (newSegment.isPunct(".")) { // sentence still fits in queue
            int phraseStart = 0; // invalid
            int phraseEnd   = 0;
            Expect state = Expect.RELCL_COMMA;
            int iofs = sentLen;
            while (iofs >= 1) { // queue[tail] is first free
                Segment segment = queue.get(- iofs);
                if (debug >= 3) {
                    queue.getTransformer().getCharWriter().println("<!-- state = " + state + ": " + segment.toString() + "-->");
                }
                switch(state) {
                    case RELCL_COMMA:
                        if (segment.isPunct(",")) {
                            phraseStart = iofs;
                            state = Expect.RELCL_PREP;
                        }
                        break;
                    case RELCL_PREP: // comma before
                        if (debug >= 2) {
                            queue.getTransformer().getCharWriter().println("<!-- RELCL_PREP: " 
                                    + segment.getMorphems().toString() + " ? " + segment.contains("PnRelt") + "-->");
                        }
                        if (false) {
                        } else if (segment.contains("PnRelt")) {
                            state = Expect.RELCL_VERB;
                        } else if (segment.contains("Pr")) {
                            state = Expect.RELCL_PNRELT;
                        } else { // start over
                            state = Expect.RELCL_COMMA;
                        }
                        break;
                    case RELCL_PNRELT:
                        if (debug >= 2) {
                            queue.getTransformer().getCharWriter().println("<!-- RELCL_PNRELT: " + segment.toString() + "-->");
                        }
                        if (segment.contains("PnRelt")) {
                            state = Expect.RELCL_VERB;
                        } else { // start over
                            state = Expect.RELCL_COMMA;
                        }
                        break;
                    case RELCL_VERB:
                        if (debug >= 2) {
                            queue.getTransformer().getCharWriter().println("<!-- RELCL_VERB: " + segment.toString() + "-->");
                        }
                        if (false) {
                        } else if (segment.contains("Vb")) {
                            state = Expect.RELCL_COMMA2;
                        } else if (segment.isPunct(",")) {
                            state = Expect.RELCL_PREP; // start over
                        }
                        break;
                    case RELCL_COMMA2:
                        if (false) {
                        } else if (segment.isPunct(",.")) {
                            phraseEnd = iofs;
                            modifyPhrase(queue, "RelCl", phraseStart, phraseEnd);
                            state = Expect.RELCL_COMMA; // start over
                        } else { // may perhaps find another verb later
                            state = Expect.RELCL_VERB;
                        }
                        break;
                } // switch state
                iofs --;
            } // while iofs
            sentLen = 0;
        } // still fits
        return sentLen;
    } // addAndTest

    /** Modifies a phrase which was recognized
     *  @param queue {@link SegmentQueue} to be modified
     *  @param phraseCode code for the type of the phrase
     *  @param phraseStart starting offset in queue
     *  @param phraseEnd   ending   offset in queue
     */
    private void modifyPhrase(SegmentQueue queue, String phraseCode, int phraseStart, int phraseEnd) {
        if (debug >= 1) {
            queue.getTransformer().getCharWriter()
                    .println("<!-- modifyPhrase, tail=" + queue.getTail() + ", " + phraseStart + " " + phraseEnd + "-->");
        }
        queue.get(- phraseStart).prependBefore("<span class=\"" + phraseCode + "\">");
        queue.get(- phraseEnd  ).prependBefore("</span>");
        sentLen = 0;
    } // modifyPhrase
    
    /** Test program - no-op so far
     *  @param args commandline arguments
     */
    public static void main(String args[]) {
    } // main

} // SentenceTester
