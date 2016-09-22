/*  Shows the syntactical type of words in plain text
    @(#) $Id: MorphemTester.java 807 2011-09-20 16:54:21Z gfis $
    2011-09-17: dbat.Configuration
    2008-02-13: Java 1.5 types
    2007-01-04: Dbat.getConnection instead of DbAccess
    2006-08-09: stack of DeuPartList.s; Veronika = 25
    2006-05-31: copied from NumberSpeller

    must be stored in UTF-8 encoding äöüÄÖÜß!
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
import  org.teherba.gramword.DeuPartList;
import  org.teherba.numword.DeuSpeller;
import  org.teherba.dbat.Configuration;
import  java.io.FileInputStream;
import  java.io.InputStream;
import  java.io.PrintStream;
import  java.sql.Connection;
import  java.sql.PreparedStatement;
import  java.sql.ResultSet;
import  java.sql.Statement;
import  java.util.ArrayList;
import  java.util.Iterator;
import  java.util.Properties;
import  java.util.regex.Pattern;
import  org.apache.log4j.Logger;

/** Shows the syntactical type of words in plain text.
 *  @author Dr. Georg Fischer
 */
public class MorphemTester {
    public final static String CVSID = "@(#) $Id: MorphemTester.java 807 2011-09-20 16:54:21Z gfis $";

    /** Level of test output (0 = none, 1 = some, 2 = more ...) */
    private int debug = 0;
    /** log4j logger (category) */
    private Logger log;

    /** Determines the tests to be applied */
    private String strategy = "all";

    /** Regular Expression Pattern for uppercase word start */
    private Pattern wordUpperCase;
    /** Regular Expression Pattern for numbers (digit sequences) */
    private Pattern numberPattern;
    /** parsing of German number words */
    private DeuSpeller numSpeller;

    /** List of adjective (declination) endings */
    MorphemList ajSuffixes;
    /** List of number word (declination) endings */
    MorphemList nuSuffixes;
    /** List of substantive declination endings */
    MorphemList sbSuffixes;
    /** List of "primary" prepositions and other short, undeclinable words */
    MorphemList prPrimes;
    /** Array of interspersed particles */
    String[] intraLexems;

    /** Database configuration */
    private Configuration dbatConfig;
    /** Database connection */
    private Connection con;
    /** SQL SELECT statement for <em>words</em> table */
    private PreparedStatement wordsStmt;
    /** SQL SELECT statement for <em>forge</em> table */
    private PreparedStatement forgeStmt;
    /** SQL SELECT statement for <em>infos</em> table */
    private PreparedStatement infosStmt;
    /** SQL SELECT statement for <em>names</em> table */
    private PreparedStatement namesStmt;
    /** SQL SELECT statement for <em>roots</em> table */
    private PreparedStatement rootsStmt;
    /** SQL SELECT statement for <em>suffix</em> table */
    private PreparedStatement suffixStmt;
    /** SQL SELECT statement for <em>xiffus</em> table (reversed suffixes)*/
    private PreparedStatement xiffusStmt;

    /** Default Constructor, all tests will be applied;
     *  initializes logger, pattern matching, database connection and
     *  prepares SQL statements
     */
    public MorphemTester() {
        this("all");
    } // Constructor 0

    /** Constructor with strategy,
     *  initializes logger, pattern matching, database connection and
     *  prepares SQL statements
     *  @param strategy applicable tests: "all", "prsplit" and so on
     */
    public MorphemTester(String strategy) {
        try {
            this.strategy = strategy;
            log = Logger.getLogger(MorphemTester.class.getName());
            wordUpperCase   = Pattern.compile("[A-ZÄÖÜ]");
            numberPattern   = Pattern.compile("\\d+");
            numSpeller      = new DeuSpeller();
            dbatConfig = new Configuration();
            dbatConfig.configure(dbatConfig.CLI_CALL);

            String connectionId = "worddb";
            dbatConfig.addProperties(connectionId + ".properties");
            dbatConfig.setConnectionId(connectionId);

            con = dbatConfig.getOpenConnection();
            int MAXSEL = 16;
            wordsStmt   = con.prepareStatement("SELECT entry, morph, enrel, morel FROM words  WHERE"
                    + " entry =  ? ");
            forgeStmt   = con.prepareStatement("SELECT entry, morph, enrel, morel FROM forge  WHERE"
                    + " entry <= ? ORDER BY 1 DESC LIMIT " + MAXSEL); // and entry >= ? order by 1 desc");
            infosStmt   = con.prepareStatement("SELECT entry, morph, enrel, morel FROM infos  WHERE"
                    + " entry =  ? ");
            namesStmt   = con.prepareStatement("SELECT entry, morph, enrel, morel FROM names  WHERE"
                    + " entry =  ? ");
            rootsStmt   = con.prepareStatement("SELECT entry, morph, enrel, morel FROM roots  WHERE"
                    + " entry <= ? ORDER BY 1 DESC LIMIT " + MAXSEL); // and entry >= ? order by 1 desc");
            suffixStmt  = con.prepareStatement("SELECT entry, morph, enrel, morel FROM suffix WHERE"
                    + " entry <= ? ORDER BY 1 DESC LIMIT " + MAXSEL); // and entry >= ? order by 1 desc");
            xiffusStmt  = con.prepareStatement("SELECT entry, morph, enrel, morel FROM xiffus WHERE"
                    + " entry <= ? ORDER BY 1 DESC LIMIT " + MAXSEL); // and entry >= ? order by 1 desc");
            ajSuffixes  = new MorphemList(con, "suffix" , "AjX%");
            nuSuffixes  = new MorphemList(con, "suffix" , "NuSf%");
            storeSbSuffixes(); // load sbSuffixes
            if (false) {
            } else if(strategy.equals("prsplit")) {
                prPrimes    = new MorphemList(con, "words"  , "__Prim%");
            } else if(strategy.equals("sasplit") || strategy.equals("lexsplit")) {
                insertForge("SELECT lower(entry), morph, enrel, morel FROM roots"
                        + " WHERE substr(morph,1,2) IN ('Sb', 'Aj')");
            }
            intraLexems = new String[] {"e", "s", "n", "en", "es"};
            if (debug >= 1) {
                log.info("org.teherba.gramword.MorphemTester initialized with strategy \"" + strategy + "\"");
            }
        } catch (Exception exc) {
            log.error(exc.getMessage(), exc);
        }
    } // Constructor 1

    /** Terminates the classificator, closes the database connection.
     */
    public void destroy() {
        try {
            wordsStmt   .close();
            rootsStmt   .close();
            suffixStmt  .close();
            xiffusStmt  .close();
            dbatConfig.closeConnection();
        } catch (Exception exc) {
            log.error(exc.getMessage(), exc);
        }
    } // destroy

    /** Sets the parameters of a prepared statement for prefix search.
     *  @param pstmt statement to prepare
     *  @param word 1st parameter of the statement: search for a prefix of this word
     *  @return SQL result set
     */
    public ResultSet runQuery(PreparedStatement pstmt, String word) {
        ResultSet result = null;
        try {
            pstmt.clearParameters();
            pstmt.setString(1, word);
            result = pstmt.executeQuery();
        } catch (Exception exc) {
            log.error(exc.getMessage(), exc);
        }
        return result;
    } // runQuery

    /** Stores all substantive declination endings in an ArrayList
     */
    private void insertForge(String select) {
        try {
            Statement
            stmt = con.createStatement();
            stmt.executeUpdate("DELETE FROM forge");
            con.commit();
            stmt.executeUpdate("INSERT INTO forge (" + select + ")");
            con.commit();
            stmt.close();
        } catch (Exception exc) {
            log.error(exc.getMessage(), exc);
        }
    } // insertForge

    /** Stores all substantive declination endings in an ArrayList
     */
    private void storeSbSuffixes() {
        try {
            sbSuffixes = new MorphemList(32);
        /*
            PreparedStatement pstmt = con.prepareStatement("SELECT entry, morph, enrel FROM suffix WHERE"
                    + " morph like \'SbX%\' order by 1");
            ResultSet resultSet = pstmt.executeQuery();
            boolean busy = true;
            while (busy && resultSet.next()) {
                String entry = resultSet.getString(1);
                String morph = resultSet.getString(2);
                String enrel = resultSet.getString(3);
                String morel = resultSet.getString(4);
                ajSuffixes.add(new Morphem(entry, morph, enrel, morel));
            }
            resultSet.close();
        */
            sbSuffixes.add(new Morphem("e"  , "SbPl"    ));
            sbSuffixes.add(new Morphem("n"  , "SbPl"    ));
            sbSuffixes.add(new Morphem("s"  , "SbSgGe"  ));
            sbSuffixes.add(new Morphem("es" , "SbSgGe"  ));
            sbSuffixes.add(new Morphem("en" , "SbPl"    ));
            sbSuffixes.add(new Morphem("in" , "SbSgFm"  ));
            sbSuffixes.add(new Morphem("er" , "SbSgMsPers"  ));
            sbSuffixes.add(new Morphem("ens"    , "SbSgGe"  ));
        } catch (Exception exc) {
            log.error(exc.getMessage(), exc);
        }
    } // storeSbSuffixes

    /** Tries to find exact match(es) in <em>words</em> database table.
     *  @param word word to be looked up
     *  @return list of morphems for exact matches of that word,
     *  maybe empty
     */
    public MorphemList getWords(String word) {
        MorphemList result = new MorphemList();
        try {
            ResultSet resultSet = runQuery(wordsStmt, word);
            boolean busy = true;
            while (busy && resultSet.next()) {
                // word was found in db table
                String entry = resultSet.getString(1);
                String morph = resultSet.getString(2);
                String enrel = resultSet.getString(3);
                String morel = resultSet.getString(4);
                if (debug >= 1) {
                    log.debug("words(" + word + "): " + entry + " =" + morph
                            + "," + enrel + "," + morel);
                }
                if (word.equals(entry)) {
                    result.add(new Morphem(entry, morph, enrel, morel));
                    busy = false;
                }
                else { // entry matches no longer
                    // busy = false;
                }
            }
            resultSet.close();
            con.commit();
        } catch (Exception exc) {
            log.error(exc.getMessage(), exc);
        }
        return result;
    } // getWords

    /** Tries to find exact match(es) in <em>infos</em> database table.
     *  @param word word to be looked up
     *  @return list of morphems for exact matches of that word,
     *  maybe empty
     */
    public MorphemList getInfos(String word) {
        MorphemList result = new MorphemList();
        try {
            ResultSet resultSet = runQuery(infosStmt, word);
            boolean busy = true;
            while (busy && resultSet.next()) {
                // word was found in db table
                String entry = resultSet.getString(1);
                String morph = resultSet.getString(2);
                String enrel = resultSet.getString(3);
                String morel = resultSet.getString(4);
                if (debug >= 1) {
                    log.debug("infos(" + word + "): " + entry + " =" + morph
                            + "," + enrel + "," + morel);
                }
                if (word.equals(entry)) {
                    result.add(new Morphem(entry, morph, enrel, morel));
                    // busy = false;
                }
                else { // entry matches no longer
                    // busy = false;
                }
            }
            resultSet.close();
            con.commit();
        } catch (Exception exc) {
            log.error(exc.getMessage(), exc);
        }
        return result;
    } // getInfos

    /** Tries to find exact match(es) in <em>names</em> database table,
     *  or of the word without a trailing "s"
     *  @param word word to be looked up
     *  @return list of morphems for exact matches of that word,
     *  eventually plus "s",
     *  maybe empty
     */
    private MorphemList getNames(String word) {
        MorphemList result = new MorphemList();
        try {
            for (int index = 0; index <= 1; index ++) {
                if (index == 0 || word.endsWith("s")) { // 1st without "s", 2nd maybe with "s"
                    ResultSet resultSet = runQuery(namesStmt, word.substring(0, word.length() - index));
                    boolean busy = true;
                    while (busy && resultSet.next()) {
                        // word was found in db table
                        String entry = resultSet.getString(1);
                        String morph = resultSet.getString(2);
                        String enrel = resultSet.getString(3);
                        String morel = resultSet.getString(4);
                        if (debug >= 1) {
                            log.debug("names(" + word + "): " + entry + " =" + morph
                                    + "," + enrel + "," + morel);
                        }
                        if (word.equals(entry)) {
                            if (index == 0) {
                                result.add(new Morphem(entry, morph, enrel, morel));
                            } else {
                                result.add(new Morphem(entry + "s", morph + "Ge", entry, morph));
                            }
                            busy = false;
                        } else { // entry matches no longer
                            // busy = false;
                        }
                    } // while next()
                    resultSet.close();
                    con.commit();
                } // if index
            } // for index
        } catch (Exception exc) {
            log.error(exc.getMessage(), exc);
        }
        return result;
    } // getNames

    /** Tries to find match(es) in <em>forge</em> database table
     *  (copy of method <em>getRoots</em>).
     *  @param word word to be looked up
     *  @return list of morphems for prefixes of that word,
     *  maybe empty
     */
    private DeuPartList getForge(String word) {
        DeuPartList result = new DeuPartList();
        try {
            ResultSet resultSet = runQuery(forgeStmt, word);
            boolean busy = true;
            while (busy && resultSet.next()) {
                String entry = resultSet.getString(1);
                String morph = resultSet.getString(2);
                String enrel = resultSet.getString(3);
                String morel = resultSet.getString(4);
                if (debug >= 1) {
                    log.debug("getForge(" + word + "): " + entry + " =" + morph
                            + "," + enrel + "," + morel);
                }
                if (word.startsWith(entry)) {
                    if (debug >= 1) {
                        log.debug("getForge: add " + entry + " =" + morph
                                + "," + enrel + "," + morel);
                    }
                    result.add(new Morphem(entry, morph, enrel, morel));
                }
            }
            resultSet.close();
            con.commit();
        } catch (Exception exc) {
            log.error(exc.getMessage(), exc);
        }
        return result;
    } // getForge

    /** Tries to find match(es) in <em>forge</em> database table
     *  (copy of method <em>getRoots</em>).
     *  @param word word to be looked up
     *  @return list of morphems for prefixes of that word,
     *  maybe empty
     */
    private MorphemList getIntraLexems(String word) {
        MorphemList result = new MorphemList();
        int index = intraLexems.length - 1;
        while (index >= 0) {
            if (word.startsWith(intraLexems[index])) {
                result.add(intraLexems[index], "Cm");
            }
            index --;
        } // while
        return result;
    } // getIntraLexems

    /** Tries to find match(es) in <em>forge</em> database table,
     *  and otherwise in <em>intraLexems</em>.
     *  @param word word to be looked up
     *  @param offset offset in <em>word</em>
     *  @return list of morphems for prefixes of that word,
     *  maybe empty
     */
    private MorphemList getPrefixes(String word, int offset) {
        MorphemList result = getForge(word.substring(offset));
        if ( // result.isEmpty() &&
                offset > 0)
        { // only if not at the beginning of 'word'
            result.addAll(getIntraLexems(word.substring(offset)));
        }
        return result;
    } // getPrefixes

    /** Tries to find match(es) in <em>roots</em> database table.
     *  @param word word to be looked up
     *  @return list of morphems for prefixes of that word,
     *  maybe empty
     */
    private MorphemList getRoots(String word) {
        MorphemList result = new MorphemList();
        try {
            ResultSet resultSet = runQuery(rootsStmt, word);
            boolean busy = true;
            while (busy && resultSet.next()) {
                String entry = resultSet.getString(1);
                String morph = resultSet.getString(2);
                String enrel = resultSet.getString(3);
                String morel = resultSet.getString(4);
                if (debug >= 1) {
                    log.debug("getRoots(" + word + "): " + entry + " =" + morph
                            + "," + enrel + "," + morel);
                }
            /*
                if (word.equals(entry + enrel)) {
                    result.add(new Morphem(entry, morph, enrel, morel));
                    busy = false; // no need to process entire resultset
                }
                else
            */
                if (word.startsWith(entry)) {
                    if (debug >= 1) {
                        log.debug("getRoots: add " + entry + " =" + morph
                                + "," + enrel + "," + morel);
                    }
                    result.add(new Morphem(entry, morph, enrel, morel));
                }
            }
            resultSet.close();
            con.commit();
        } catch (Exception exc) {
            log.error(exc.getMessage(), exc);
        }
        return result;
    } // getRoots

    /** Tries to find match(es) in for a word splitted into pre- and suffix
     *  @param word word to be looked up
     *  @return list of morphems for pre- and suffixes of that word,
     *  maybe empty
     */
    private MorphemList searchRoots(String word) {
        MorphemList result  = new MorphemList();
        try {
            Morphem     morphem  = null;
            MorphemList morphems = getRoots(word);
            boolean     busy = true;
            int imorph = 0;
            while (busy && imorph < morphems.size()) {
                morphem = (Morphem) morphems.get(imorph);
                String prefix = morphem.getEntry();
                String suffix = word.substring(prefix.length());
                String morph  = morphem.getMorph();
                String enrel  = morphem.getEnrel();
                String morel  = morphem.getMorel();
                if (morphem.isExplicitReplacement()) {
                    word = morphem.getEnrel() + suffix; // replace
                    morphems = getRoots(word);
                    imorph = -1; // start all over
                }

                else if (morph.startsWith("Vb")) {
                    // now check whether the suffix is known for the same infinitiveEnd
                    String infinitiveEnd = morphem.getEnrel();
                    if (debug >= 2) {
                        log.debug("searchRoots(" + word + "): "
                                + prefix + "+" + suffix + " =" + morph
                                + "," + enrel + "," + morel);
                    }
                    if (suffix.equals(infinitiveEnd)) {
                        busy  = false;
                        result.add(morphem);
                    }
                    else {
                        MorphemList morphems2 = getSuffix(suffix);
                        int imorph2 = 0;
                        boolean busy2 = true;
                        while (busy2 && imorph2 < morphems2.size()) {
                            Morphem morphem2 = (Morphem) morphems2.get(imorph2);
                            String morph2 = morphem2.getMorph();
                            if (morph2.startsWith("Vb")) {
                                String infinitiveEnd2 = morphem2.getEnrel();
                                if (debug >= 1) {
                                    log.debug("infEnd:" + infinitiveEnd
                                        + " <> " +    "infEnd2:" + infinitiveEnd2);
                                }
                                if (infinitiveEnd.equals(infinitiveEnd2)) {
                                    /*  here we have (for example):
                                        word                "programmierenden"
                                        prefix              "programm"
                                        suffix              "-ierenden"
                                        infinitiveEnd(2)    "ieren"
                                    */
                                    busy2 = false;
                                    busy  = false;
                                    result.add(new Morphem(prefix, morph2
                                            , morphem2.getEnrel(), morphem2.getMorel()));
                                } // if infinitiveEnd(2) =
                            } // if morph1 like "Vb%"
                            // else ignore Aj etc.
                            imorph2 ++;
                        } // while busy2
                    } // suffix != infinitiveEnd
                } // if morph like "Vb%"

                else if (morph.startsWith("Aj")) {
                    if (suffix.equals("")) { // undeclinated
                        result.add(morphem);
                    }
                    else {
                        Iterator iter = ajSuffixes.iterator();
                        boolean found = false;
                        while (! found && iter.hasNext()) {
                            Morphem morphem2 = (Morphem) iter.next();
                            if (morphem2.getEntry().equals(suffix)) {
                                found = true;
                                result.add(morphem2);
                            }
                        } // while
                    }
                } // if morph like "Aj%"

                else if (morph.startsWith("Sb") || morph.startsWith("Nm")) {
                    if (suffix.equals("")) { // undeclinated
                        result.add(morphem);
                    }
                    else {
                        Iterator iter = sbSuffixes.iterator();
                        boolean found = false;
                        while (! found && iter.hasNext()) {
                            Morphem morphem2 = (Morphem) iter.next();
                            if (morphem2.getEntry().equals(suffix)) {
                                found = true;
                                result.add(morphem2);
                            }
                        } // while
                    }
                } // if morph like "Aj%"
                // else ignore

                imorph ++;
            } // while busy
        } catch (Exception exc) {
            log.error(exc.getMessage(), exc);
        }
        return result;
    } // searchRoots

    /** Tries to find exact match(es) in <em>suffix/em> database table.
     *  @param word word to be looked up
     *  @return list of morphems for exact matches of that word,
     *  maybe empty
     */
    private MorphemList getSuffix(String word) {
        MorphemList result = new MorphemList();
        try {
            if (word.equals("")) {
                word = "-";
            }
            ResultSet resultSet = runQuery(suffixStmt, word);
            boolean busy = true;
            while (busy && resultSet.next()) {
                // word was found in db table
                String entry = resultSet.getString(1);
                String morph = resultSet.getString(2);
                String enrel = resultSet.getString(3);
                String morel = resultSet.getString(4);
                if (debug >= 1) {
                    log.debug("suffix(" + word + "): " + entry + " =" + morph
                            + "," + enrel + "," + morel);
                }
                if (word.equals(entry)) {
                    result.add(new Morphem((entry.equals("-")) ? "" : entry, morph, enrel, morel));
                } else { // entry matches no longer
                    busy = false;
                }
            }
            resultSet.close();
            con.commit();
        } catch (Exception exc) {
            log.error(exc.getMessage(), exc);
        }
        return result;
    } // getSuffix

    /*  Tries to find match(es) in <em>xiffus</em> database table
     *  (reversed suffixes).
     *  @param word word to be looked up
     *  @return list of morphems for endings which are tails of that word,
     *  maybe empty
     */
    private MorphemList getXiffus(String word) {
        MorphemList result = new MorphemList();
        try {
            String drow = (new StringBuffer(word)).reverse().toString();
                    // word read backwards
            ResultSet resultSet = runQuery(xiffusStmt, drow);
            boolean busy = true;
            while (busy && resultSet.next()) {
                // word was found in db table
                String entry = (new StringBuffer(resultSet.getString(1))).reverse().toString();
                String morph = resultSet.getString(2);
                String enrel = resultSet.getString(3);
                String morel = resultSet.getString(4);
                if (debug >= 1) {
                    log.debug("getXiffus(" + word + "/" + drow + "): "
                            + entry + " = " + morph + "," + enrel + "," + morel);
                }
                if  (word.endsWith(entry)) {
                    if (debug >= 4) {
                        log.debug("getXiffus - add "
                                + entry + " = " + morph + "," + enrel + "," + morel);
                    }
                    result.add(new Morphem(entry, morph, enrel, morel));
                }
                if (drow.compareTo(resultSet.getString(1)) <= 0) {
                    // "verliehen" finds "fliehen"
                    busy = false;
                }
            }
            resultSet.close();
            con.commit();
       } catch (Exception exc) {
            log.error(exc.getMessage(), exc);
        }
        return result;
    } // getXiffus

    /** Tries to find match(es) in table <em>xiffus</em>
     *  for the suffix(es) of a word
     *  @param word word to be looked up
     *  @return list of morphems for that word,
     *  maybe empty
     */
    private MorphemList searchXiffus(String word) {
        MorphemList result  = new MorphemList();
        try {
            Morphem     morphem  = null;
            MorphemList morphems = getXiffus(word);
            boolean     busy = true;
            String drow = (new StringBuffer(word)).reverse().toString(); // word read backwards
                    // word read backwards, for trace output only
            int imorph = 0;
            while (busy && imorph < morphems.size()) {
                morphem = (Morphem) morphems.get(imorph);
                String suffix = morphem.getEntry();
                String morph  = morphem.getMorph();
                String enrel  = morphem.getEnrel();
                String morel  = morphem.getMorel();
                if (debug >= 4) {
                    log.debug("searchXiffus(" + word + "): "
                            + suffix + " = " + morph + "," + enrel + "," + enrel);
                }
                if (morphem.isExplicitReplacement()) {
                    if (debug >= 2) {
                        log.debug("searchXiffus.replace(" + word + "/" + drow + "): "
                                + suffix + " =" + morph + "," + enrel + "," + enrel);
                    }
                    word = morphem.getEnrel(); // replace
                    morphems = getXiffus(word);
                    imorph = -1; // restart the loop all over
                } else if (word.length() - suffix.length() < 2 && ! suffix.equals("ung")) {
                    if (debug >= 2) {
                        log.debug("ignore - prefix too short"); //  but     "Übung"
                    }
                } else if ( morph.startsWith("Vb")
                        &&  ! wordUpperCase.matcher(word).lookingAt()
                        ) {
                    // now check whether it is a suffix
                    if (debug >= 2) {
                        log.debug("searchXiffus.Vb(" + word + "/" + drow + "): "
                                + suffix + " =" + morph + "," + enrel + "," + morel);
                    }
                    if      (   word.endsWith(suffix)) {
                        result.add(morphem);
                    }
                } else if ( morph.startsWith("Sb")
                        &&    wordUpperCase.matcher(word).lookingAt()
                        ) {
                    // now check whether it is a suffix
                    if (debug >= 2) {
                        log.debug("searchXiffus.Sb(" + word + "/" + drow + "): "
                                + suffix + " =" + morph + "," + enrel + "," + morel);
                    }
                    if      (   word.endsWith(suffix)) {
                        result.add(morphem);
                    }
                } else if ( (   morph.startsWith("Aj") || morph.startsWith("Av") )
                        &&  ! wordUpperCase.matcher(word).lookingAt()
                        ) {
                    // now check whether it is a suffix
                    if (debug >= 2) {
                        log.debug("searchXiffus.Aj/Av(" + word + "/" + drow + "): "
                                + suffix + " =" + morph + "," + enrel + "," + morel);
                    }
                    if      (   word.endsWith(suffix)) {
                        result.add(morphem);
                    }
                } else {
                    if (debug >= 2) {
                        log.debug("else searchXiffus(" + word + "): " + morph);
                    }
                }
                imorph ++;
            } // while busy
        } catch (Exception exc) {
            log.error(exc.getMessage(), exc);
        }
        return result;
    } // searchXiffus

    /** Tests whether the word is or starts with a number word,
     *  possibly followed by a (declinated) ordinal, fractional or
     *  adjective suffix (-mal, -facher, -gleisige, -spurigen and so on).
     *  @param word to be classified, starting with a letter,
     *  contains no punctuation or whitespace
     *  @return list of morphems for that word, maybe empty
     */
    public MorphemList testNumeric(String word) {
        MorphemList result = getWords(word);
        try {
            // test for word starting with a number word
            int pos = numSpeller.parseString(word, 0);
            if (pos >= 3) { // starting with at least "ein-" or "ers-"
                String value = numSpeller.getResult();
                if (debug >= 3) {
                    log.debug("testNumeric: " + word + " = " + pos + ", " + value);
                }
                if (pos >= word.length()) {
                    // exact match - pure number word
                    result.add(new Morphem(word, "Nu." + value));
                } else { // not exact - prefix only
                    Iterator iter = nuSuffixes.iterator();
                    boolean found = false;
                    while (! found && iter.hasNext()) {
                        Morphem morphem = (Morphem) iter.next();
                        if (morphem.getEntry().equals(word.substring(pos))) {
                            morphem.setEnrel(morphem.getEntry()); // copy
                            morphem.setMorel(morphem.getMorph()); // copy
                            morphem.setEntry(word);
                            morphem.setMorph(morphem.getMorph() + "." + value);
                            result.add(morphem);
                            found = true;
                        }
                    } // while
                    if (! found) {
                        result.add(new Morphem(word, "Nu." + numSpeller.getResult()
                                , word.substring(pos), "Un"));
                    }
                } // not exact
            } // pos >= 3
            // else not starting with a number word
        } catch (Exception exc) {
            log.error(exc.getMessage(), exc);
        }
        return result;
    } // testNumeric

    /** Tests whether the word is a concatenation of several prepositions
     *  or other short, undeclinable words.
     *  @param word to be classified, starting with a letter,
     *  contains no punctuation or whitespace
     *  @return list of morphems for that word, maybe empty
     */
    public MorphemList testPrSplit(String word) {
        String lcWord = word.toLowerCase();
        MorphemList result = getWords(word);
        try {
            DeuPartList parts = new DeuPartList();
            boolean busy = result.isUnsure() && word.equals(lcWord); // && lowerCase
            int ipart = 0;
            while (busy) { // successively cut off prefixes
                Iterator iter = prPrimes.iterator();
                boolean found = false;
                while (! found && iter.hasNext()) {
                    Morphem morphem = (Morphem) iter.next(); // possible prefix
                    String entry = morphem.getEntry();
                    // System.out.println("split(" + lcWord + "): " + entry);
                    if (lcWord.startsWith(entry)) { // is really a prefix
                        found = true;
                        lcWord = lcWord.substring(entry.length());
                        ipart ++;
                        parts.add(entry, morphem.getMorph());
                    }
                } // while
                if (! found) { // all tried and none was a prefix
                    busy = false;
                } else if (lcWord.length() == 0) { // here the entire word was matched by prefixes
                    busy = false;
                    result.add(parts.pack(new Morphem(word, "PrConc")));
                    // , enrel.toString(), morel.toString()));
                }
            } // while busy
            if (ipart < 2) {
                result = new MorphemList(); // empty
            }
        } catch (Exception exc) {
            log.error(exc.getMessage(), exc);
        }
        return result;
    } // testPrSplit

    /** Tries to split a long word into its root components
     *  (substantives and/or adjectives).
     *  @param word to be classified, starting with a letter,
     *  contains no punctuation or whitespace
     *  @return list of morphems for that word, maybe empty
     */
    public MorphemList testSASplit(String word) {
        String lcWord = word.toLowerCase();
        String targetMorph = lcWord.equals(word) ? "Aj" : "Sb";
        MorphemList result = getWords(word);
        try {
            DeuPartList parts = new DeuPartList();
            boolean busy = result.isUnsure();
            int ipart = 0;
            while (busy) { // successively cut off prefixes
                MorphemList morphems = getForge(lcWord); // possible prefixes
                Morphem morphem = null;
                boolean found = false;
                if (morphems.isDetermined()) {
                    morphem = morphems.getWinner();
                    String entry = morphem.getEntry().toLowerCase();
                    if (lcWord.startsWith(entry)) { // is really a prefix
                        found = true;
                        int excess = parts.attach(entry, morphem.getMorph());
                        lcWord = lcWord.substring(entry.length() - excess);
                        ipart ++;
                    }
                }
                if (lcWord.length() == 0 && morphem != null) {
                    // here the entire word was matched by prefixes
                    busy = false;
                    String morph = morphem.getMorph();
                    if (morph.startsWith(targetMorph)) {
                        result.add(parts.pack(new Morphem(word, morph + "Conc")));
                    } else { // target morphem differs from winning morphem
                        result.add(parts.pack(new Morphem(word, "Un"  + "Conc")));
                    }
                } else if (! found
                        &&  (   lcWord.startsWith("s")
                            ||  lcWord.startsWith("n")
                            ||  lcWord.startsWith("e")
                            )
                        &&  parts.size() > 0
                        ) { // assume a connection morphem
                    int excess = parts.attach(lcWord.substring(0, 1), "Cm");
                    lcWord = lcWord.substring(1 - excess);
                    // busy = true
                } else if (! found) { // all tried and none was a prefix
                    busy = false;
                }
            } // while busy
            if (ipart < 2) {
                result = new MorphemList(); // empty
            }
        } catch (Exception exc) {
            log.error(exc.getMessage(), exc);
        }
        return result;
    } // testSaSplit

    /** Tries to split a long word into its root components
     *  (substantives and/or adjectives).
     *  @param word to be classified, starting with a letter,
     *  contains no punctuation or whitespace
     *  @return list of morphems for that word, maybe empty
     */
    public MorphemList testLexemSplit(String word) {
        String lcWord = word.toLowerCase();
        String targetMorph = lcWord.equals(word) ? "Aj" : "Sb";
        if (debug == -5) {
            log.debug("--------- testLexemSplit(" + word + ") ----------");
        }
        MorphemList result = new MorphemList();
        Morphem morphem = null;
        try {
            MorphemList stack = new MorphemList();
            int top = 0; // index of last element on 'stack'
            stack.add("", ""); // dummy element, to be marked
            int edgeLength = 0;
            boolean busy = true;
            while (busy) {
                edgeLength = stack.getEdgeLength();
                if (edgeLength >= lcWord.length()) {
                    // word exhausted
                    result.add(stack.concatenate(word));
                    if (debug == -5) {
                        // log.debug("concat  " + stack.toString()  + " prefix=\"" + lcWord.substring(0, edgeLength));
                        log.debug("result  " + result.toString());
                    }
                    top = stack.popToUnmarked();
                } else {
                    if (debug == -5) {
                        log.debug("start   " + stack.toString()
                                + " prefix=\"" + lcWord.substring(0, edgeLength) + "\"");
                    }
                    int old = top;
                    top = stack.pushList(getPrefixes(lcWord, edgeLength));
                    if (top == old) {
                        top = stack.popToUnmarked();
                    }
                    if (debug == -5) {
                        log.debug("pushed  " + stack.toString() + " prefix=\""
                                + lcWord.substring(0, edgeLength) + "\"");
                    }
                }
                busy = top >= 1; // 1 instead of 0 because of the dummy element
            } // while busy

        } catch (Exception exc) {
            log.error(exc.getMessage(), exc);
        }
        if (debug == -5) {
            log.debug("finally " + result.toString());
        }
        return result;
    } // testLexemSplit

    /** Tests the word by sequential lookup of tables
     *  <em>words</em>, <em>roots</em>, <em>xiffus</em>,
     *  <em>names</em>
     *  and (algorithmically) whether it's a number word.
     *  @param word to be classified, starting with a letter or digit,
     *  contains no punctuation or whitespace
     *  @return list of morphems for that word,
     *  maybe empty
     */
    public MorphemList testTableLookup(String word) {
        MorphemList result = getWords(word);
        try {
            int state = 0;
            boolean busy = true;
            while (busy && result.isUnsure()) {
                if (debug >= 3) {
                    log.debug("testTableLookup(" + word + "), state = " + state);
                }
                switch(state) {
                    case 0:
                        // word is or starts with a number word
                        result.addAll(testNumeric(word));
                        break;
                    case 1:
                        // search word in roots table:
                        // - verbs without endings
                        // - primary adjectives without endings
                        result.addAll(searchRoots(word));
                        break;
                    case 2:
                        // search word in reversed suffixes table:
                        // - strong verb conjugations
                        // - substantive endings
                        // - adjective and adverb endings
                        result.addAll(searchXiffus(word));
                        break;
                    case 3:
                        // test whether it's a name
                        if (word.length() > 0 && Character.isUpperCase(word.charAt(0))) {
                            result.addAll(getNames(word));
                        }
                    default:
                        busy = false; // break loop
                        break;
                } // switch state
                state ++;
            } // while busy
        } catch (Exception exc) {
            log.error(exc.getMessage(), exc);
        }
        return result;
    } // testTableLookup

    /** Tests variants of the word: opposite case of the first letter,
     *  without "-zu-" or "-ge-".
     *  @param word to be classified, starting with a letter or digit,
     *  contains no punctuation or whitespace
     *  @return list of morphems for that word,
     *  maybe empty
     */
    public MorphemList testVariants(String word) {
        MorphemList result  = testTableLookup(word);
        try {
            int state = 1; // unchanged word was tested above
            boolean busy = true;
            while (busy && result.isUnsure()) {
                // evaluate all bits in 'state'
                String word2 = word;
                if ((state & 0x20) != 0) {
                    // all bits exhausted - break loop
                    busy = false; // && word2.equals(word)
                } else if ((state & 0x01) != 0) {
                    // without -ge-
                    int gePos = word.indexOf("ge");
                    if (gePos >= 0 && gePos <= word.length() - 5) {
                        word2 = word.substring(0, gePos) + word.substring(gePos + 2);
                    }
                } else if ((state & 0x02) != 0) {
                    // without -zu-
                    int zuPos = word.indexOf("zu");
                    if (zuPos >= 0 && zuPos <= word.length() - 5) {
                        word2 = word.substring(0, zuPos) + word.substring(zuPos + 2);
                    }
                } else if ((state & 0x04) != 0) {
                    // change case of 1st letter
                    char ch1 = word.charAt(0);
                    if (Character.isUpperCase(ch1)) {
                        word2 = Character.toString(Character.toLowerCase(ch1)) + word.substring(1);
                    } else {
                        word2 = Character.toString(Character.toUpperCase(ch1)) + word.substring(1);
                    }
                } else if ((state & 0x08) != 0) {
                    // replace invalid "ß"
                    word2 = word.replaceAll("ß", "ss");
                } else if ((state & 0x10) != 0) {
                    if (word.endsWith("s")) {
                        // remove trailing "s"
                        word2 = word.substring(0, word.length() - 1);
                    }
                }

                if (! word2.equals(word)) {
                    if (debug >= 3) {
                        log.debug("testVariants(" + word + "), state = " + state);
                    }
                    result.addAll(testTableLookup(word2));
                }
                state ++;
            } // while busy

            if (result.isUnsure() && numberPattern.matcher(word).matches()) {
                // numbers are rare, therefore don't try them before
                result.add(new Morphem(word, "Nu"));
            }
        } catch (Exception exc) {
            log.error(exc.getMessage(), exc);
        }
        return result;
    } // testVariants

    /** Determines the most probable morphology (grammatical type)
     *  of a word, if possible
     *  @param word word to be classified, starting with a letter or digit,
     *  contains no punctuation or whitespace
     *  @return type of word, e.g. "VbIn", "SbSgMs" and so on,
     *  or null if no morphology can be determined
     */
    public Morphem test(String word) {
        Morphem result = null;
        MorphemList morphems = new MorphemList();
        if (false) {
        } else if (strategy.equals("all")) {
            morphems = testVariants(word);
        } else if (strategy.equals("prsplit")) {
            morphems = testPrSplit(word);
        } else if (strategy.equals("lexsplit")) {
            morphems = testLexemSplit(word);
        } else if (strategy.equals("sasplit")) {
            morphems = testSASplit(word);
        } else {
            log.error("unknown strategy \"" + strategy + "\"");
        }
        if (morphems.isDetermined()) {
            if (debug >= 3) {
                log.debug("test(" + word + "): " + morphems.toString());
            }
            if (debug > 0 && morphems.size() >= 2) {
                log.info(morphems.toString());
            }
            result = morphems.getWinner();
        }
        return result;
    } // test

    /** Test program, classifies all commandline arguments (words)
     *  @param args commandline arguments = single words to be tested
     */
    public static void main(String args[]) {
        MorphemTester tester = new MorphemTester();
        for (int iargs = 0; iargs < args.length; iargs ++) {
            System.out.println(tester.test(args[iargs]).toString());
        }
        tester.destroy();
    } // main

} // MorphemTester
