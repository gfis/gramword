<%--
    @(#) $Id: index.jsp 976 2013-02-02 16:44:18Z gfis $
    2007-04-04: umlauts replaced by hex entities
    2007-02-15: copied from xtrans
    Caution, this file must be encoded in pure ASCII because of Jasper2 compilation
--%>
<%@page import="java.util.Iterator"%>
<%
response.setContentType("text/html; charset=utf-8"); 
%>
<%-- 
--%>
<?xml version="1.0"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--
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
--%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <!--
    -->
    <title>Words and Grammar</title>
    <link rel="stylesheet" type="text/css" href="stylesheet.css" />
    <script src="script.js" type="text/javascript">
    </script>
</head>
<%
    String CVSID = "@(#) $Id: index.jsp 976 2013-02-02 16:44:18Z gfis $";
    String[] optEnc    = new String [] 
            /*  0 */ { "ISO-8859-1"
            /*  1 */ , "UTF-8"
            } ;
    String[] enEnc    = new String [] 
            /*  0 */ { "ISO-8859-1"
            /*  1 */ , "UTF-8"
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
    String[] optLang = new String [] 
            /*  0 */ { "de"
    //      /*  1 */ , "en"
            } ;
    String[] enLang = new String [] 
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
    Object // enc, lang, mode, strategy
           // nsp  dir   format  opt
    field = session.getAttribute("format"   );  String format       = (field != null) ? (String) field : "html";
    field = session.getAttribute("lang"     );  String language     = (field != null) ? (String) field : "de";
    field = session.getAttribute("enc"      );  String encoding     = (field != null) ? (String) field : "ISO-8859-1";
    field = session.getAttribute("strat"    );  String strategy     = (field != null) ? (String) field : "all";
    field = session.getAttribute("infile"   );  String infile       = (field != null) ? (String) field : "";
    int index = 0;
%>
<body>
    <!--
    format="<%=format%>", lang="<%=language%>", enc="<%=encoding%>", strat="<%=strategy%>, infile="<%=infile%>" 
    -->
    <h2>gramword</h2>
    <p><em>gramword</em> is a Java package which uses a relational 
    (MySql) database 
    to recognize a limited set of German words. 
    </p><p>
    Sets of common words, names,
    roots and endings of verbs, substantives, adjectives and adverbs,
    together with their grammatical type and conjugation/declination
    are preloaded from dictionary files into database tables.
    </p><p>
    Several decision algorithms use these tables to determine the
    grammatical type of the words in a text. In the HTML output,
    the recognized words are shown in different colors.
    </p><p>
        <em>gramword</em> uses its sister projects 
        <ul>
        <li><a href="../dbat/"    >dbat</a> for database access,</li>
        <li><a href="../numword/" >numword</a> for number words, months and weekdays and</li>
        <li><a href="../xtrans/"  >xtrans</a> for XML filtering.</li>
        </ul>
    </p>

    <strong>Short Example</strong> (sentence from "Don Quijote")
    <blockquote>
<span class="Pr" morph="">Nachdem</span> <span class="Pn" morph="SgPersNomvMs3">er</span> <span class="Aj" morph="Qant">alle</span> <span class="Aj" morph="Qant">diese</span> <span class="Sb" morph="Pl">Vorkehrungen</span> <span class="Vb" morph="SPa0">getroffen</span>, <span class="Vb" morph="SIp11">wollte</span> <span class="Pn" morph="SgPersNomvMs3">er</span> <span class="Un" morph="">nicht</span>
<span class="Aj" morph="Cmpr">l&#xe4;nger</span> <span class="Vb" morph="SIn0">warten</span>, <span class="Vb" morph="SIn0">sein</span> <span class="Vb" morph="RtWeak">Vorhaben</span> <span class="Pr" morph="Shor">ins</span> <span class="Sb" morph="SgNt">Werk</span> <span class="Pr" morph="Prim">zu</span> <span class="Vb" morph="RtWeak">setzen</span>; <span class="Pn" morph="SgPersNomvNt3">es</span> dr&#xe4;ngte <span class="Pn" morph="SgPersAccv3Ms">ihn</span>
<span class="Av" morph="">dazu</span> <span class="Ar" morph="DetmNomvSgMs">der</span> <span class="Sb" morph="SgMs">Gedanke</span> <span class="Pr" morph="Prim">an</span> <span class="Ar" morph="DetmNomvSgFm">die</span> <span class="Sb" morph="SgFm">Entbehrung</span>, <span class="Ar" morph="DetmNomvSgFm">die</span> <span class="Ar" morph="DetmNomvSgFm">die</span> <span class="Sb" morph="SgFm">Welt</span> <span class="Pr" morph="">durch</span> <span class="Vb" morph="SIn0">sein</span>
<span class="Vb" morph="RtWeak">Z&#xf6;gern</span> <span class="Vb" morph="SCs13">erleide</span>, derart <span class="Vb" morph="SIp91">waren</span> <span class="Ar" morph="DetmNomvSgFm">die</span> Unbilden, <span class="Pn" morph="Relt">denen</span> <span class="Pn" morph="SgPersNomvMs3">er</span> <span class="Pr" morph="Prim">zu</span> <span class="Vb" morph="RtWeak">steuern</span>,
<span class="Ar" morph="DetmNomvSgFm">die</span> <span class="Sb" morph="Pl">Ungerechtigkeiten</span>, <span class="Ar" morph="DetmNomvSgFm">die</span> <span class="Pn" morph="SgPersNomvMs3">er</span> <span class="Vb" morph="SCs93">zurechtzubringen</span>, <span class="Ar" morph="DetmNomvSgFm">die</span> Ungeb&#xfc;hr,
<span class="Ar" morph="DetmNomvSgMs">der</span> <span class="Pn" morph="SgPersNomvMs3">er</span> <span class="Vb" morph="SCs93">abzuhelfen</span>, <span class="Ar" morph="DetmNomvSgFm">die</span> Mi&#xdf;br&#xe4;uche, <span class="Ar" morph="DetmNomvSgFm">die</span> <span class="Pn" morph="SgPersNomvMs3">er</span> wiedergutzumachen,
<span class="Aj" morph="Root">kurz</span>, <span class="Ar" morph="DetmNomvSgFm">die</span> <span class="Sb" morph="Pl">Pflichten</span>, <span class="Pn" morph="Relt">denen</span> <span class="Pn" morph="SgPersNomvMs3">er</span> <span class="Pr" morph="Prim">zu</span> <span class="Vb" morph="RtWeak">gen&#xfc;gen</span> <span class="Vb" morph="SIp13">gedachte</span>. <span class="Cj" morph="">Und</span> <span class="Un" morph="">so</span>, <span class="Un" morph="">ohne</span>
irgendeinem <span class="Pr" morph="Prim">von</span> <span class="Pn" morph="SgPersGenv3Ms">seiner</span> Absicht <span class="Sb" morph="SgFm">Kunde</span> <span class="Pr" morph="Prim">zu</span> <span class="Vb" morph="SIn0">geben</span> <span class="Cj" morph="">und</span> <span class="Un" morph="">ohne</span> <span class="Cj" morph="">da&#xdf;</span>
<span class="Pn" morph="UndtNomv">jemand</span> <span class="Pn" morph="SgPersAccv3Ms">ihn</span> <span class="Vb" morph="SIp11">sah</span>, bewehrte <span class="Pn" morph="SgPersNomvMs3">er</span> <span class="Pn" morph="ReflSg3">sich</span> <span class="Ar" morph="UndtGenvSgMs">eines</span> <span class="Nm" morph="PersSurn">Morgens</span> <span class="Pr" morph="Prim">vor</span> Anbruch <span class="Ar" morph="DetmGenvSgMs">des</span>
<span class="Sb" morph="SgGe">Tages</span> - <span class="Pn" morph="SgPersNomvNt3">es</span> <span class="Vb" morph="SIp11">war</span> <span class="Ar" morph="UndtGenvSgFm">einer</span> <span class="Ar" morph="DetmNomvSgMs">der</span> <span class="Vb" morph="SIn0">hei&#xdf;en</span> Julitage - <span class="Pr" morph="Prim">mit</span> <span class="Pn" morph="SgPersGenv3Ms">seiner</span> <span class="Aj" morph="Qant">ganzen</span>
<span class="Sb" morph="SgFm">R&#xfc;stung</span>, <span class="Vb" morph="SIp11">stieg</span> <span class="Pr" morph="Prim">auf</span> <span class="Ar" morph="DetmDatvPl">den</span> <span class="Nm" morph="FmZool">Rosinante</span>, <span class="Pr" morph="">nachdem</span> <span class="Pn" morph="SgPersNomvMs3">er</span> <span class="Pn" morph="SgPossDatvPl3">seinen</span>
zusammengeflickten Turnierhelm aufgesetzt, fa&#xdf;te <span class="Pn" morph="SgPossNomvFm3">seine</span> <span class="Sb" morph="SgFm">Tartsche</span>
<span class="Pr" morph="Prim">in</span> <span class="Ar" morph="DetmDatvPl">den</span> <span class="Sb" morph="SgMsBody">Arm</span>, <span class="Vb" morph="SIp11">nahm</span> <span class="Pn" morph="SgPossDatvPl3">seinen</span> <span class="Sb" morph="SgMs">Speer</span> <span class="Cj" morph="">und</span> <span class="Vb" morph="SIp11">zog</span> <span class="Pr" morph="">durch</span> <span class="Ar" morph="DetmNomvSgFm">die</span> Hinterpforte
<span class="Pn" morph="SgPossGenvMs3">seines</span> <span class="Sb" morph="SgGe">Hofes</span> <span class="Pr" morph="">hinaus</span> <span class="Pr" morph="Shor">aufs</span> <span class="Sb" morph="SgNt">Feld</span>, <span class="Pr" morph="Prim">mit</span> <span class="Aj" morph="XC">gewaltiger</span> <span class="Sb" morph="SgFm">Befriedigung</span> <span class="Cj" morph="">und</span>
Herzensfreude <span class="Av" morph="ModlAnct">darob</span>, <span class="Pr" morph="Prim">mit</span> <span class="Ir" morph="Prim">wie</span> <span class="Nm" morph="PersSurn">gro&#xdf;er</span> <span class="Sb" morph="SgFm">Leichtigkeit</span> <span class="Pn" morph="SgPersNomvMs3">er</span> <span class="Vb" morph="SIn0">sein</span>
<span class="Aj" morph="XP">l&#xf6;bliches</span> <span class="Vb" morph="RtWeak">Vorhaben</span> <span class="Vb" morph="SCt93">auszuf&#xfc;hren</span> <span class="Vb" morph="SPa0">begonnen</span>.
    </blockquote>

    <form action="grammarservlet" method="post" enctype="multipart/form-data">
        <input type = "hidden" name="view" value="index" />
        <br /><strong>Upload a text file:</strong><br />
        <input name="infile" type="file" style="font-family: Courier, monospace" 
                maxsize="256" size="80" value="<%=infile%>"/>
	<%--
    --%>            
        <br />&nbsp;
        <table cellpadding="8">
            <tr valign="top">
                <td><strong>Source Encoding</strong><br /> 
                    <select name="enc" size="<%= optEnc.length %>">
                    <%
                        index = 0;
                        while (index < optEnc.length) {
                            out.write("<option value=\"" 
                                    + optEnc[index] + "\""
                                    + (optEnc[index].equals(encoding) ? " selected" : "")
                                    + ">"
                                    + enEnc[index] + "</option>\n");
                            index ++;
                        } // while index
                    %>
                    </select>
                </td>
                <td><strong>Format</strong><br />
                    <select name="format" size="<%= optFormat.length %>">
                    <%
                        index = 0;
                        while (index < optFormat.length) {
                            out.write("<option value=\"" 
                                    + optFormat[index] + "\""
                                    + (optFormat[index].equals(format) ? " selected" : "")
                                    + ">"
                                    + enFormat[index] + "</option>\n");
                            index ++;
                        } // while index
                    %>
                    </select>
                </td>
                <td><strong>Language</strong><br />
                    <select name="lang" size="<%= optLang.length %>">
                    <%
                        index = 0;
                        while (index < optLang.length) {
                            out.write("<option value=\"" 
                                    + optLang[index] + "\""
                                    + (optLang[index].equals(language) ? " selected" : "")
                                    + ">"
                                    + enLang[index] + "</option>\n");
                            index ++;
                        } // while index
                    %>
                    </select>
                </td>
                <td><strong>Strategy</strong><br /> 
                    <select name="strat" size="<%= optStrat.length %>">
                    <%
                        index = 0;
                        while (index < optStrat.length) {
                            out.write("<option value=\"" 
                                    + optStrat[index] + "\""
                                    + (optStrat[index].equals(strategy) ? " selected" : "")
                                    + ">"
                                    + enStrat[index] + "</option>\n");
                            index ++;
                        } // while index
                    %>
                    </select>
                </td>
                <td>
                    <input type="submit" value="Submit" />
                </td>
	<%--
	--%>
            </tr>
        </table>
    </form>
    <p />
    <table>
        <tr valign="top"><td>
        	<table border="0">
            	<tr><td><a href="quixote1-4.html">Longer Example</a> (Chapters 1 - 4 from "Don Quijote")
                </td></tr>
                <tr><td><a href="docs/api/index.html">API documentation</a> (Javadoc)
                </td></tr>
                <tr><td><a href="docs/coding.html">Coding of Syntactic and Semantic Attributes of Words</a>
                </td></tr>
                <tr><td><a href="docs/decisions.html">Decision Algorithms</a>
                </td></tr>
                <tr><td><a href="docs/developer.html">Hints for developers</a>
                </td></tr>
                <tr><td><a href="docs/bugs.html">Limitations and Bugs</a>
                </td></tr>
				<tr><td><a href="grammarservlet?view=table">Classify Words</a>
                </td></tr>
				<tr><td><a href="metaInf.jsp?view=manifest">Manifest</a>, 
  			            <a href="metaInf.jsp?view=license" >License</a>, 
          				<a href="metaInf.jsp?view=notice"  >References</a>
                </td></tr>
			</table>
        </td><td>
        	<table border="0">
        		<tr><th colspan="2" align="left">Applications of <em>QueueTransformer</em></th></tr>
            	<tr><td>bibleref:</td><td>Table of Luther's pericopes - <a href="bibleref/luther_perikope.htm">(original)</a> and with
		            <a href="bibleref/luther_perikope.html">autolinked</a> bible references
            		</td></tr>
        		<tr><td>&nbsp;</td><td><a href="bibleref/wiki_perikope.htm">Table of pericopes</a> from de.wikipedia -  
           			<a href="bibleref/wiki_perikope.html">autolinked</a>
            		</td></tr>
            	<tr><td>konto:</td><td>Autolinked German bank ids with <a href="konto.html">check/correction</a> 
            		of account numbers nearby
            		</td></tr>
            	<tr><td>number:</td><td>Parsing of German number words in <a href="number.html">Genesis 5</a>
            		</td></tr>
            	<tr><td>wordtype:</td><td>Don Quixote <a href="wordtype/quixote0.html">(original)</a>, with 
            		<a href="queue.html">green</a> uppercase words, and with <a href="wordtype.html">colored word types</a>.   
            		</td></tr>
        	</table>
        </td></tr>
    </table>        
    <p />
    <font size="-1">
    Questions, remarks to: <a href="mailto:punctum@punctum.com">Dr. Georg Fischer</a>
    </font>
    </p>
    
</body>
</html>
