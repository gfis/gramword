/*  Selects the applicable inflector for words in a natural language
    @(#) $Id: FlexFactory.java 976 2013-02-02 16:44:18Z gfis $
    2013-01-27: copied from org.teherba.numword.SpellerFactory
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
import  org.teherba.gramword.flex.BaseInflector;
import  java.util.ArrayList;
import  java.util.HashMap;
import  java.util.Iterator;
import  java.util.StringTokenizer;
import  org.apache.log4j.Logger;

/** Selects a specific inflector, and iterates over the descriptions
 *  of all inflectors and their codes.
 *  Initially, a list of all available inflectors is built, and classes
 *  which cannot be instantiated are <em>silently</em> ignored.
 *  @author Dr. Georg Fischer
 */
public class FlexFactory {
    public final static String CVSID = "@(#) $Id: FlexFactory.java 976 2013-02-02 16:44:18Z gfis $";
    /** log4j logger (category) */
    private Logger log;

    /** Array of inflectors for different natural languages */
    private ArrayList<BaseInflector> inflectors;

    /** Attempts to instantiate the inflector for some language
     *  @param lang 3-letter language code (lowercase), e.g. "deu", "fra"
     */
    private void addInflector(String lang) {
        try {
            BaseInflector inflector = (BaseInflector) Class.forName("org.teherba.gramword.flex." + lang + "Inflector").newInstance();
            inflectors.add(inflector);
        } catch (Exception exc) {
            // ignore any error silently - this language will not be known
        }
    } // addInflector

    /** No-args Constructor.
     *  The order of the languages here defines the order in the user interfaces.
     */
    public FlexFactory() {
        log = Logger.getLogger(FlexFactory.class.getName());
        try {
            inflectors    = new ArrayList<BaseInflector>(64);
            
            addInflector("Deu");  // German

        } catch (Exception exc) {
            log.error(exc.getMessage(), exc);
        }
    } // Constructor(0)

    /** Gets an iterator over all implemented inflectors.
     *  @return list iterator over <em>allinflectors</em>
     */
    public Iterator<BaseInflector> getIterator() {
        return inflectors.iterator();
    } // getIterator

    /** Gets the number of available inflectors
     *  @return number of languages which can be spelled
     */
    public int getCount() {
        return inflectors.size();
    } // getCount

    /** Determines whether the language code denotes this inflector class.
     *  @param inflector the inflector to be tested
     *  @param language code for the desired language
     */
    public boolean isApplicable(BaseInflector inflector, String language) {
        boolean result = false;
        StringTokenizer tokenizer = new StringTokenizer(inflector.getIso639(), ",");
        while (! result && tokenizer.hasMoreTokens()) { // try all tokens
            if (language.equals(tokenizer.nextToken())) {
                result = true;
            }
        } // while all tokens
        return result;
    } // isApplicable

    /** Gets the applicable inflector for a specified language code.
     *  @param language ISO639 abbreviation for the language
     *  @return the inflector for that language, or <em>null</em> if the
     *  language was not found
     */
    public BaseInflector getInflector(String language) {
        BaseInflector result = null;
        // determine the applicable inflector for 'language'
        Iterator<BaseInflector> siter = getIterator();
        boolean notFound = true;
        while (notFound && siter.hasNext()) {
            BaseInflector inflector = siter.next();
            if (isApplicable(inflector, language)) {
                result = inflector;
                notFound = false;
            }
        } // while not found
        return result;
    } // getInflector

} // FlexFactory
