/*  Bean with properties and methods for words
    and surrounding glue (HTML tags, whitespace and punctuation)
    @(#) $Id: Segment.java 976 2013-02-02 16:44:18Z gfis $
    2007-02-23: copied from Morphem.java
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

package org.teherba.gramword;
import  org.teherba.gramword.Morphem;

/** Bean with properties and methods for a word (with grammatical properties)
 *  and its surrounding glue (HTML tags, whitespace and punctuation)
 *  @author Dr. Georg Fischer
 */
public class Segment { 
    public final static String CVSID = "@(#) $Id: Segment.java 976 2013-02-02 16:44:18Z gfis $";

    /** The Morphem (word with grammatical properties) at the center of the segment */
    private Morphem morphem;
    /** Glue (tags, whitespace and punctuation) before the word */
    private StringBuffer prefix;
    /** Glue (tags, whitespace and punctuation) behind the word */
    private StringBuffer suffix;
    /** Length of glue string buffers */
    private static final int GLUE_SIZE = 128;
    /** Whether this segment is contained in a link (HTML "a" element) */
    private boolean inLink;

    /** No-args Constructor
     */
    public Segment() {
        this("", new Morphem(), "");
    } // Constructor()

    /** Constructor with prefix, morphem and suffix
     *  @param before glue before the word (or empty string)
     *  @param morphem the word and its grammatical properties
     *  @param behind glue behind the word (or empty string)
     */
    public Segment(String before, Morphem morphem, String behind) {
        this.morphem = morphem;
        prefix = new StringBuffer(GLUE_SIZE);
        prefix.append(before);
        suffix = new StringBuffer(GLUE_SIZE);
        suffix.append(behind);
        inLink = false;
    } // Constructor(3)

    /** Constructor with         morphem and suffix
     *  @param morphem the word and its grammatical properties
     *  @param behind glue behind the word (or empty string)
     */
    public Segment(               Morphem morphem, String behind) {
        this.morphem = morphem;
        prefix = new StringBuffer(8);
        suffix = new StringBuffer(GLUE_SIZE);
        suffix.append(behind);
    } // Constructor(2)

    /** Sets the word with its grammatical type.
     *  @param morphem morphem for the word
     */
    public void setMorphem(Morphem morphem) { 
        this.morphem = morphem;
    } // setMorphem
    
    /** Gets the word with its grammatical type.
     *  @return morphem for the word
     */
    public Morphem getMorphem() { 
        return morphem;
    } // getMorphem
    
    /** Inserts a string before the glue before the word
     *  @param glue string to be prepended to the the prefix glue
     */
    public void prependBefore(String glue) { 
        prefix.insert(0, glue);
    } // prependBefore

    /** Inserts a string before the glue behind the word
     *  @param glue string to be prepended to the the suffix glue
     */
    public void prependBehind(String glue) { 
        suffix.insert(0, glue);
    } // prependBehind

    /** Appends a string to the glue before the word
     *  @param glue string to be appended to the the prefix glue
     */
    public void appendBefore(String glue) { 
        prefix.append(glue);
    } // appendBefore

    /** Appends a string to the glue behind the word
     *  @param glue string to be appended to the the suffix glue
     */
    public void appendBehind(String glue) { 
        suffix.append(glue);
    } // appendBehind

    /** Returns the prefix 
     *  @return glue before the word
     */
    public String getPrefix() { 
        return prefix.toString();
    } // getSuffix
    
    /** Returns the suffix 
     *  @return glue behind the word
     */
    public String getSuffix() { 
        return suffix.toString();
    } // setSuffix
    
    /** Returns the link property
     *  @return whether this segment is contained in a link (HTML "a" element)
     */
    public boolean getInLink() { 
        return inLink;
    } // getInLink
    
    /** Sets the link property
     *  @param link whether this segment is contained in a link (HTML "a" element)
     */
    public void setInLink(boolean link) { 
        inLink = link;
    } // setInLink
    
    /** Returns the string representation of this segment
     *  @return prefix glue concatenated with word concatenated with suffix glue
     */
    public String toString() { 
        return prefix.toString() + morphem.getEntry() + suffix.toString();
    } // toString
    
} // Segment
