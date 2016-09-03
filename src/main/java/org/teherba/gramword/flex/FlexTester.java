/*  Tests the hypothesis of some word class by expansion and table look-up
    @(#) $Id: FlexTester.java 807 2011-09-20 16:54:21Z gfis $
    2013-02-05, Georg Fischer: copied from MorphemTester
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
import  org.teherba.gramword.DeuPartList;
import  org.teherba.dbat.Configuration;
import  java.io.BufferedReader;
import  java.io.FileInputStream;
import  java.io.FileOutputStream;
import  java.io.InputStream;
import  java.io.PrintStream;
import  java.io.PrintWriter;
import  java.nio.channels.Channels;
import  java.nio.channels.ReadableByteChannel;
import  java.nio.channels.WritableByteChannel;
import  java.sql.Connection;
import  java.sql.PreparedStatement;
import  java.sql.ResultSet;
import  java.sql.Statement;
import  java.util.ArrayList;
import  java.util.Iterator;
import  java.util.Properties;
import  java.util.regex.Pattern;
import  org.apache.log4j.Logger;

/** Tests the hypothesis of some word class by expansion and table look-up. 
 *  @author Dr. Georg Fischer
 */
public class FlexTester { 
    public final static String CVSID = "@(#) $Id: FlexTester.java 807 2011-09-20 16:54:21Z gfis $";

    /** Level of test output (0 = none, 1 = some, 2 = more ...) */
    private int debug = 0;
    /** log4j logger (category) */
    private Logger log;
    /** System-dependant newline string (CR/LF for Windows, LF for Unix) */
    private String newline; 
    
    /** Determines the tests to be applied */
    private String strategy = "all";
    /** Minimal number of matches which must happen for a word to be relevant */
    private int minMatches = 2;
    
    /** Database configuration */
    private Configuration config;
    /** Database connection */
    private Connection con;
    /** SQL SELECT statement for <em>occurs</em> table */
    private PreparedStatement occursStmt;
    
    /** Default Constructor, all tests will be applied;
     *  initializes logger, pattern matching, database connection and 
     *  prepares SQL statements
     */
    public FlexTester() {
        this("all");
    } // Constructor()

    /** Constructor with strategy, 
     *  initializes logger, pattern matching, database connection and 
     *  prepares SQL statements
     *  @param strategy applicable tests: "all", "VbIn", "AjCmp" and so on
     */
    public FlexTester(String strategy) {
        log = Logger.getLogger(FlexTester.class.getName());
        newline = System.getProperty("line.separator");
        this.strategy = strategy;
        try {
	        config = new Configuration();
            config.configure(config.CLI_CALL);
			con = config.getOpenConnection();
            occursStmt   = con.prepareStatement("SELECT entry, count FROM occurs WHERE entry IN "
                    + "('dummy')");
        } catch (Exception exc) {
            log.error(exc.getMessage(), exc);
        }
    } // Constructor(1)

    /** Terminates the classificator, closes the database connection.
     */
    public void destroy() { 
        try {
            occursStmt   .close();
        	config.closeConnection();
        } catch (Exception exc) {
            log.error(exc.getMessage(), exc);
        }
    } // destroy
    
    /** Gets the number of inflections that were found in the table
     *	@param word word which is inflected
     *  @param list list of inflections suitable for SQL IN clause
     *  @return number of matching rows
     */
    public int[] getMatchCounts(String word, String listForSQL) {
        int result = 0;
       	String sql
           		= "SELECT SUM(occur), COUNT(occur) FROM occurs WHERE entry IN " + listForSQL
           	/*
           		+ " AND entry <> \'" + word + "\'"
           		+ ")"
           		+ " UNION "
           		+ "(SELECT occur FROM occurs WHERE entry = \'" + word + "\'"
           		+ ")"
           	*/
           		;
        if (debug > 1) {
          	System.err.println(sql);
        }
        int[] counts = new int[2];
        try {
            occursStmt = con.prepareStatement(sql);
            ResultSet resultSet = occursStmt.executeQuery();
            while (resultSet.next()) { 
                counts[0] = resultSet.getInt(1);
                counts[1] = resultSet.getInt(2);
            } // while
            resultSet.close();
        } catch (Exception exc) {
            log.error(exc.getMessage(), exc);
        }
        return counts;
    } // getMatchCounts
        
    /** Gets the inflections that were found in the table (for debug purposes)
     *	@param word word which is inflected
     *  @param list list of inflections suitable for SQL IN clause
     *  @return matching rows as concatenated text lines
     */
    public String getMatches(String word, String listForSQL) {
        StringBuffer result = new StringBuffer(256);
       	String sql
           		= "SELECT entry, occur FROM occurs WHERE entry IN " + listForSQL 
				+ " ORDER BY 1"
           		;
        try {
            occursStmt = con.prepareStatement(sql);
            ResultSet resultSet = occursStmt.executeQuery();
            while (resultSet.next()) { 
                String entry = resultSet.getString(1);
                String occur = resultSet.getString(2);
                result.append("# match ");
                result.append(entry);
                result.append(SEP);
				result.append(occur);
				result.append(newline);                
            } // while
            resultSet.close();
        } catch (Exception exc) {
            log.error(exc.getMessage(), exc);
        }
        return result.toString();
    } // getMatches
        
	/** Separator for result rows to be printed */
	private static final String SEP = "\t";

    /** Tests a single word, and prints the results.
     *	@param word word to be tested
     *  @param inflector language specific inflector 
     *  @param writer where to write the results
     */
    public void testWord(String word, BaseInflector inflector, PrintWriter writer) {
        try {
			if (false) {
			} else if (strategy.startsWith("VbIn")) {
				String list = inflector.conjugateVb(1, word).getListForSQL();
	        	if (debug >= 2) {
    	    		writer.print(getMatches(word, list));
        		}
				if (debug >= 1) {
			    	writer.println("# test " + word + " with " + list);
			    }
				int[] counts = getMatchCounts(word, list);
				if (counts[1] >= minMatches) {
					writer.println(word + SEP + counts[1] + SEP + counts[0]);
				} // >= minMatches
				// VbIn
			} 
        } catch (Exception exc) {
            log.error(exc.getMessage(), exc);
        }
    } // testWord
        
    /** Reads a file with words and their occurrences,
     *  generate inflections according to some strategy, 
     *  and checks them against table <em>occurs</em>.
     *  @param args commandline arguments 
     *<pre>
     *  [-d n] [-enc enc1 [-enc enc2]] [-l lang] [-m min] [-s strategy] [-w word] [file1 [file2]];
     *  -d:     debugging level (0, 1, 2 ...)
     *  -enc:   encodings = ISO-8859-1, UTF-8 and others allowed by Java,
     *  -l      language: de, en ...
     *  -m      minimal count for relevance of tested word
     *  -s      strategy: VbIn, AjCmp ...
     *  -w      single word to be tested
     *  0 filenames: convert from stdin to stdout,
     *  1 filename:  convert from file1 to stdout,
     *  2 filenames: convert from file1 to file2,
     *  fields are separated by whitespace+ (input) or 1 tab (output)
     *</pre>
     */
    public void testFile(String args[]) {
        int iarg = 0;
        String nl = System.getProperty("line.separator");
        String enc1 = "UTF-8";
        String enc2 = "UTF-8";
        int ienc = 0; // number of "-enc" options already encountered
        strategy = "VbIn";
        String language = "de";
        String word = null;

        while (iarg < args.length && args[iarg].startsWith("-")) { // process options
            String option = args[iarg ++].substring(1);
            if (false) {
            } else if (option.startsWith("d")) {
            	try {
            		debug = Integer.parseInt(args[iarg ++]);
            	} catch (Exception exc) {
					// take default
            	}
            } else if (option.startsWith("enc") && iarg < args.length) {
                if (ienc == 0) {
                    enc1 = args[iarg ++];
                    enc2 = enc1;
                    ienc ++;
                }
                else {
                    enc2 = args[iarg ++];
                }
               // -enc
            } else if (option.startsWith("l")) {
                language = args[iarg ++].toLowerCase();
            } else if (option.startsWith("m")) {
            	try {
            		minMatches = Integer.parseInt(args[iarg ++]);
            	} catch (Exception exc) {
					// take default
            	}
            } else if (option.startsWith("s")) {
                strategy = args[iarg ++];
            } else if (option.startsWith("w")) {
                word = args[iarg ++];
            } else {
            	System.err.println("invalid option: " + option);
            }
        } // while options
        
        BaseInflector inflector = (new FlexFactory()).getInflector(language);
		try {
            ReadableByteChannel source = iarg < args.length
                    ? (new FileInputStream (args[iarg ++])).getChannel()
                    : Channels.newChannel(System.in);
            WritableByteChannel target = iarg < args.length
                    ? (new FileOutputStream (args[iarg ++])).getChannel()
                    : Channels.newChannel(System.out);
            BufferedReader reader = new BufferedReader(Channels.newReader(source, enc1));
            PrintWriter    writer = new PrintWriter   (Channels.newWriter(target, enc2));

			if (word != null) {
	           	testWord(word, inflector, writer);
			} else { // not single: read words from a file
		        String line = null;
	            while ((line = reader.readLine()) != null) {
	               	String[] parts = line.split("\\s+");
	               	testWord(parts[0], inflector, writer);
	            } // while lines
        	} // not single
            writer.close();
            reader.close();
        } catch(Exception exc) {
            log.error(exc.getMessage(), exc);
        } // try
    } // testFile

    /** Main program, reads a file and tests it with {@link #testFile}.
     *  @param args commandline arguments 
     */
    public static void main(String args[]) {
        FlexTester tester = new FlexTester();
        tester.testFile(args);
        tester.destroy();
    } // main

} // FlexTester
