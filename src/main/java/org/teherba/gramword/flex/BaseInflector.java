/*  Base class for conjugation and declination of words in different languages
    @(#) $Id: BaseInflector.java 978 2013-02-04 11:06:08Z gfis $
    2016-09-11: javadoc
    2013-01-27, Georg Fischer: copied from numword.BaseSpeller

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
import  org.teherba.gramword.MorphemList;
import  java.util.HashMap;
import  java.util.Iterator;
import  java.util.regex.Matcher;
import  java.util.regex.Pattern;

/** Base class for conjugation and declination of words in natural languages,
 *  with common properties and methods.
 *  @author Dr. Georg Fischer
 */
public abstract class BaseInflector {
    public final static String CVSID = "@(#) $Id: BaseInflector.java 978 2013-02-04 11:06:08Z gfis $";
    /** whether to write debugging output */
    protected final static boolean DEBUG = true;

    /** Constructor
     */
    public BaseInflector() {
    } // Constructor()

    //=========================================
    // Bean properties
    //----------------
    /** description for the language */
    protected String description;
    /** Gets the description for the language.
     *  @return text describing the language of this speller
     */
    public String getDescription() {
        return getFirstIso639() + " - " + description;
    } // getDescription

    /** Sets the description for the language.
     *  @param text text describing the language of this speller
     */
    protected void setDescription(String text) {
        description = text;
    } // setDescription
    //----------------
    /** list of applicable ISO-639 codes */
    protected String iso639Codes;
    /** Gets the list of applicable ISO-639 codes for the language
     *  @return list of 2- or 3-letter codes from ISO-639,
     *  separated by commata
     */
    protected String getIso639() {
        return iso639Codes;
    } // getIso639

    /** Gets the first ISO-639 code for the language
     *  @return a 2- or 3-letter code from ISO-639
     */
    public String getFirstIso639() {
        int pos = iso639Codes.indexOf(",");
        String result = iso639Codes;
        if (pos >= 0) {
            result = iso639Codes.substring(0, pos);
        }
        return result;
    } // getFirstIso639
    /** Sets the list of applicable ISO-639 codes for the language
     *  @param list list of 2- or 3-letter codes from ISO-639,
     *  separated by commata
     */
    protected void setIso639(String list) {
        iso639Codes = list;
    } // setIso639
    //----------------
    /** List of personal pronouns as they are usually presented to the user
     */
    protected HashMap<String, String> persons;
    /** Set the personal pronouns for list presentation - create an empty map
     */
    public void setPersons() {
        persons = new HashMap<String, String>(16);
    } // setPersons
    /** Add a personal pronoun
     *  @param key numerical key giving the numerus (1 or 9) and the person (1, 2, 3)
     *  @param pronoun pronoun as it is used in list presentations
     */
    protected void addPerson(String key, String pronoun) {
        persons.put(key, pronoun);
    } // addPerson
    //----------------
    /** List of attitudes as they are usually presented to the user
     */
    protected HashMap<String, String> attitudes;
    /** Set the attitudes for list presentation - create an empty map
     */
    public void setAttitudes() {
        attitudes = new HashMap<String, String>(16);
    } // setAttitudes
    /** Add an attitude
     *  @param key code (abbreviation) for the attitude
     *  @param attitude attitude as it is used in list presentations
     */
    protected void addAttitude(String key, String attitude) {
        attitudes.put(key, attitude);
    } // addAttitude
    //----------------

    //=====================================
    // inflecting methods
    //=====================================

    /** Conjugates a verb and generates the forms for
     *  all persons, numeri and tempi.
     *  @param level how many forms should be generated: 1 = few, 2 = more, 3 = even more, 4 = all (with participe declination)
     *  @param infinitive the verb's infinitive form ending with <em>-en, -eln, -ern, -ieren</em>
     *  @return list of generated morphems
     */
    public MorphemList conjugateVb(int level, String infinitive) {
        MorphemList result = new MorphemList();
        return result;
    } // conjugate(2)

    /** Declinates a regular German adjective and generates all forms for
     *  case, person, numerus and type of determinism (but no comparision level).
     *  Sometimes it omits an <em>e</em>,
     *  C.f. <a target="_new" href="http://deutsch.lingolia.com/de/grammatik/adjektive/deklination">deutsch.lingolia.com</a>.
     *  @param word the adjective (or participe)
     *  @return list of generated morphems
     */
    public MorphemList declinateAj(int level, String word) {
        MorphemList result  = new MorphemList();
        return result;
    } // declinateAj(2)

} // BaseInflector
