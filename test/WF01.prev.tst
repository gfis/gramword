<?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="application/xhtml+xml;charset=UTF-8" />
<meta name="robots" content="noindex, nofollow" />
<link rel="stylesheet" title="common" type="text/css" href="stylesheet.css" />
<title>gramword Main Page</title>
    <script src="script.js" type="text/javascript">
    </script>
</head>
<body>
<!--lang="en", enc="UTF-8", filter="simple", format="html", grammar="de", infile="", strat="all"-->
    <h2>GramWord</h2>
    <p><strong>GramWord</strong> is a Java package which uses a relational
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
<form action="servlet" method="POST" enctype="multipart/form-data">
    <input type = "hidden" name="view" value="index2" />
    <table cellpadding="4" border="0">
        <tr valign="top">
           <td colspan="5"><strong>Source file to be uploaded: </strong>               <input name="infile" type="file" style="font-family: Courier, monospace"                        maxsize="256" size="80" value="" />
           </td>
        </tr>
        <tr valign="top">
            <td><strong>Source<br />Encoding</strong><br />
                <select name="enc" size="2">
                    <option value="ISO-8859-1">ISO-8859-1</option>
                    <option value="UTF-8" selected>UTF-8</option>
                </select>
            </td>
            <td><strong>Target<br />Format</strong><br />
                <select name="format" size="3">
                    <option value="html" selected>HTML</option>
                    <option value="text">Text</option>
                    <option value="dict">Dictionary</option>
                </select>
            </td>
            <td><strong>Filter<br />to be used</strong><br />
                <select name="filter" size="5">
                    <option value="queue">queue</option>
                    <option value="bibleref">bibleref</option>
                    <option value="konto">konto</option>
                    <option value="number">number</option>
                    <option value="wordtype">wordtype</option>
                </select>
            </td>
            <td><strong>Source<br />Grammar</strong><br />
                <select name="grammar" size="1">
                    <option value="de">Deutsch</option>
                </select>
            </td>
            <td><strong>Strategy</strong><br />
                <select name="strat" size="3">
                    <option value="all" selected>all</option>
                    <option value="prsplit">prsplit</option>
                    <option value="sasplit">sasplit</option>
                </select>
            </td>
            <td><input type="submit" value="Submit" /></td>
        </tr>
    </table>
</form>
<a title="longex"    href="quixote1-4.html">Longer Example</a> (Chapters 1 - 4 from "Don Quijote")<br />
<a title="wiki"        href="http://www.teherba.org/index.php/GramWord" target="_new">Wiki</a> Documentation<br />
<a title="github"      href="https://github.com/gfis/gramword" target="_new">Git Repository</a><br />
<a title="api"         href="docs/api/index.html">Java API</a> Documentation<br />
<a title="manifest"    href="servlet?view=manifest">Manifest</a><br />
<a title="license"     href="servlet?view=license">License</a><br />
<a title="notice"      href="servlet?view=notice">References</a><br />
<h4>Applications of <em>QueueTransformer</em></h4>
<table border="0">
    <tr><td>bibleref:</td><td>Table of Luther's pericopes - <a href="bibleref/luther_perikope.htm">(original)</a> and with
        <a href="bibleref/luther_perikope.html">autolinked</a> bible references</td></tr>
    <tr><td>&nbsp;</td><td><a href="bibleref/wiki_perikope.htm">Table of pericopes</a> from de.wikipedia -
        <a href="bibleref/wiki_perikope.html">autolinked</a></td></tr>
    <tr><td>konto:</td><td>Autolinked German bank ids with <a href="konto.html">check/correction</a>
        of account numbers nearby</td></tr>
    <tr><td>number:</td><td>Parsing of German number words in <a href="number.html">Genesis 5</a></td></tr>
    <tr><td>wordtype:</td><td>Don Quixote <a href="wordtype/quixote0.html">(original)</a>, with
        <a href="queue.html">green</a> uppercase words, and with <a href="wordtype.html">colored word types</a>.</td></tr>
</table>
<!-- language="en", features="quest" -->
<p><span style="font-size:small">
Questions, remarks: email to  <a href="mailto:punctum@punctum.com?&subject=gramword">Dr. Georg Fischer</a></span></p>
</body></html>
