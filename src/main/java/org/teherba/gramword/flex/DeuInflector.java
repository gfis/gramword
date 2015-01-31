/*  Class for conjugation and declination of words in Deutsch (German)
    @(#) $Id: DeuInflector.java 978 2013-02-04 11:06:08Z gfis $
    2013-01-27, Georg Fischer: copied from flex.BaseSpeller

    caution: UTF-8 is essential! ("[^a-zA-ZäöüÄÖÜßáéíóúÉÓÚàèìòùÀÈÌÒÙâêîôûÂÊÎÔÛåøçãõ]+");
*/
/*
 * Copyright 2013 Dr. Georg Fischer <punctum at punctum dot kom>
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

package org.teherba.gramword.flex;
import  org.teherba.gramword.Morphem;
import  org.teherba.gramword.MorphemList;
import  org.teherba.gramword.flex.BaseInflector;
import  java.util.HashMap;
import  java.util.Iterator;
import  java.util.regex.Matcher;
import  java.util.regex.Pattern;

/** Base class for number spellers defining common properties and methods.
 *  @author Dr. Georg Fischer
 */
public class DeuInflector extends BaseInflector {
    public final static String CVSID = "@(#) $Id: DeuInflector.java 978 2013-02-04 11:06:08Z gfis $";
    /** whether to write debugging output */
    protected final static boolean DEBUG = true;

    /** Constructor
     */
    public DeuInflector() {
    	setIso639("de,deu");
    	setDescription("Deutsch");
        setPersons();
        setAttitudes();
    } // Constructor()

    //=====================================
    /** Set the personal pronouns for list presentation
     */
    public void setPersons() {
        super.setPersons();
        addPerson(Morphem.ME, "ich");
        addPerson(Morphem.YO, "du");
        addPerson(Morphem.HI, "er/sie/es");
        addPerson(Morphem.US, "wir");
        addPerson(Morphem.Y2, "ihr");
        addPerson(Morphem.TH, "sie");
        addPerson(Morphem.UN, ""   );
    } // setPersons
    
    /** Set the attitudes for list presentation
     */
    public void setAttitudes() {
        super.setAttitudes();
        addAttitude(Morphem.PRESENT	, "Präsens");
        addAttitude(Morphem.PRAET	, "Präteritum");
        addAttitude(Morphem.INFIN	, "Infinitiv");
        addAttitude(Morphem.IMPER	, "Imperativ");
        addAttitude(Morphem.GERUND	, "Partizip II");
   } // setAttitudes

    //=====================================
    // inflecting methods
    //=====================================
    
    /** Conjugates a regular ("weak") German verb and generates the forms for
     *  all persons, numeri and tempi.
     *  This method works only for verbs without vowel transformations. 
     *  Sometimes it inserts an <em>e</em> or omits an <em>s</em>.
     *  {@see http://www.school-scout.de/extracts/28590/28590.pdf?file=1}
     *  @parm level how many forms should be generated: 1 = few, 2 = more, 3 = even more, 4 = all (with participe declination)
     *  @param word the verb's infinitive form ending with <em>-en, -eln, -ern, -ieren</em>
     *  @result list of generated morphems
     */
    public MorphemList conjugateVb(int level, String word) {
        MorphemList result  = new MorphemList();
        String prefix       = "";
        boolean nonFix      = false;
        boolean geParticipe = true;
        String infinitive   = word;
        int lastPos = word.lastIndexOf('/');
        if (lastPos >= 0) {
        	nonFix = true;
        } else {
        	lastPos = word.lastIndexOf('-');
        }
        if (lastPos >= 0) {
        	infinitive = word.substring(   lastPos + 1);
        	prefix     = word.substring(0, lastPos).replaceAll("[\\/\\-]", "");
        }
        int endingLength = 2;
        if (false) {
        } else if (infinitive.endsWith("ieren")) {
        	geParticipe = false;
        	endingLength = 2;
        } else if (infinitive.endsWith("en")) {
        	endingLength = 2;
        } else if (infinitive.endsWith("eln")) {
        	endingLength = 1;
        } else if (infinitive.endsWith("ern")) {
        	endingLength = 1;
		} else {
			System.err.println("probably no German infinitive: " + word);
			return result;
		}
        String root     = infinitive.substring(0, infinitive.length() - endingLength);
        String ending   = infinitive.substring(   infinitive.length() - endingLength);
        String appendix = "";
        if (nonFix) {
        	if (level >= 3) appendix = " ... " + prefix;
        } else {
        	root = prefix + root;
        }
		String roote = root;
		if (	root.endsWith("d")
			||  root.endsWith("t")
			||  ((root.endsWith("m") || root.endsWith("n")) && root.matches(".*[bcdfghjkpqstvwzß][mn]")) // consonant except l r m n
				) {
			roote += "e";
		}
		// Infinitiv
		String 
		morph = Morphem.VERB + Morphem.INFIN;
		Morphem form = new Morphem(prefix + infinitive, morph + Morphem.UN, root, morph + Morphem.UN + ending); 
		if (level >= 2) result.add(form.clone());
        
        // Präsens  	
        morph = Morphem.VERB + Morphem.PRESENT;
        form.setMorphEntry(morph + Morphem.ME, root  + (infinitive.endsWith(".eln") ? "" : "e") + appendix); 
        if (level >= 2) result.add(form.clone());
        form.setMorphEntry(morph + Morphem.YO, roote + (root.matches(".*[szxß]") ? "t"   : "st")  + appendix); 
        if (level >= 1) result.add(form.clone());
        form.setMorphEntry(morph + Morphem.HI, roote + "t"		+ appendix); 
        if (level >= 2) result.add(form.clone());
        form.setMorphEntry(morph + Morphem.US, root  + ending	+ appendix); 
        if (level >= 2) result.add(form.clone());
        form.setMorphEntry(morph + Morphem.Y2, roote + "t"		+ appendix); 
        if (level >= 2) result.add(form.clone());
        form.setMorphEntry(morph + Morphem.TH, root  + ending	+ appendix); 
        if (level >= 2) result.add(form.clone());

        // Präteritum
        morph = Morphem.VERB + Morphem.PRAET;
        form.setMorphEntry(morph + Morphem.ME, roote + "te"		+ appendix); 
        if (level >= 1) result.add(form.clone());
        form.setMorphEntry(morph + Morphem.YO, roote + "test"	+ appendix); 
        if (level >= 1) result.add(form.clone());
        form.setMorphEntry(morph + Morphem.HI, roote + "te"		+ appendix); 
        if (level >= 2) result.add(form.clone());
        form.setMorphEntry(morph + Morphem.US, roote + "ten"  	+ appendix); 
        if (level >= 1) result.add(form.clone());
        form.setMorphEntry(morph + Morphem.Y2, roote + "tet"	+ appendix); 
        if (level >= 1) result.add(form.clone());
        form.setMorphEntry(morph + Morphem.TH, roote + "ten" 	+ appendix); 
        if (level >= 2) result.add(form.clone());
        
		// Partizip
        morph = Morphem.VERB + "Pz"           + Morphem.UN;
        form.setMorphEntry(morph, prefix + infinitive + "d");
        if (level >= 1) result.add(form.clone());
        if (level >= 1) result.pushList(declinateAj(level, form.getEntry()));
		
        // Partizip II                           
        morph = Morphem.VERB + Morphem.GERUND + Morphem.UN;
        if (nonFix) {
	        form.setMorphEntry(morph, prefix + "ge" + roote + "t"); 
        } else {
    	    form.setMorphEntry(morph,                 roote + "t" + appendix); 
        }
        if (level >= 2) result.add(form.clone());

		// Declinations of participe
        if (level >= 2) result.pushList(declinateAj(level, form.getEntry()));
 
        return result;
    } // conjugateVb(2)

    /** Declinates a regular German adjective and generates all forms for
     *  case, person, numerus and type of determinism (but no comparision level).
     *  Sometimes it omits an <em>e</em>,
     *  {@see http://deutsch.lingolia.com/de/grammatik/adjektive/deklination}.
     *  @parm level how many forms should be generated: 1 = few, 2 = more, 3 = even more, 4 = all
     *  @param adjective the adjective (or participe)
     *  @result list of generated morphems
     */
    public MorphemList declinateAj(int level, String word) {
        MorphemList result  = new MorphemList();
		String root = word;
        int endingLength = 0;
        if (false) {
        } else if (word.endsWith("e" )) {
        	root = word.substring(0, word.length() - 1);
        } else if (word.endsWith("el")) {
        	root = word.substring(0, word.length() - 2) + "l";
        } else if (word.endsWith("er")) {
        	root = word.substring(0, word.length() - 2) + "r";
        } else if (word.endsWith("hoch")) { // irregular
        	root = "hoh"; 
		} else {
		}
		String 
		morph = Morphem.ADJECT;
		Morphem form = new Morphem(word, morph, word, morph); 
		if (level >= 2) result.add(form.clone());
        
		// determined article
		// Nominative
        morph = Morphem.ADJECT + Morphem.DET + Morphem.NOM;
        form.setMorphEntry(morph + Morphem.SING + Morphem.MASC, root + "e" ); 
        if (level >= 2) result.add(form.clone());
        form.setMorphEntry(morph + Morphem.SING + Morphem.FEMI, root + "e" ); 
        if (level >= 2) result.add(form.clone());
        form.setMorphEntry(morph + Morphem.SING + Morphem.NEUT, root + "e" ); 
        if (level >= 2) result.add(form.clone());
        form.setMorphEntry(morph + Morphem.PLUR               , root + "en"); 
        if (level >= 1) result.add(form.clone());
		// Genitive
        morph = Morphem.ADJECT + Morphem.DET + Morphem.GEN;
        form.setMorphEntry(morph + Morphem.SING + Morphem.MASC, root + "en"); 
        if (level >= 2) result.add(form.clone());
        form.setMorphEntry(morph + Morphem.SING + Morphem.FEMI, root + "en"); 
        if (level >= 2) result.add(form.clone());
        form.setMorphEntry(morph + Morphem.SING + Morphem.NEUT, root + "en"); 
        if (level >= 2) result.add(form.clone());
        form.setMorphEntry(morph + Morphem.PLUR               , root + "en"); 
        if (level >= 2) result.add(form.clone());
		// Dative
        morph = Morphem.ADJECT + Morphem.DET + Morphem.DAT;
        form.setMorphEntry(morph + Morphem.SING + Morphem.MASC, root + "en"); 
        if (level >= 2) result.add(form.clone());
        form.setMorphEntry(morph + Morphem.SING + Morphem.FEMI, root + "en"); 
        if (level >= 2) result.add(form.clone());
        form.setMorphEntry(morph + Morphem.SING + Morphem.NEUT, root + "en"); 
        if (level >= 2) result.add(form.clone());
        form.setMorphEntry(morph + Morphem.PLUR               , root + "en"); 
        if (level >= 2) result.add(form.clone());
		// Accusative
        morph = Morphem.ADJECT + Morphem.DET + Morphem.ACC;
        form.setMorphEntry(morph + Morphem.SING + Morphem.MASC, root + "en"); 
        if (level >= 2) result.add(form.clone());
        form.setMorphEntry(morph + Morphem.SING + Morphem.FEMI, root + "e" ); 
        if (level >= 2) result.add(form.clone());
        form.setMorphEntry(morph + Morphem.SING + Morphem.NEUT, root + "e" ); 
        if (level >= 2) result.add(form.clone());
        form.setMorphEntry(morph + Morphem.PLUR               , root + "en"); 
        if (level >= 2) result.add(form.clone());

		// undetermined article
		// Nominative
        morph = Morphem.ADJECT + Morphem.UND + Morphem.NOM;
        form.setMorphEntry(morph + Morphem.SING + Morphem.MASC, root + "er"); 
        if (level >= 1) result.add(form.clone());
        form.setMorphEntry(morph + Morphem.SING + Morphem.FEMI, root + "e" ); 
        if (level >= 1) result.add(form.clone());
        form.setMorphEntry(morph + Morphem.SING + Morphem.NEUT, root + "es"); 
        if (level >= 1) result.add(form.clone());
		// Genitive
        morph = Morphem.ADJECT + Morphem.UND + Morphem.GEN;
        form.setMorphEntry(morph + Morphem.SING + Morphem.MASC, root + "en"); 
        if (level >= 2) result.add(form.clone());
        form.setMorphEntry(morph + Morphem.SING + Morphem.FEMI, root + "en"); 
        if (level >= 2) result.add(form.clone());
        form.setMorphEntry(morph + Morphem.SING + Morphem.NEUT, root + "en"	); 
        if (level >= 2) result.add(form.clone());
		// Dative
        morph = Morphem.ADJECT + Morphem.UND + Morphem.DAT;
        form.setMorphEntry(morph + Morphem.SING + Morphem.MASC, root + "en"); 
        if (level >= 2) result.add(form.clone());
        form.setMorphEntry(morph + Morphem.SING + Morphem.FEMI, root + "en"); 
        if (level >= 2) result.add(form.clone());
        form.setMorphEntry(morph + Morphem.SING + Morphem.NEUT, root + "en"	); 
        if (level >= 2) result.add(form.clone());
		// Accusative
        morph = Morphem.ADJECT + Morphem.UND + Morphem.ACC;
        form.setMorphEntry(morph + Morphem.SING + Morphem.MASC, root + "en"); 
        if (level >= 2) result.add(form.clone());
        form.setMorphEntry(morph + Morphem.SING + Morphem.FEMI, root + "e" ); 
        if (level >= 2) result.add(form.clone());
        form.setMorphEntry(morph + Morphem.SING + Morphem.NEUT, root + "es"); 
        if (level >= 2) result.add(form.clone());

		// absent article
		// Nominative
        morph = Morphem.ADJECT + Morphem.ABS + Morphem.NOM;
        form.setMorphEntry(morph + Morphem.SING + Morphem.MASC, root + "er"); 
        if (level >= 2) result.add(form.clone());
        form.setMorphEntry(morph + Morphem.SING + Morphem.FEMI, root + "e" ); 
        if (level >= 2) result.add(form.clone());
        form.setMorphEntry(morph + Morphem.SING + Morphem.NEUT, root + "es"); 
        if (level >= 2) result.add(form.clone());
        form.setMorphEntry(morph + Morphem.PLUR               , root + "e" ); 
        if (level >= 2) result.add(form.clone());
		// Genitive
        morph = Morphem.ADJECT + Morphem.ABS + Morphem.GEN;
        form.setMorphEntry(morph + Morphem.SING + Morphem.MASC, root + "en"); 
        if (level >= 2) result.add(form.clone());
        form.setMorphEntry(morph + Morphem.SING + Morphem.FEMI, root + "er"); 
        if (level >= 2) result.add(form.clone());
        form.setMorphEntry(morph + Morphem.SING + Morphem.NEUT, root + "en"); 
        if (level >= 2) result.add(form.clone());
        form.setMorphEntry(morph + Morphem.PLUR               , root + "er"); 
        if (level >= 2) result.add(form.clone());
		// Dative
        morph = Morphem.ADJECT + Morphem.ABS + Morphem.DAT;
        form.setMorphEntry(morph + Morphem.SING + Morphem.MASC, root + "em"); 
        if (level >= 1) result.add(form.clone());
        form.setMorphEntry(morph + Morphem.SING + Morphem.FEMI, root + "er"); 
        if (level >= 2) result.add(form.clone());
        form.setMorphEntry(morph + Morphem.SING + Morphem.NEUT, root + "em"); 
        if (level >= 2) result.add(form.clone());
        form.setMorphEntry(morph + Morphem.PLUR               , root + "en"); 
        if (level >= 2) result.add(form.clone());
		// Accusative
        morph = Morphem.ADJECT + Morphem.ABS + Morphem.ACC;
        form.setMorphEntry(morph + Morphem.SING + Morphem.MASC, root + "en"); 
        if (level >= 2) result.add(form.clone());
        form.setMorphEntry(morph + Morphem.SING + Morphem.FEMI, root + "e" ); 
        if (level >= 2) result.add(form.clone());
        form.setMorphEntry(morph + Morphem.SING + Morphem.NEUT, root + "es"); 
        if (level >= 2) result.add(form.clone());
        form.setMorphEntry(morph + Morphem.PLUR               , root + "e" ); 
        if (level >= 2) result.add(form.clone());

        return result;
    } // declinateAj(2)

    /** Main program, conjugates and/or declinates one word
     *  @param args commandline arguments: 
     *  <pre>
     *    wordclass level word
     *  </pre>
     */
    public static void main(String args[]) {
        // get the commandline arguments
        int level = 1;
        int iarg = 0;
        String wordClass = args[iarg ++];
        try{
            level = Integer.parseInt(args[iarg ++]);
        } catch (Exception exc) {
        }
        String word = args[iarg ++];
        
        BaseInflector inflector = new DeuInflector();
        MorphemList forms = null;
        if (false) {
        } else if (wordClass.startsWith("Aj")) {
        	forms = inflector.declinateAj(level, word);
        } else if (wordClass.startsWith("Vb")) {
        	forms = inflector.conjugateVb(level, word);
		} else {
			System.err.println("unknown word class: " +wordClass);
        }
		System.out.print(forms.toString());
        System.out.println(forms.getListForSQL());
    } // main

} // DeuInflector
