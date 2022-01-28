/*  IndexPage.java - starting web page for GramWord
 *  @(#) $Id: 57d01d0860aef0c2f2783647be70c3c381710c86 $
 *  2017-05-29: javadoc 1.8
 *  2016-09-22: IBANFilter removed
    2016-09-21: simple handler deprecated
 *  2016-09-20, Dr. Georg Fischer
 */
/*
 * Copyright 2016 Dr. Georg Fischer <punctum at punctum dot kom>
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
package org.teherba.gramword.web;
import  org.teherba.common.web.BasePage;
import  java.io.PrintWriter;
import  java.io.StringReader;
import  java.io.Serializable;
import  java.util.Iterator;
import  javax.servlet.http.HttpServletRequest;
import  javax.servlet.http.HttpServletResponse;
import  org.apache.commons.fileupload.FileItem;
import  org.apache.logging.log4j.Logger;
import  org.apache.logging.log4j.LogManager;

/** Xtrans main dialog page
 *  @author Dr. Georg Fischer
 */
public class IndexPage implements Serializable {
    public final static String CVSID = "@(#) $Id: 57d01d0860aef0c2f2783647be70c3c381710c86 $";
    public final static long serialVersionUID = 19470629;

    /** log4j logger (category) */
    private Logger log;

    /** No-args Constructor
     */
    public IndexPage() {
        log = LogManager.getLogger(IndexPage.class.getName());
    } // Constructor

    /** Output the main dialog page for Xtrans
     *  @param request request with header fields
     *  @param response response with writer
     *  @param basePage refrence to common methods and error messages
     */
    public void dialog(HttpServletRequest request, HttpServletResponse response
            , BasePage basePage
            ) {
        try {
            String language   = basePage.getFormField("lang"     );
            String encoding   = basePage.getFormField("enc"      );
            String filter     = basePage.getFormField("filter"   );
            String format     = basePage.getFormField("format"   );
            String grammar    = basePage.getFormField("grammar"  );
            String infile     = basePage.getFormField("infile"   );
            String strategy   = basePage.getFormField("strat"    );
            FileItem fileItem = basePage.getFormFile(0);

            PrintWriter out = basePage.writeHeader(request, response, language);
            out.write("<title>" + basePage.getAppName() + " Main Page</title>\n");
            out.write("    <script src=\"script.js\" type=\"text/javascript\">\n");
            out.write("    </script>\n");
            out.write("</head>\n<body>\n");
            out.write("<!--lang=\""     + language
                    + "\", enc=\""      + encoding
                    + "\", filter=\""   + filter
                    + "\", format=\""   + format
                    + "\", grammar=\""  + grammar
                    + "\", infile=\""   + infile
                    + "\", strat=\""    + strategy
                    + "\"-->\n");
            String[] optEnc    = new String []
                    /*  0 */ { "ISO-8859-1"
                    /*  1 */ , "UTF-8"
                    } ;
            String[] enEnc    = new String []
                    /*  0 */ { "ISO-8859-1"
                    /*  1 */ , "UTF-8"
                    } ;
            String[] optFilter = new String []
                    /*  0 */ { "queue"
                    /*  1 */ , "bibleref"
                    /*  2 */ , "konto"
                    /*  3 */ , "number"
                    /*  4 */ , "wordtype"
                    } ;
            String[] enFilter = new String []
                    /*  0 */ { "queue"
                    /*  1 */ , "bibleref"
                    /*  2 */ , "konto"
                    /*  3 */ , "number"
                    /*  4 */ , "wordtype"
                    } ;
            String[] optFormat = new String []
                    /*  0 */ { "html"
                    /*  1 */ , "text"
                    /*  2 */ , "dict"
                    } ;
            String[] enFormat = new String []
                    /*  0 */ { "HTML"
                    /*  1 */ , "Text"
                    /*  2 */ , "Dictionary"
                    } ;
            String[] optGrammar = new String []
                    /*  0 */ { "de"
            //      /*  1 */ , "en"
                    } ;
            String[] enGrammar = new String []
                    /*  0 */ { "Deutsch"
            //      /*  1 */ , "English"
                    } ;
            String[] optStrat  = new String []
                    /*  0 */ { "all"
                    /*  1 */ , "prsplit"
                    /*  2 */ , "sasplit"
                    } ;
            String[] enStrat  = new String []
                    /*  0 */ { "all"
                    /*  1 */ , "prsplit"
                    /*  2 */ , "sasplit"
                    } ;
            int index = 0;

            out.write("    <h2>GramWord</h2>\n");
            out.write("    <p><strong>GramWord</strong> is a Java package which uses a relational\n");
            out.write("    (MySql) database\n");
            out.write("    to recognize a limited set of German words.\n");
            out.write("    </p><p>\n");
            out.write("    Sets of common words, names,\n");
            out.write("    roots and endings of verbs, substantives, adjectives and adverbs,\n");
            out.write("    together with their grammatical type and conjugation/declination\n");
            out.write("    are preloaded from dictionary files into database tables.\n");
            out.write("    </p><p>\n");
            out.write("    Several decision algorithms use these tables to determine the\n");
            out.write("    grammatical type of the words in a text. In the HTML output,\n");
            out.write("    the recognized words are shown in different colors.\n");
            out.write("    </p>\n");
            out.write("    <strong>Short Example</strong> (sentence from \"Don Quijote\")\n");
            out.write("<blockquote>\n");
            out.write("<span class=\"Pr\" morph=\"\">Nachdem</span> <span class=\"Pn\" morph=\"SgPersNomvMs3\">er</span> <span class=\"Aj\" morph=\"Qant\">alle</span> <span class=\"Aj\" morph=\"Qant\">diese</span> <span class=\"Sb\" morph=\"Pl\">Vorkehrungen</span> <span class=\"Vb\" morph=\"SPa0\">getroffen</span>, <span class=\"Vb\" morph=\"SIp11\">wollte</span> <span class=\"Pn\" morph=\"SgPersNomvMs3\">er</span> <span class=\"Un\" morph=\"\">nicht</span>\n");
            out.write("<span class=\"Aj\" morph=\"Cmpr\">l&#xe4;nger</span> <span class=\"Vb\" morph=\"SIn0\">warten</span>, <span class=\"Vb\" morph=\"SIn0\">sein</span> <span class=\"Vb\" morph=\"RtWeak\">Vorhaben</span> <span class=\"Pr\" morph=\"Shor\">ins</span> <span class=\"Sb\" morph=\"SgNt\">Werk</span> <span class=\"Pr\" morph=\"Prim\">zu</span> <span class=\"Vb\" morph=\"RtWeak\">setzen</span>; <span class=\"Pn\" morph=\"SgPersNomvNt3\">es</span> dr&#xe4;ngte <span class=\"Pn\" morph=\"SgPersAccv3Ms\">ihn</span>\n");
            out.write("<span class=\"Av\" morph=\"\">dazu</span> <span class=\"Ar\" morph=\"DetmNomvSgMs\">der</span> <span class=\"Sb\" morph=\"SgMs\">Gedanke</span> <span class=\"Pr\" morph=\"Prim\">an</span> <span class=\"Ar\" morph=\"DetmNomvSgFm\">die</span> <span class=\"Sb\" morph=\"SgFm\">Entbehrung</span>, <span class=\"Ar\" morph=\"DetmNomvSgFm\">die</span> <span class=\"Ar\" morph=\"DetmNomvSgFm\">die</span> <span class=\"Sb\" morph=\"SgFm\">Welt</span> <span class=\"Pr\" morph=\"\">durch</span> <span class=\"Vb\" morph=\"SIn0\">sein</span>\n");
            out.write("<span class=\"Vb\" morph=\"RtWeak\">Z&#xf6;gern</span> <span class=\"Vb\" morph=\"SCs13\">erleide</span>, derart <span class=\"Vb\" morph=\"SIp91\">waren</span> <span class=\"Ar\" morph=\"DetmNomvSgFm\">die</span> Unbilden, <span class=\"Pn\" morph=\"Relt\">denen</span> <span class=\"Pn\" morph=\"SgPersNomvMs3\">er</span> <span class=\"Pr\" morph=\"Prim\">zu</span> <span class=\"Vb\" morph=\"RtWeak\">steuern</span>,\n");
            out.write("<span class=\"Ar\" morph=\"DetmNomvSgFm\">die</span> <span class=\"Sb\" morph=\"Pl\">Ungerechtigkeiten</span>, <span class=\"Ar\" morph=\"DetmNomvSgFm\">die</span> <span class=\"Pn\" morph=\"SgPersNomvMs3\">er</span> <span class=\"Vb\" morph=\"SCs93\">zurechtzubringen</span>, <span class=\"Ar\" morph=\"DetmNomvSgFm\">die</span> Ungeb&#xfc;hr,\n");
            out.write("<span class=\"Ar\" morph=\"DetmNomvSgMs\">der</span> <span class=\"Pn\" morph=\"SgPersNomvMs3\">er</span> <span class=\"Vb\" morph=\"SCs93\">abzuhelfen</span>, <span class=\"Ar\" morph=\"DetmNomvSgFm\">die</span> Mi&#xdf;br&#xe4;uche, <span class=\"Ar\" morph=\"DetmNomvSgFm\">die</span> <span class=\"Pn\" morph=\"SgPersNomvMs3\">er</span> wiedergutzumachen,\n");
            out.write("<span class=\"Aj\" morph=\"Root\">kurz</span>, <span class=\"Ar\" morph=\"DetmNomvSgFm\">die</span> <span class=\"Sb\" morph=\"Pl\">Pflichten</span>, <span class=\"Pn\" morph=\"Relt\">denen</span> <span class=\"Pn\" morph=\"SgPersNomvMs3\">er</span> <span class=\"Pr\" morph=\"Prim\">zu</span> <span class=\"Vb\" morph=\"RtWeak\">gen&#xfc;gen</span> <span class=\"Vb\" morph=\"SIp13\">gedachte</span>. <span class=\"Cj\" morph=\"\">Und</span> <span class=\"Un\" morph=\"\">so</span>, <span class=\"Un\" morph=\"\">ohne</span>\n");
            out.write("irgendeinem <span class=\"Pr\" morph=\"Prim\">von</span> <span class=\"Pn\" morph=\"SgPersGenv3Ms\">seiner</span> Absicht <span class=\"Sb\" morph=\"SgFm\">Kunde</span> <span class=\"Pr\" morph=\"Prim\">zu</span> <span class=\"Vb\" morph=\"SIn0\">geben</span> <span class=\"Cj\" morph=\"\">und</span> <span class=\"Un\" morph=\"\">ohne</span> <span class=\"Cj\" morph=\"\">da&#xdf;</span>\n");
            out.write("<span class=\"Pn\" morph=\"UndtNomv\">jemand</span> <span class=\"Pn\" morph=\"SgPersAccv3Ms\">ihn</span> <span class=\"Vb\" morph=\"SIp11\">sah</span>, bewehrte <span class=\"Pn\" morph=\"SgPersNomvMs3\">er</span> <span class=\"Pn\" morph=\"ReflSg3\">sich</span> <span class=\"Ar\" morph=\"UndtGenvSgMs\">eines</span> <span class=\"Nm\" morph=\"PersSurn\">Morgens</span> <span class=\"Pr\" morph=\"Prim\">vor</span> Anbruch <span class=\"Ar\" morph=\"DetmGenvSgMs\">des</span>\n");
            out.write("<span class=\"Sb\" morph=\"SgGe\">Tages</span> - <span class=\"Pn\" morph=\"SgPersNomvNt3\">es</span> <span class=\"Vb\" morph=\"SIp11\">war</span> <span class=\"Ar\" morph=\"UndtGenvSgFm\">einer</span> <span class=\"Ar\" morph=\"DetmNomvSgMs\">der</span> <span class=\"Vb\" morph=\"SIn0\">hei&#xdf;en</span> Julitage - <span class=\"Pr\" morph=\"Prim\">mit</span> <span class=\"Pn\" morph=\"SgPersGenv3Ms\">seiner</span> <span class=\"Aj\" morph=\"Qant\">ganzen</span>\n");
            out.write("<span class=\"Sb\" morph=\"SgFm\">R&#xfc;stung</span>, <span class=\"Vb\" morph=\"SIp11\">stieg</span> <span class=\"Pr\" morph=\"Prim\">auf</span> <span class=\"Ar\" morph=\"DetmDatvPl\">den</span> <span class=\"Nm\" morph=\"FmZool\">Rosinante</span>, <span class=\"Pr\" morph=\"\">nachdem</span> <span class=\"Pn\" morph=\"SgPersNomvMs3\">er</span> <span class=\"Pn\" morph=\"SgPossDatvPl3\">seinen</span>\n");
            out.write("zusammengeflickten Turnierhelm aufgesetzt, fa&#xdf;te <span class=\"Pn\" morph=\"SgPossNomvFm3\">seine</span> <span class=\"Sb\" morph=\"SgFm\">Tartsche</span>\n");
            out.write("<span class=\"Pr\" morph=\"Prim\">in</span> <span class=\"Ar\" morph=\"DetmDatvPl\">den</span> <span class=\"Sb\" morph=\"SgMsBody\">Arm</span>, <span class=\"Vb\" morph=\"SIp11\">nahm</span> <span class=\"Pn\" morph=\"SgPossDatvPl3\">seinen</span> <span class=\"Sb\" morph=\"SgMs\">Speer</span> <span class=\"Cj\" morph=\"\">und</span> <span class=\"Vb\" morph=\"SIp11\">zog</span> <span class=\"Pr\" morph=\"\">durch</span> <span class=\"Ar\" morph=\"DetmNomvSgFm\">die</span> Hinterpforte\n");
            out.write("<span class=\"Pn\" morph=\"SgPossGenvMs3\">seines</span> <span class=\"Sb\" morph=\"SgGe\">Hofes</span> <span class=\"Pr\" morph=\"\">hinaus</span> <span class=\"Pr\" morph=\"Shor\">aufs</span> <span class=\"Sb\" morph=\"SgNt\">Feld</span>, <span class=\"Pr\" morph=\"Prim\">mit</span> <span class=\"Aj\" morph=\"XC\">gewaltiger</span> <span class=\"Sb\" morph=\"SgFm\">Befriedigung</span> <span class=\"Cj\" morph=\"\">und</span>\n");
            out.write("Herzensfreude <span class=\"Av\" morph=\"ModlAnct\">darob</span>, <span class=\"Pr\" morph=\"Prim\">mit</span> <span class=\"Ir\" morph=\"Prim\">wie</span> <span class=\"Nm\" morph=\"PersSurn\">gro&#xdf;er</span> <span class=\"Sb\" morph=\"SgFm\">Leichtigkeit</span> <span class=\"Pn\" morph=\"SgPersNomvMs3\">er</span> <span class=\"Vb\" morph=\"SIn0\">sein</span>\n");
            out.write("<span class=\"Aj\" morph=\"XP\">l&#xf6;bliches</span> <span class=\"Vb\" morph=\"RtWeak\">Vorhaben</span> <span class=\"Vb\" morph=\"SCt93\">auszuf&#xfc;hren</span> <span class=\"Vb\" morph=\"SPa0\">begonnen</span>.\n");
            out.write("</blockquote>\n");
            out.write("<form action=\"servlet\" method=\"POST\" enctype=\"multipart/form-data\">\n");
            out.write("    <input type = \"hidden\" name=\"view\" value=\"index2\" />\n");
            out.write("    <table cellpadding=\"4\" border=\"0\">\n");
            out.write("        <tr valign=\"top\">\n");
            out.write("           <td colspan=\"5\"><strong>Source file to be uploaded: </strong>");
            out.write("               <input name=\"infile\" type=\"file\" style=\"font-family: Courier, monospace\" ");
            out.write("                       maxsize=\"256\" size=\"80\" value=\"" + infile + "\" />\n");
            out.write("           </td>\n");
            out.write("        </tr>\n");
            out.write("        <tr valign=\"top\">\n");
            out.write("            <td><strong>Source<br />Encoding</strong><br />\n");
            out.write("                <select name=\"enc\" size=\"" + optEnc.length  + "\">\n");
                                       index = 0;
                                       while (index < optEnc.length) {
            out.write("                    <option value=\""
                                                   + optEnc[index] + "\""
                                                   + (optEnc[index].equals(encoding) ? " selected" : "")
                                                   + ">"
                                                   + enEnc[index] + "</option>\n");
                                           index ++;
                                       } // while index

            out.write("                </select>\n");
            out.write("            </td>\n");
            out.write("            <td><strong>Target<br />Format</strong><br />\n");
            out.write("                <select name=\"format\" size=\"" + optFormat.length + "\">\n");
                                       index = 0;
                                       while (index < optFormat.length) {
            out.write("                    <option value=\""
                                                   + optFormat[index] + "\""
                                                   + (optFormat[index].equals(format) ? " selected" : "")
                                                   + ">"
                                                   + enFormat[index] + "</option>\n");
                                           index ++;
                                       } // while index
            out.write("                </select>\n");
            out.write("            </td>\n");
            out.write("            <td><strong>Filter<br />to be used</strong><br />\n");
            out.write("                <select name=\"filter\" size=\"" + optFilter.length + "\">\n");
                                       index = 0;
                                       while (index < optFilter.length) {
            out.write("                    <option value=\""
                                                   + optFilter[index] + "\""
                                                   + (optFilter[index].equals(filter) ? " selected" : "")
                                                   + ">"
                                                   + enFilter[index] + "</option>\n");
                                           index ++;
                                       } // while index
            out.write("                </select>\n");
            out.write("            </td>\n");
            out.write("            <td><strong>Source<br />Grammar</strong><br />\n");
            out.write("                <select name=\"grammar\" size=\""+ optGrammar.length + "\">\n");
                                       index = 0;
                                       while (index < optGrammar.length) {
            out.write("                    <option value=\""
                                                   + optGrammar[index] + "\""
                                                   + (optGrammar[index].equals(language) ? " selected" : "")
                                                   + ">"
                                                   + enGrammar[index] + "</option>\n");
                                           index ++;
                                       } // while index
            out.write("                </select>\n");
            out.write("            </td>\n");
            out.write("            <td><strong>Strategy</strong><br />\n");
            out.write("                <select name=\"strat\" size=\"" + optStrat.length + "\">\n");
                                       index = 0;
                                       while (index < optStrat.length) {
            out.write("                    <option value=\""
                                                   + optStrat[index] + "\""
                                                   + (optStrat[index].equals(strategy) ? " selected" : "")
                                                   + ">"
                                                   + enStrat[index] + "</option>\n");
                                           index ++;
                                       } // while index
            out.write("                </select>\n");
            out.write("            </td>\n");
            out.write("            <td><input type=\"submit\" value=\"Submit\" /></td>\n");
            out.write("        </tr>\n");
            out.write("    </table>\n");
            out.write("</form>\n");

            basePage.writeAuxiliaryLinks(language, "main");

            out.write("<h4>Applications of <em>QueueTransformer</em></h4>\n");
            out.write("<table border=\"0\">\n");
            out.write("    <tr><td>bibleref:</td><td>Table of Luther's pericopes - <a href=\"bibleref/luther_perikope.htm\">(original)</a> and with\n");
            out.write("        <a href=\"bibleref/luther_perikope.html\">autolinked</a> bible references</td></tr>\n");
            out.write("    <tr><td>&nbsp;</td><td><a href=\"bibleref/wiki_perikope.htm\">Table of pericopes</a> from de.wikipedia -\n");
            out.write("        <a href=\"bibleref/wiki_perikope.html\">autolinked</a></td></tr>\n");
            out.write("    <tr><td>konto:</td><td>Autolinked German bank ids with <a href=\"konto.html\">check/correction</a>\n");
            out.write("        of account numbers nearby</td></tr>\n");
            out.write("    <tr><td>number:</td><td>Parsing of German number words in <a href=\"number.html\">Genesis 5</a></td></tr>\n");
            out.write("    <tr><td>wordtype:</td><td>Don Quixote <a href=\"wordtype/quixote0.html\">(original)</a>, with\n");
            out.write("        <a href=\"queue.html\">green</a> uppercase words, and with <a href=\"wordtype.html\">colored word types</a>.</td></tr>\n");
            out.write("</table>\n");

            basePage.writeTrailer(language, "quest");
        } catch (Exception exc) {
            log.error(exc.getMessage(), exc);
        }
    } // dialog

    //================
    // Main method
    //================

    /** Test driver
     *  @param args language code: "en", "de"
     */
    public static void main(String[] args) {
        IndexPage help = new IndexPage();
        System.out.println("no messages");
    } // main

} // IndexPage
