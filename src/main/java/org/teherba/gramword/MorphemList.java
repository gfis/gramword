/*  Bean with Properties and methods for words and their grammatical type
    @(#) $Id: MorphemList.java 978 2013-02-04 11:06:08Z gfis $
    2013-01-28: create logger in all constructors
    2008-02-13: Java 1.5 types
    2007-02-16: with log4j
    2006-07-27: load method
    2006-07-24: overwrite 'add' method for 'Ex' expansion
    2006-06-06: copied from NumberSpeller
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
import  java.sql.Connection;
import  java.sql.PreparedStatement;
import  java.sql.ResultSet;
import  java.util.ArrayList;
import  java.util.HashMap;
import  java.util.Iterator;
import  org.apache.log4j.Logger;

/** Properties and methods for lists of {@link Morphem}s.
 *  This class is general and independant of language specifica.
 *  @author Georg Fischer
 */
public class MorphemList extends ArrayList<Morphem> {
    public final static String CVSID = "@(#) $Id: MorphemList.java 978 2013-02-04 11:06:08Z gfis $";
    /** log4j logger (category) */
    private Logger log;

    /** System-dependant newline string (CR/LF for Windows, LF for Unix) */
    private String newline;

    /** No-args Constructor
     */
    public MorphemList() {
        this(32);
    } // Constructor()

    /** Constructor with capacity
     *  @param capacity initial number of array elements
     */
    public MorphemList(int capacity) {
        super(capacity);
        log = Logger.getLogger(MorphemList.class.getName());
        newline = System.getProperty("line.separator");
    } // Constructor(1)

    /** Constructor which loads from a database table;
     *  fills the list with all rows in a database table
     *  which have a specified morphem pattern .
     *  @param con          open database connection
     *  @param table        name of the table to be read
     *  @param morphLike    LIKE pattern for the <em>morph</em> column
     */
    public MorphemList(Connection con, String table, String morphLike) {
        super(512);
        log = Logger.getLogger(MorphemList.class.getName());
        try {
            PreparedStatement pstmt = con.prepareStatement
                    ( "SELECT entry, morph, enrel, morel FROM " + table + " WHERE"
                    + " morph LIKE \'" + morphLike + "\' ORDER BY 1");
            ResultSet resultSet = pstmt.executeQuery();
            while (resultSet.next()) {
                add (new Morphem( resultSet.getString(1)
                                , resultSet.getString(2)
                                , resultSet.getString(3)
                                , resultSet.getString(4)
                                )
                    );
            } // while next
            // System.out.println(this.toString());
            resultSet.close();
            pstmt.close();
        } catch (Exception exc) { // should never occur
            log.error(exc.getMessage(), exc);
        }
    } // Constructor(3)

    /** Adds an element to the list, but if it is an explicit
     *  replacement (starting with <em>Ex</em>),
     *  adds the replacement morphem behind the "Ex" morphem
     *  @param morphem morphem to be added
     */
    public boolean add(Morphem morphem) {
        boolean result = super.add(morphem);
        if (morphem.isExplicitReplacement()) {
            result = super.add(new Morphem(morphem.getEnrel(), morphem.getMorel()));
        }
        return result;
    } // add 1

    /** Adds an element to the list built from 2 strings
     *  (convenience method)
     *  @param entry word of the new element
     *  @param morph grammatical type of that word
     */
    public void add(String entry, String morph) {
        this.add(new Morphem(entry, morph));
    } // add 2

    /** Marks the current stack top element, and then
     *  adds all elements of another <em>MorphemList</em>.
     *  @param list list to be pushed onto the stack
     *  @return index of new top element
     */
    public int pushList(MorphemList list) {
        if (! this.isEmpty()) {
            int top = this.size() - 1;
            Morphem morphem = (Morphem) this.get(top);
            morphem.setOper(Morphem.MARK);
            this.set(top, morphem);
            this.addAll(list);
        }
        return this.size() - 1;
    } // pushList 1

    /** Removes the top element of the list (stack)
     *  @return index of new top element
     */
    public int pop() {
        int top = this.size() - 1;
        if (top >= 0) {
            this.remove(top);
            top --;
        }
        return top;
    } // pop

    /** Removes the top elements of the list (stack)
     *  until the next unmarked element
     *  @return index of new top element
     */
    public int popToUnmarked() {
        int top = this.size() - 1;
        this.remove(top); top --;
        while (top >= 1 && ((Morphem) this.get(top)).isMarked()) {
            this.remove(top); top --;
        }
        return top;
    } // popToUnmarked

    /** Concatenates all marked entries on the list, excluding the first
     *  (dummy) element, and including the top (unmarked) element
     *  @return length of the concatenated string
     */
    public int getEdgeLength() {
        int len = 0;
        int top = this.size() - 1;
        int index = 1; // c.f. dummy element in MorphemTester
        while (index <= top) {
            Morphem morphem = (Morphem) this.get(index);
            if (index == top || morphem.isMarked()) {
                len += morphem.getEntry().length();
            }
            index ++;
        } // while
        return len;
    } // getEdgeLength

    /** Concatenates all <em>entry</em> and <em>morph</em> properties respectively
     *  of the top element and the marked elements in a non-empty list, and
     *  returns a single element built from the parameter and the
     *  concatenated strings, which are stored into
     *  <em>enrel</em> and <em>morel</em>; the <em>morph</em> property
     *  is taken from the top element of the list.
     *  @param word word whose component parts are concatenated,
     *  put into the resulting morphem
     *  @return a <em>Morphem</em> with shows the component parts of
     *  a word
     */
    public Morphem concatenate(String word) {
        StringBuffer enSum = new StringBuffer(128);
        StringBuffer moSum = new StringBuffer(128);
        Morphem morphem = null;
        int top = this.size() - 1;
        int index = 1; // c.f. dummy element in MorphemTester
        while (index <= top) {
            morphem = (Morphem) this.get(index);
            if (index == top || morphem.isMarked()) {
                enSum.append(".").append(morphem.getEntry());
                moSum.append(".").append(morphem.getMorph());
            }
            index ++;
        } // while
        return new Morphem
                ( word
                , morphem.getMorph() + "Conc" // the one from the 'top' element
                , enSum.toString()
                , moSum.toString()
                );
    } // concatenate

    /** Returns all entries in the list in "escape" format.
     *  @return sequence of quadruples: {entry morph enrel morel}
     */
    public String toString() {
        StringBuffer result = new StringBuffer(512);
        Iterator iter = this.iterator();
        while (iter.hasNext()) {
            Morphem morphem = (Morphem) iter.next();
            result.append(morphem.toString());
            result.append(newline);
        } // while
        return result.toString();
    } // toString

    /** Returns all entries as a list suitable for an SQL "IN" clause.
     *  @return a string of the form
     *  <pre>
     *  ('entry1','entry2' ...)
     *  </pre>
     */
    public String getListForSQL() {
        StringBuffer result = new StringBuffer(512);
        HashMap<String, String> words = new HashMap<String, String>(32);
        char sep = '(';
        Iterator iter = this.iterator();
        while (iter.hasNext()) {
            Morphem morphem = (Morphem) iter.next();
            String entry = morphem.getEntry();
            if (words.get(entry) == null) { // did not yet occur
                words.put(entry, entry);
                result.append(sep);
                sep = ',';
                result.append('\'');
                result.append(entry);
                result.append('\'');
                // result.append(newline);
            } // did not yet occur
        } // while
        result.append(')');
        return result.toString();
    } // getListForSQL

    /** Checks whether the contents of the morphem list are
     *  sufficiently probable to determine the word's morphology.
     */
    public boolean isDetermined() {
        return this.size() > 0;
    } // isDetermined

    /** Checks whether the contents of the morphem list are
     *  not yet
     *  sufficiently probable to determine the word's morphology.
     */
    public boolean isUnsure() {
        return this.size() <= 0;
    } // isUnsure

    /** Returns the most relevant entry of the list.
     *  @return the "winning" morphem;
     *  currently, this is the first which is not an explicit replacement
     */
    public Morphem getWinner() {
        Iterator iter = this.iterator();
        Morphem result = null;
        while (result == null && iter.hasNext()) {
            Morphem morphem = (Morphem) iter.next();
            if (! morphem.isExplicitReplacement()) {
                result = morphem;
            }
        } // while
        return result;
    } // getWinner

} // MorphemList
