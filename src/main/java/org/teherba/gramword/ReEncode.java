/*  Translates from one encoding (default ISO-8859-1) to another (default UTF-8).
    @(#) $Id: ReEncode.java 977 2013-02-03 20:20:11Z gfis $
    2007-02-01: package was org.punctum
    2006-07-07: -s (-u) for (un)shielding umlauts
    2006-06-19, Georg Fischer
    caution, must be stored/compiled in UTF-8: äöüÄÖÜ
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
import  java.io.FileInputStream;
import  java.io.FileOutputStream;
import  java.io.BufferedReader;
import  java.io.PrintWriter;
import  java.nio.channels.Channels;
import  java.nio.channels.ReadableByteChannel;
import  java.nio.channels.WritableByteChannel;
import  java.util.regex.Matcher;
import  java.util.regex.Pattern;

/** Filters from one encoding (default) ISO-8859-1 to another (default UTF-8).
 *  @author Dr. Georg Fischer
 */
public class ReEncode {
    public final static String CVSID = "@(#) $Id: ReEncode.java 977 2013-02-03 20:20:11Z gfis $";

    /** Level of test output (0 = none, 1 = some, 2 = more ...) */
    private int debug = 3;

    /** replacement for the umlaut diaresis */
    private static final String COLON = ":";

    /** umlaut characters */
    private static final String UMLAUTS = "äöüÄÖÜ";
    /** vowels corrsponding to umlaut characters */
    private static final String UVOWELS = "aouAOU";
    /** pattern which finds umlauts */
    private static final Pattern UMLAUT_PAT = Pattern.compile("([" + UMLAUTS + "])");
    /** pattern which finds vowels */
    private static final Pattern VOWEL_PAT  = Pattern.compile("([" + UVOWELS + "])");

    /** Replaces the first umlaut in a field by the non-accented vowel,
     *  and instead puts the COLON at the end of the field
     *  @param line a sequence of fields separated by tabs
     *  @return reassembled line
     */
    private static String shield(String line) {
        String[] fields = line.split("\t");
        StringBuffer result = new StringBuffer(256);
        int ifld = 0;
        while (ifld < fields.length) {
            if (ifld > 0) {
                result.append("\t");
            }
            Matcher matcher = UMLAUT_PAT.matcher(fields[ifld]);
            if (matcher.find()) {
                matcher.appendReplacement(result, String.valueOf(UVOWELS.charAt(UMLAUTS.indexOf(matcher.group(1)))));
                matcher.appendTail(result);
                result.append(COLON);
            }
            else {
                result.append(fields[ifld]);
            }
            ifld ++;
        } // while ifld
        return result.toString();
    } // shield

    /** Removes a trailing COLON in a field,
     *  and instead puts a diaresis (umlaut accent) on the
     *  first non-accented vowel in the field
     *  @param line a sequence of fields separated by tabs
     *  @return reassembled line
     */
    private static String unshield(String line) {
        String[] fields = line.split("\t");
        StringBuffer result = new StringBuffer(256);
        int ifld = 0;
        while (ifld < fields.length) {
            if (ifld > 0) {
                result.append("\t");
            }
            if (fields[ifld].endsWith(COLON)) {
                String temp = fields[ifld].substring(0, fields[ifld].length() - 1);
                Matcher matcher = VOWEL_PAT.matcher(temp);
                if (matcher.find()) {
                    matcher.appendReplacement(result,
                            String.valueOf(UMLAUTS.charAt(UVOWELS.indexOf(matcher.group(1)))));
                    matcher.appendTail(result);
                } else { // error: no vowel aouAOU found - copy field unchanged
                    result.append(temp);
                }
            } else {
                result.append(fields[ifld]);
            }
            ifld ++;
        } // while ifld
        return result.toString();
    } // unshield

    /** Translates between different character encodings.
     *  @param args
     *<pre>commandline arguments: [-e enc1 [-e enc2]] [-s|-u] [file1 [file2]]
     *  0 filenames: convert from stdin to stdout,
     *  1 filename:  convert from file1 to stdout,
     *  2 filenames: convert from file1 to file2,
     *  -e: encodings = ISO-8859-1, UTF-8 and others allowed by Java
     *      (default -e ISO-8859-1 -e UTF-8 for input and output)
     *  -s: shield first umlaut äöüÄÖÜ, replace it by vowel and trailing ":"
     *  -u: unshield umlaut, replace first vowel and remove trailing ":"
     *</pre>
     */
    public static void main(String args[]) {
        int iarg = 0;
        int ienc = 0;
        String nl = System.getProperty("line.separator");
        String enc1 = "ISO-8859-1";
        String enc2 = "UTF-8";
        String shield = "no";

        while (iarg < args.length && args[iarg].startsWith("-")) { // process options
            String option = args[iarg ++].substring(1);
            if (false) {
            } else if (option.startsWith("e") && iarg < args.length) {
                ienc ++;
                if (ienc == 1) {
                    enc1 = args[iarg ++];
                    enc2 = enc1;
                } else {
                    enc2 = args[iarg ++];
                }
            } else if (option.startsWith("s")) {
                shield = "s";
            } else if (option.startsWith("u")) {
                shield = "u";
            }
        } // while options

        try {
            ReadableByteChannel source = iarg < args.length
                    ? (new FileInputStream (args[iarg ++])).getChannel()
                    : Channels.newChannel(System.in);
            WritableByteChannel target = iarg < args.length
                    ? (new FileOutputStream (args[iarg ++])).getChannel()
                    : Channels.newChannel(System.out);
            BufferedReader reader = new BufferedReader(Channels.newReader(source, enc1));
            PrintWriter    writer = new PrintWriter   (Channels.newWriter(target, enc2));

            String line;
            while ((line = reader.readLine()) != null) {
                if (false) {
                } else if (shield.equals("no")) {
                    writer.println(line);
                } else if (shield.equals("s")) {
                    writer.println(shield(line));
                } else if (shield.equals("u")) {
                    writer.println(unshield(line));
                }
            } // while line
            writer.close();
            reader.close();
        } catch(Exception exc) {
            System.err.println(exc.getMessage());
            exc.printStackTrace();
        }
    } // main
} // ReEncode
