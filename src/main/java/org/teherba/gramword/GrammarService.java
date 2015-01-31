/*  SOAP Service interface to GrammarFilter
    @(#) $Id: GrammarService.java 976 2013-02-02 16:44:18Z gfis $
    2006-12-14: constant (dummy) response
    2005-07-27, Georg Fischer
    
    Service to be called via SOAP, offering the functions of GrammarFilter
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
import  org.teherba.gramword.GrammarFilter;

/** This class is the SOAP service interface to <em>BaseSpeller</em>, 
 *  and ressembles the functionality of the commandline interface
 *  in GrammarFilter.
 *  @author Dr. Georg Fischer
 */
public class GrammarService { 
    public final static String CVSID = "@(#) $Id: GrammarService.java 976 2013-02-02 16:44:18Z gfis $";

    /** Returns the results of an activation of <em>GrammarFilter</em>
     *  to a SOAP client.
     *  @param language ISO 639 language code, e.g. "de"
     *  @param function a code for the desired function
     *  @return number word or digit sequence 
     */
    public String getResponse(String language, String function, String digits)  {
        String response = "GrammarService is not yet implemented";
        if (false) 
        try {
            GrammarFilter filter = new GrammarFilter();
            // BaseSpeller speller = numberSpeller.getApplicableSpeller(language);
            String newPage = "index"; 
            if (false) {
                response = "003 - invalid language code"; // invalid language code
                newPage = "message";
            } else if (   function.equals("spell")         ) { 
                // check for proper digit sequence
                function = "c";
            } else if (   function.equals("month")         ) {
                function = "m";
            } else if (   function.equals("month,3")       ) {
                function = "m3";
            } else if (   function.equals("parse")         ) {
                // check for alphabetic "digits" input field
                function = "p";
            } else if (   function.equals("season")        ) {
                function = "s";
            } else if (   function.equals("weekday")       ) {
                function = "w";
            } else if (   function.equals("weekday,2")     ) {
                function = "w2";
            } else { // invalid function
                response = "001 - invalid function";
                newPage = "message";
            }
            if (newPage.equals("index")) {
                // response = numberSpeller.process("-l " + language + " -" + function + " " + digits);
            } else { 
                response = "error " + response;
            }
        } catch (Exception exc) {
            System.err.println(exc.getMessage());
            exc.printStackTrace();
        }
        return response;
    } // getResponse

} // GrammarService
