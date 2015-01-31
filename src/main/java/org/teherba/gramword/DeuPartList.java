/*  Specialized MorphemList with German language heuristics for the 'add' method
    @(#) $Id: DeuPartList.java 36 2008-09-08 06:05:06Z gfis $
    2008-02-13: Java 1.5 types
    2007-02-21: renamed from PartList
    2006-08-03: copied from MorphemList
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
import  org.teherba.gramword.MorphemList;
import  java.util.Iterator;

/**	Specialized <em>MorphemList</em>.
 *  This class contains - in contrast to <em>MorphemList</em> - 
 *  German language specifica like the
 *  <em>attach</em> method which enhances the <em>add</em> method.
 *  @author Dr. Georg Fischer
 */
public class DeuPartList extends MorphemList { 
    public final static String CVSID = "@(#) $Id: DeuPartList.java 36 2008-09-08 06:05:06Z gfis $";

    /** No-args Constructor
     */
    public DeuPartList() {
        super();
    } // Constructor
    
    /** Adds an entry to the array, but in contrast to the
     *  standard <em>add</em> method with some heuristic rules,
     *  for example to avoid "au-s-werfen" or "verb-riefen"
     *  @param entry2 part of a word to be added
     *  @param morph2 morphology of<em>entry</em>
     *  @return the length of <em>entry</em> which was NOT attached
     */
    public int attach(String entry2, String morph2) {
        int result = 0;
        int last = this.size() - 1;
        if (last >= 0) {
            Morphem morphem = (Morphem) this.get(last);
            String entry = morphem.getEntry();
            String morph = morphem.getMorph();
            if (false) {
            } else if (entry.equals("au") && entry2.equals("s") && morph2.equals("Cm")) {
                morphem.setEntry(entry + entry2);
                morphem.setMorph("Pr"); // preposition/prefix "aus"
                this.remove(last);
                this.add(morphem);
            } else if (entry.equals("ei") && entry2.equals("n") && morph2.equals("Cm")) {
                morphem.setEntry(entry + entry2);
                morphem.setMorph("Pr"); // preposition/prefix "ein"
                this.remove(last);
                this.add(morphem);
            } else if (entry.endsWith("er") && entry2.equals("ei")) {
                morphem.setEntry(entry + entry2);
                morphem.setMorph("SbSgFm"); // Maler.ei
                this.remove(last);
                this.add(morphem);
            } else if (morph.equals("Cm") && morph2.equals("Cm")) { // .e.s
                morphem.setEntry(entry + entry2);
                this.remove(last);
                this.add(morphem);
            } else {
                this.add(entry2, morph2);
            }
        } else if (entry2.equals("verb") || entry2.equals("vers")) { // ver.
            result = 1;
            this.add(entry2.substring(0, entry2.length() - result), "PrPref");
        } else {
            this.add(entry2, morph2);
        }
        return result;
    } // attach
    
    /** Concatenates all <em>entry</em> and <em>morph</em> properties
     *  of the list's elements respectively and 
     *  return a single element built from the parameter and the 
     *  two concatenated strings, which are stored into 
     *  <em>enrel</em> and <em>morel</em>.
     *  @param morphem morphem whose <em>entry</em> and <em>morph</em>
     *  properties are put into the return value
     *  @return a <em>Morphem</em> with shows the component parts of 
     *  a word 
     */
    public Morphem pack(Morphem morphem) {
        StringBuffer enSum = new StringBuffer(128);
        StringBuffer moSum = new StringBuffer(128);
        Iterator iter = this.iterator();
        while (iter.hasNext()) {
            Morphem morphem2 = (Morphem) iter.next();
            enSum.append(".").append(morphem2.getEntry());
            moSum.append(".").append(morphem2.getMorph());
        } // while
        return new Morphem 
                ( morphem.getEntry()
                , morphem.getMorph()
                , enSum.toString()
                , moSum.toString()
                );
    } // pack

} // DeuPartList
