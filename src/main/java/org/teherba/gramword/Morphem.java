/*  Bean with properties and methods for (parts of) words, 
    their grammatical type and optional additional information
    @(#) $Id: Morphem.java 978 2013-02-04 11:06:08Z gfis $
    2016-09-25: codes PUNCT, WORD
    2013-02-04: codes for particles in morph, morel
    2013-02-03: toString not escaped; clone()
    2006-08-02: toString and prio
    2006-07-18: with enrel, morel instead
    2006-06-09: with descr
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
import  java.lang.Cloneable;

/** Bean with properties and methods for (parts of) words, 
 *  their grammatical type and optional additional information
 *  @author Dr. Georg Fischer
 */
public class Morphem implements Cloneable { 
    public final static String CVSID = "@(#) $Id: Morphem.java 978 2013-02-04 11:06:08Z gfis $";

    /** The entry to be classified */
    private String entry;
    /** The grammatical type of the entry */
    private String morph;
    /** an optional word which is somehow related to <em>entry</em> */
    private String enrel;
    /** The grammatical type of the related word */
    private String morel;

    /** Operation code (bit pattern) for sequences of morphems, 
     *  to be thought behind the element 
     */
    private int oper; // sum of the following codes
    /** Alternate possibility (default) */
    public static final int OR   = 1;
    /** Sequence, Concatenation */
    public static final int PLUS = 2;
    /** Marker on stack */
    public static final int MARK = 4;
    
    /** Priority for this morphem (1 = highest) */
    private int prio;
    /** Highest priority */
    public static final int MAX_PRIO = 1;
    /** Medium  priority */
    public static final int MED_PRIO = 2;
    /** Low     priority */
    public static final int LOW_PRIO = 3;
    /** Lowest  priority */
    public static final int MIN_PRIO = 4;

    //====================================================
    // Particle codes for {@link #morph} and {@link morel}
    //----------------
    /** Code for empty elements       */
    public static final String EMPTY        = "";
    
    // Word classes
    /** Code for adjectives           */
    public static final String ADJECT       = "Aj";
    /** Code for substantives         */
    public static final String SUBSTAN      = "Sb";
    /** Code for verbs                */
    public static final String VERB         = "Vb";
    /** Code for numbers              */
    public static final String NUMBER       = "Nu";
    /** Code for punctuation          */
    public static final String PUNCT        = "Pu";
    /** Code for unrecognized words   */
    public static final String WORD         = "Xy";
    
    // Attitudes and times
    /** Code for gerundium            */
    public static final String GERUND       = "Ge";
    /** Code for imperative           */
    public static final String IMPER        = "Im";
    /** Code for infinitive           */
    public static final String INFIN        = "In";
    /** Code for perfect              */
    public static final String PERF         = "Pf";
    /** Code for praeteritum          */
    public static final String PRAET        = "Pt";
    /** Code for present time         */
    public static final String PRESENT      = "Pr";

    // Person and Numerus
    /** Code for 1st person singular  */
    public static final String ME           = "11";
    /** Code for 2nd person singular  */
    public static final String YO           = "12";
    /** Code for 3rd person singular  */
    public static final String HI           = "13";
    /** Code for 1st person plural    */
    public static final String US           = "91";
    /** Code for 2nd person plural    */
    public static final String Y2           = "92";
    /** Code for 3rd person plural    */
    public static final String TH           = "93";
    /** Code for unspecified person   */
    public static final String UN           = "0";

    // Gender             
    /** Code for masculine            */
    public static final String MASC         = "Ms";
    /** Code for feminine             */
    public static final String FEMI         = "Fm";
    /** Code for neuter               */
    public static final String NEUT         = "Nt";

    // Numerus             
    /** Code for singular             */
    public static final String SING         = "1";
    /** Code for plural               */
    public static final String PLUR         = "9";

    // Cases
    /** Code for nominative           */
    public static final String NOM          = "Nom";
    /** Code for genitive             */
    public static final String GEN          = "Gen";
    /** Code for dative               */
    public static final String DAT          = "Dat";
    /** Code for accusative           */
    public static final String ACC          = "Acc";
    /** Code for ablative             */
    public static final String ABL          = "Abl";

    // Comparision
    /** Code for positive             */
    public static final String POST         = "Pos";
    /** Code for comparative          */
    public static final String COMP         = "Cmp";
    /** Code for superlative          */
    public static final String SUPL         = "Sup";

    // Determination
    /** Code for determined article   */
    public static final String DET          = "Det";
    /** Code for undetermined article */
    public static final String UND          = "Und";
    /** Code for absent article       */
    public static final String ABS          = "Abs";
    
    //=========================
    // Construction and Cloning
    //=========================
    /** Empty Constructor
     */
    public Morphem() {
        this(""   , EMPTY, "", "");
    } // Constructor()

    /** Constructor for word 
     *  @param entry the entry to be classified
     */
    public Morphem(String entry) {
        this(entry, EMPTY, "", "");
    } // Constructor(1)

    /** Constructor for word and type
     *  @param entry the entry to be classified
     *  @param morph the grammatical type of <em>entry</em>
     */
    public Morphem(String entry, String morph) {
        this(entry, morph, "", "");
    } // Constructor(2)

    /** Constructor for word and related word
     *  @param entry the entry to be classified
     *  @param morph the grammatical type of <em>entry</em>
     *  @param enrel optional word which is somehow related to <em>entry</em> 
     *  @param morel description / additional (semantic) information for <em>entry</em>
     */
    public Morphem(String entry, String morph, String enrel, String morel) {
        this.entry  = entry;
        this.morph  = morph;
        this.enrel  = (enrel == null) ? "" : enrel;
        this.morel  = (morel == null) ? "" : morel;
        this.prio   = MAX_PRIO;
        this.oper   = OR;
    } // Constructor(4)

    /** Clones a Morphem
     */
    public Morphem clone(){
        Morphem result = new Morphem
                ( this.entry
                , this.morph
                , this.enrel
                , this.morel
                );
        result.setPrio(this.getPrio());
        result.setOper(this.getOper());
        return result;
    } // clone
    //=====================================
    // Bean getters and setters
    //=====================================
    /** Sets the word whose grammatical type is determined.
     *  @param entry the entry to be classified
     */
    public void setEntry(String entry) { 
        this.entry = entry;
    } // setEntry
    
    /** Gets the word whose grammatical type is determined.
     *  @return the entry to be classified
     */
    public String getEntry() { 
        return entry;
    } // getEntry
    
    /** Sets the morphology of the <em>entry</em>.
     *  @param morph grammatical type of <em>entry</em>
     */
    public void setMorph(String morph) { 
        this.morph = morph;
    } // setMorph

    /** Gets the morphology of the <em>entry</em>.
     *  @return grammatical type of <em>entry</em>
     */
    public String getMorph() { 
        return morph;
    } // getMorph
    
    /** Sets another word which is related to the <em>entry</em>.
     *  @param enrel optional word which is somehow related to <em>entry</em> 
     */
    public void setEnrel(String enrel) { 
        this.enrel = (enrel == null) ? "" : enrel;
    } // setEnrel

    /** Gets another word which is related to the <em>entry</em>.
     *  @return optional word which is somehow related to <em>entry</em> 
     */
    public String getEnrel() { 
        return enrel;
    } // getEnrel
    
    /** Sets the morphology of <em>enrel</em>.
     *  @param morel grammatical type of <em>enrel</em>
     */
    public void setMorel(String morel) { 
        this.morel = morel;
    } // setMorel

    /** Gets the morphology of <em>enrel</em>.
     *  @return grammatical type of <em>entry</em>
     */
    public String getMorel() { 
        return morel;
    } // getMorel

    /** Sets the operation (plus, or, mark).
     *  @param oper code for the operation
     */
    public void setOper(int oper) { 
        this.oper = oper;
    } // setOper

    /** Sets the operation (plus, or, mark).
     *  @return code for the operation
     */
    public int getOper() { 
        return oper;
    } // getOper
    
    /** Sets the priority (quality).
     *  @param priority a small number: 1, 2, 3
     */
    public void setPrio(int priority) { 
        this.prio  = priority;
    } // setPrio

    /** Gets the priority (quality) 
     *  @return a small number: 1, 2, 3
     */
    public int getPrio() { 
        return prio;
    } // getPrio
    
    //=====================
    // Utility methods
    //=====================
    /** Sets the entry together with its morphology.
     *  @param morph grammatical type of <em>entry</em>
     *  @param entry the entry to be classified
     */
    public void setMorphEntry(String morph, String entry) { 
        this.morph = morph;
        this.entry = entry;
    } // setMorphEntry

    /** Tests whether the morphem indicates an explicit replacement
     *  (code "Ex").
     *  @return whether the morphem indicates an explicit replacement
     */
    public boolean isExplicitReplacement() { 
        return morph.startsWith("Ex");
    } // isExplicitReplacement

    /** Tests whether the morphem is marked (on a stack)
     *  @return whether the <em>MARK</em> bit is set
     */
    public boolean isMarked() { 
        return (oper & MARK) != 0;
    } // isMarked

    /** Separator for properties of the morphem */
    private static final char SEP = '\t';
    
    /** Represents the morphem in "escape" format.
     *  @return string representation: "{entry morph enrel morel}"
     */
    public String toString() { 
        StringBuffer result = new StringBuffer(128);
        result.append(entry);
        if (morph != null && ! morph.equals("")) {
            result.append(SEP).append(morph);
            if (enrel != null && ! enrel.equals("")) {
                result.append(SEP).append(enrel);
                if (morel != null && ! morel.equals("")) {
                    result.append(SEP).append(morel);
                }
            }
        }
        if (isMarked()) {
            result.append(SEP);
            result.append("#");
        }
        return result.toString();
    } // toString
    
} // Morphem
