/*  Queue of words with surrounding glue (HTML tags, punctuation and whitespace)
    @(#) $Id: SegmentQueue.java 976 2013-02-02 16:44:18Z gfis $
    2016-09-22: moved to subpackage gramword.filter
    2007-04-19: RING_SIZE increased from 16 to 32 for Konto; get returns null and set does nothing if index outside the queue
    2007-02-21: renamed from PartList
    pure ASCII encoding
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
import  org.teherba.gramword.filter.Segment;
import  org.teherba.gramword.Morphem;
import  org.teherba.gramword.MorphemList;
import  org.teherba.xtrans.BaseTransformer;

/** Queue of segments which represent words and their grammatical properties
 *  together with glue (HTML tags, punctuation and whitespace) surrounding them.
 *  The queue is realized by an array which is filled and emptied
 *  by using an index(<em>tail</em>) which runs in a circular manner,
 *  modulo the <em>RING_SIZE</em>.
 *  Initially, all segments in the queue result in empty strings.
 *  @author Dr. Georg Fischer
 */
public class SegmentQueue {
    public final static String CVSID = "@(#) $Id: SegmentQueue.java 976 2013-02-02 16:44:18Z gfis $";

    /** Size of the ring, which should be a power of 2,
     *  and which should be sufficient for the longest sentence to be analysed.
     */
    private static final int RING_SIZE = 256;
    /** Array of <em>Segment</em>s for the words in the ring */
    private Segment[] segments;
    /** The head of the queue is the element that has been on the queue for the longest time.
     *  If the ring buffer is full, {@link #head} is the same as {@link #tail}.
     *  Otherwise the content element range is [head..[tail,though head maybe > tail because
     *  of the modulo {@link #RING_SIZE} arithmetic for queue indices.
     */
    private int head;
    /** The tail of the queue is the first element behind the element
     *  that has been on the queue the shortest time.
     *  New elements are inserted at the tail of the queue.
     */
    private int tail;
    /** (Positive) distance between the interesting element and the tail of the queue */
    private int lookAhead;
    /** Serializer for output of queue elements */
    private BaseTransformer transformer;

    /** No-args Constructor.
     *  Initially, all segments in the queue return empty strings.
     */
    public SegmentQueue() {
        this(8, new BaseTransformer()); // moderate lookAhead
    } // Constructor

    /** Constructor with lookahead.
     *  @param lookAhead distance between interesting and tail element.
     *  This should not be changed during queue processing.
     *  Initially, all segments in the queue return empty strings.
     */
    public SegmentQueue(int lookAhead, BaseTransformer transformer) {
        segments = new Segment[RING_SIZE];
        tail = 0;
        while (tail < RING_SIZE) {
            segments[tail ++] = new Segment();
        }
        tail = 0;
        this.lookAhead   = lookAhead;
        setTransformer(transformer);
    } // Constructor

    /** Gets the size of the queue, that is the overall length of the ring buffer.
     *  This is not the number of elements with content-
     *  @return maximum number of queue elements
     */
    public int size() {
        return RING_SIZE;
    } // size

    /** Gets the lookahead distance (positive)
     *  @return number of queue elements between the interesting and the tail element
     */
    public int getLookAhead() {
        return lookAhead;
    } // getLookAhead

    /** Gets the transformer used fot serializing
     *  @return underlaying transformer
     */
    public BaseTransformer getTransformer() {
        return transformer;
    } // getTransformer

    /** Sets the transformer used fot serializing
     *  @param transformer underlaying transformer
     */
    public void setTransformer(BaseTransformer transformer) {
        this.transformer = transformer;
    } // setTransformer

    /** Gets the segment last stored in the queue (offset 0), or one
     *  previously stored (offsets -1, -2 and so on).
     *  @param offset must be non-positive: 0 = current element,
     *  -1 = the one stored before the current and so on
     *  @return the segment at the specified offset, or null if
     *  the index (modulo {@link #RING_SIZE} is outside the valid queue elements
     */
    public Segment get(int offset) {
        Segment result = null;
        int index = tail + offset;
        if (index < 0) {
            index += RING_SIZE;
        }
        if (index < RING_SIZE && index >= 0) {
            result = segments[index];
        }
        return result;
    } // get

    /** Gets the element which is on focus.
     *  @return an element of the queue.
     *  {@link #lookAhead} more elements are queued up to and including {@link #tail}.
     */
    public Segment getFocus() {
        return get(- lookAhead);
    } // getFocus

    /** Gets the index of the next free element
     *  @return {@link #tail}
     */
    public int getTail() {
        return tail;
    } // getTail

    /** Sets the segment last stored in the queue (offset 0), or one
     *  previously stored (offsets -1, -2 and so on).
     *  Nothing is set if the resulting index points outside the queue.
     *  @param offset must be non-positive: 0 = current element,
     *  -1 = the one stored before the current and so on
     *  @param segment the segment to be set at the specified offset
     */
    public void set(int offset, Segment segment) {
        int index = tail + offset;
        if (index < 0) {
            index += RING_SIZE;
        }
        if (index < RING_SIZE && index >= 0) {
            segments[index] = segment;
        }
    } // set

    /** Adds a segment to the queue.
     *  @param segment segment to be appended to the end of the queue
     *  The string value of the oldest segment in the queue,
     *  which is shifted out of the queue (maybe empty in the beginning),
     *  will be written by the registered serializer.
     */
    public void add(Segment segment) {
        tail ++;
        if (tail >= RING_SIZE) {
            tail = 0;
        }
        String result = segments[tail].toString();
        segments[tail] = segment;
        if (transformer != null) {
            transformer.getCharWriter().print(result); // previous content of the current element
        } else {
            System.out.print(result);
        }
    } // add

    /** Inserts a string before the glue before the current word
     *  @param glue string to be prepended to the the prefix glue
     */
    public void prependBefore(String glue) {
        segments[tail].prependBefore(glue);
    } // prependBefore

    /** Inserts a string before the glue behind the current word
     *  @param glue string to be prepended to the the suffix glue
     */
    public void prependBehind(String glue) {
        segments[tail].prependBehind(glue);
    } // prependBehind

    /** Appends a string to the glue before the current word
     *  @param glue string to be appended to the the prefix glue
     */
    public void appendBefore(String glue) {
        segments[tail].appendBefore(glue);
    } // appendBefore

    /** Appends a string to the glue behind the current word
     *  @param glue string to be appended to the the suffix glue
     */
    public void appendBehind(String glue) {
        segments[tail].appendBehind(glue);
    } // appendBehind

    /** Return the concatenation of all remaining elements in the ring
     *  @return words and following glue concatenated
     */
    public String flush() {
        StringBuffer result = new StringBuffer(256);
        int occupied = RING_SIZE;
        while (occupied > 0) {
            // System.out.println("occupied: " + occupied + ", tail: " + tail);
            tail ++;
            if (tail >= RING_SIZE) {
                tail = 0;
            }
            result.append(segments[tail].toString());
            occupied --;
        }
        return result.toString();
    } // flush

    /** Test program - creates segments, fills them and prints the contents.
     *  @param args commandline arguments: number of elements to be filled
     */
    public static void main(String args[]) {
        SegmentQueue queue = new SegmentQueue(8, null);
        Segment punctSegm = new Segment(new Morphem(".", Morphem.PUNCT));
        System.out.println(punctSegm.toString() + " isPunct ? " + punctSegm.isPunct(".")); 
        queue.add(punctSegm);
        queue.add(new Segment(new Morphem("8", Morphem.NUMBER)));
        queue.add(new Segment(new Morphem("A", Morphem.WORD  )));
        queue.add(new Segment(new Morphem("E", Morphem.EMPTY )));
        MorphemList morphems = 
                new MorphemList (new Morphem("die", "PnPersSgFm"));
        morphems.add            (new Morphem("die", "PnPersPl"));
        Segment wordSegm = new Segment("", morphems, "");
        System.out.println(wordSegm.toString() + " contains PnRelt ? " + wordSegm.contains("PnRelt")); 
        morphems.add            (new Morphem("die", "PnReltNomvSgFm"));
        System.out.println(wordSegm.toString() + " contains PnRelt ? " + wordSegm.contains("PnRelt")); 
        System.out.print(queue.flush());
        System.out.println();
    } // main

} // SegmentQueue
