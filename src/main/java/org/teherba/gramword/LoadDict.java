/*  Filters from one encoding (default) ISO-8859-1 to another (default UTF-8).
    @(#) $Id: LoadDict.java 36 2008-09-08 06:05:06Z gfis $
    2006-07-17: split on "(\\s|[\\=\\,])+"
    2006-06-19
    caution, this file must be encoded in UTF-8 (c.f. build.xml, ant target "compile")
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
import  java.io.BufferedReader;
import  java.io.FileInputStream;
import  java.io.FileOutputStream;
import  java.io.PrintWriter;
import  java.nio.channels.Channels;
import  java.nio.channels.ReadableByteChannel;
import  java.nio.channels.WritableByteChannel;
import  java.util.regex.Pattern;

/** Preprocessor for dictionary loading with re-encoding, column reversal
 *  and accent expansion.
 *  @author Dr. Georg Fischer
 */
public class LoadDict {
    public final static String CVSID = "@(#) $Id: LoadDict.java 36 2008-09-08 06:05:06Z gfis $";

    /** Level of test output (0 = none, 1 = some, 2 = more ...) */
    private int debug = 3;

    /** Regular Expression Pattern for occurrence of umlauts */
    private static Pattern umlauts = Pattern.compile("[a-zA-Z0-9]*[äöüÄÖÜßéà]");

    /** Regular Expression Pattern for empty lines and comments */
    private static Pattern empty  = Pattern.compile("\\A([%#\\.\\s].*|\\s*)\\Z");

    /**
     *  Expands umlauts and a few accented letters
     *  @param  line expand first field in this string
     *  @return line with expanded string and reference to original
     */
    private static String expandUmlaut(String line) {
        String[] fields = line.split("\\s+");
        String entry = fields[0];
        fields[0] = entry // currently only German accents
                    .replaceAll("ä", "ae")
                    .replaceAll("ö", "oe")
                    .replaceAll("ü", "ue")
                    .replaceAll("Ä", "Ae")
                    .replaceAll("Ö", "Oe")
                    .replaceAll("Ü", "Ue")
                    .replaceAll("ß", "ss") // szlig
                    .replaceAll("é", "e") // eacute
                    .replaceAll("à", "a") // agrave
                    ;
        return fields[0] + "\tExUE\t" + entry
                + "\t" + ((fields.length >= 2) ? fields[1] : "");
    } // expandUmlaut

    /** Reverses a specified field in a string.
     *  @param  line reverse a field in this string
     *  @param  reversedColumn reverse this column (default 0)
     *  @return line with reversed string replaced, other fields are
     *  untouched
     */
    private static String reverseColumn(String line, int reversedColumn) {
        StringBuffer result = new StringBuffer(line);
        String[] fields = line.split("\\t");
        if (reversedColumn < fields.length) {
            fields[reversedColumn] = (new StringBuffer(fields[reversedColumn])).reverse().toString();
            result.setLength(0);
            int ifld = 0;
            while (ifld < fields.length) {
                if (ifld > 0) {
                    result.append("\t");
                }
                result.append(fields[ifld]);
                ifld ++;
            } // while ifld
        }
        return result.toString();
    } // reverseColumn

    /** Preprocessor for dictionary loading with re-encoding, column reversal
     *  and accent expansion.
     *  @param args commandline arguments:
     *<pre>
     *  [-enc enc1 [-enc enc2]] [-rev col] [-exp] [file1 [file2]];
     *  -enc:   encodings = ISO-8859-1, UTF-8 and others allowed by Java,
     *  -rev:   reverse field in specified column number (0, 1, 2, 3)
     *  -exp:   expand umlauts/accents and write a 2nd record
     *  0 filenames: convert from stdin to stdout,
     *  1 filename:  convert from file1 to stdout,
     *  2 filenames: convert from file1 to file2,
     *  "=" and "," are replaced by tabs
     *  fields are then separated by whitespace+ (input) or 1 tab (output)
     *</pre>
     */
    public static void main(String args[]) {
        int iarg = 0;
        String nl = System.getProperty("line.separator");
        String enc1 = "ISO-8859-1";
        String enc2 = "UTF-8";
        int ienc = 0; // number of "-enc" options already encountered
        int reversedColumn = -1; // no reversed column
        boolean expand = false; // whether to write a 2nd record for expanded umlauts

        while (iarg < args.length && args[iarg].startsWith("-")) { // process options
            String option = args[iarg ++].substring(1);
            if (false) {}
            else if (option.startsWith("enc") && iarg < args.length) {
                if (ienc == 0) {
                    enc1 = args[iarg ++];
                    enc2 = enc1;
                    ienc ++;
                }
                else {
                    enc2 = args[iarg ++];
                }
            } // -enc
            else if (option.startsWith("exp")) {
                expand = true;
            } // -exp
            else if (option.startsWith("rev")) {
                reversedColumn = 0; // default: 1st column (#0)
                if (iarg < args.length) {
                    try {
                        reversedColumn = Integer.parseInt(args[iarg ++]);
                    }
                    catch (NumberFormatException exc) {
                        // ignore
                    }
                }
            } // -rev
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
                if (! empty.matcher(line).matches()) {
                    line = line.replaceAll("(\\s|[\\=|\\,])+", "\t");
                            // sequences of whitespace, "=" and "," to tab
                    String original = line;
                    if (reversedColumn >= 0) {
                        line = reverseColumn(line, reversedColumn);
                    } // reverse
                    writer.println(line);
                    if (expand && umlauts.matcher(original).lookingAt()) {
                        line = expandUmlaut(original);
                        if (reversedColumn >= 0) {
                            line = reverseColumn(line, reversedColumn);
                        }
                        writer.println(line);
                    } // expand umlauts
                } // ! empty
            } // while
            writer.close();
            reader.close();
        } catch(Exception exc) {
            System.err.println(exc.getMessage());
            exc.printStackTrace();
        } // try
    } // main

} // LoadDict
