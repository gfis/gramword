#!/usr/bin/perl

#
#  Copyright 2006 Dr. Georg Fischer <punctum at punctum dot kom>
# 
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
# 
#       http://www.apache.org/licenses/LICENSE-2.0
# 
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#
# caution, this file uses UTF-8 encoding: äöüÄÖÜß
#
# @(#) $Id: bwv4_sorted.pl 36 2008-09-08 06:05:06Z gfis $
# Evaluate sortedcantatas.html (c.f. DATA below)  - bw4.nn
# from http://www.classical.net/music/comp.lst/works/bachjs/cantatas/106.html
# Convert the entries to morphem dictionary format 
# (entry, morph, enrel, morel)
# 2007-03-07, Dr. Georg Fischer <punctum@punctum.com>
# generate raw INSERT values for 'infos' table 
# activation:
#   perl bwv4_sorted.pl > bw44_sorted.dic
#
# For each input line, the following rows for table INFOS
# (with dict columns ENTRY, MORPH, ENREL, MOREL) are generated:
# $entry#datum#$datum#bwv4
#--------------------------------------------------------------------------
use strict;
use utf8;
    binmode(STDOUT, ":utf8");

    my %monab = 
        ( '?', '??' 
        , 'Jan', '01'
        , 'Feb', '02'
        , 'Mar', '03'
        , 'Apr', '04'
        , 'May', '05'
        , 'Jun', '06'
        , 'Jul', '07'
        , 'Aug', '08'
        , 'Sep', '09'
        , 'Oct', '10'
        , 'Nov', '11'
        , 'Dec', '12'
        );
    my $bwv_no  = "";
    my $year    = "1785";
    my $title   = ""; 
    my $holyd   = ""; # code for Sunday/Holyday
    my ($year, $mon, $day);
    while (<DATA>) {
        s/\r?\n//; # chompr
        if (m/\A\<p\>\<strong\>(\d+)\<\/strong\>/) {
            $year = $1;
        }
        if (m/\/bachjs\/cantatas\/([^\.]+)\./) {
            my $bwv_no = $1 + 0;
            m/\A([^\-]+)\-/;
            my $date = $1;
            $date =~ s/\s+\Z//;
            $mon = "?";
            $day = "?";
            ($mon, $day) = split(/\s+/, $date);
            $mon = $monab{$mon};
            my $datum = sprintf("%04d-%02d-%02d", $year, $mon, $day);
            #                    012345
            substr($datum, 5) =~ s/00/\?\?/g;
            my $entry = "bwv.$bwv_no";
            print <<"GFis";
$entry#datum#$datum#bwv4
GFis
        }
    } # while DATA
__DATA__
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html><head>



<meta http-equiv="Content-Type" content="text/html; charset=windows-1252"><title>Classical Net - Bach Cantatas - Chronological Listing</title>

<link rel="SHORTCUT ICON" href="http://www.classical.net/favicon.ico" hreflang="en" lang="en">
<link href="sortedcantatas-Dateien/n2CoreLibs-n2v1-57871.css" type="text/css" rel="stylesheet"></head><body alink="#ff0000" background="sortedcantatas-Dateien/parch.jpg" bgcolor="#f8f8ff" link="#0000ff" vlink="#800080"><div><div id="goPopElem" class="n2Pop" style="display: block; visibility: hidden; left: 0px; top: 0px; position: absolute;" onmouseover="goPop.mouseOver();" onmouseout="goPop.mouseOut(event);" onmousemove="goPop.mouseMove(event);" onmousedown="goPop._click(event);"><div class="n2"><div id="goPopElem_titleBar" class="popStaticTitle" style="visibility: inherit; min-height: 18px; height: 25px;"><div style="padding: 3px 4px 0pt 0pt; float: right; background-color: rgb(239, 237, 212);" id="goPopElem_titleBarTd2"><span class="clickable" onclick="goPop.goBack()"><img style="display: none;" id="goPopElem_backBtn" class="clickable" src="sortedcantatas-Dateien/back-tan-sm.gif" onmousedown="this.src='http://g-images.amazon.com/images/G/01/nav2/images/back-tan-sm-dn';" onmouseup="this.src='http://g-images.amazon.com/images/G/01/nav2/images/back-tan-sm.gif';" border="0" height="16" width="46"></span><img style="display: none;" id="goPopElem_backBtnDis" class="clickable" src="sortedcantatas-Dateien/back-tan-sm-dis.gif" border="0" height="16" width="46"><span class="clickable" onclick="goPop.goForward()"><img style="display: none;" id="goPopElem_nextBtn" class="clickable" src="sortedcantatas-Dateien/next-tan-sm.gif" onmousedown="this.src='http://g-images.amazon.com/images/G/01/nav2/images/next-tan-sm-dn';" onmouseup="this.src='http://g-images.amazon.com/images/G/01/nav2/images/next-tan-sm.gif';" border="0" height="16" width="46"></span><img style="display: none;" id="goPopElem_nextBtnDis" class="clickable" src="sortedcantatas-Dateien/next-tan-sm-dis.gif" border="0" height="16" width="46"><span class="clickable" onclick="goPop.hide()"><img id="goPopElem_closeX" class="clickable" src="sortedcantatas-Dateien/close-tan-sm.gif" onmousedown="this.src='http://g-images.amazon.com/images/G/01/nav2/images/close-tan-sm-dn';" onmouseup="this.src='http://g-images.amazon.com/images/G/01/nav2/images/close-tan-sm.gif';" border="0" height="16" width="46"></span></div><span style="display: block; padding-left: 4px; padding-top: 6px; background-color: rgb(239, 237, 212);" id="goPopElem_titleBarTitle" class="popTitle"></span></div><div id="goPopElem_main" class="n2PopBody" style="border: 5px solid rgb(239, 237, 212); clear: both;">--CONTENT GOES HERE (static)--</div></div></div></div><a style="z-index: 225; display: none; position: absolute; background-color: transparent;" id="n2SPopClickGrab"></a><div><div id="goN2ExplorerDiv" class="n2Pop" style="display: block; visibility: hidden; left: 0px; top: 0px; position: absolute;" onmouseover="goN2Explorer.mouseOver();" onmouseout="goN2Explorer.mouseOut(event);" onmousemove="goN2Explorer.mouseMove(event);" onmousedown="goN2Explorer._click(event);"><div class="n2"><div id="goN2ExplorerDiv_titleBar" class="popStaticTitle" style="visibility: inherit; min-height: 18px;"><div style="padding: 3px 4px 0pt 0pt; float: right;" id="goN2ExplorerDiv_titleBarTd2"><span class="clickable" onclick="goN2Explorer.goBack()"><img style="display: none;" id="goN2ExplorerDiv_backBtn" class="clickable" src="sortedcantatas-Dateien/back-tan-sm.gif" onmousedown="this.src='http://g-images.amazon.com/images/G/01/nav2/images/back-tan-sm-dn';" onmouseup="this.src='http://g-images.amazon.com/images/G/01/nav2/images/back-tan-sm.gif';" border="0" height="16" width="46"></span><img style="display: none;" id="goN2ExplorerDiv_backBtnDis" class="clickable" src="sortedcantatas-Dateien/back-tan-sm-dis.gif" border="0" height="16" width="46"><span class="clickable" onclick="goN2Explorer.goForward()"><img style="display: none;" id="goN2ExplorerDiv_nextBtn" class="clickable" src="sortedcantatas-Dateien/next-tan-sm.gif" onmousedown="this.src='http://g-images.amazon.com/images/G/01/nav2/images/next-tan-sm-dn';" onmouseup="this.src='http://g-images.amazon.com/images/G/01/nav2/images/next-tan-sm.gif';" border="0" height="16" width="46"></span><img style="display: none;" id="goN2ExplorerDiv_nextBtnDis" class="clickable" src="sortedcantatas-Dateien/next-tan-sm-dis.gif" border="0" height="16" width="46"><span class="clickable" onclick="goN2Explorer.hide()"><img id="goN2ExplorerDiv_closeX" class="clickable" src="sortedcantatas-Dateien/close-tan-sm.gif" onmousedown="this.src='http://g-images.amazon.com/images/G/01/nav2/images/close-tan-sm-dn';" onmouseup="this.src='http://g-images.amazon.com/images/G/01/nav2/images/close-tan-sm.gif';" border="0" height="16" width="46"></span></div><span id="goN2ExplorerDiv_titleBarTitle" class="popTitle"></span></div><div id="goN2ExplorerDiv_main" class="n2PopBody" style="clear: both;">--CONTENT GOES HERE (static)--</div></div></div></div>
<blockquote>

<hr align="center" size="5" width="80%">

<h2 align="center">Bach Cantatas<br>Chronological Listing</h2>

<hr align="center" size="3" width="40%">

<p><strong><em>Back to the <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas.html">Introduction</a></em></strong></p>

<blockquote>
<p><strong>1707</strong><br>
</p><blockquote>
<p>
Jan ? - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/004.html">Cantata #4</a><br>
? - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/106.html">Cantata #106</a><br>
? - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/131.html">Cantata #131</a><br>
? - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/196.html">Cantata #196</a><br>
</p>
</blockquote>

<p><strong>1708</strong><br>
</p><blockquote>
<p>
? - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/071.html">Cantata #71</a><br>
? - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/150.html">Cantata #150</a><br>
</p>
</blockquote>

<p><strong>1713</strong><br>
</p><blockquote>
<p>
Jan ? - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/018.html">Cantata #18</a><br>
</p>
</blockquote>

<p><strong>1714</strong><br>
</p><blockquote>
<p>
Jan ? - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/054.html">Cantata #54</a><br>
Apr 22 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/012.html">Cantata #12</a><br>
May 20 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/172.html">Cantata #172</a><br>
May 25 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/182.html">Cantata #182</a><br>
Jun 17 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/021.html">Cantata #21</a><br>
Aug 12 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/199.html">Cantata #199</a><br>
Dec 30 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/152.html">Cantata #152</a><br>
Dec ? - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/061.html">Cantata #61</a><br>
</p>
</blockquote>

<p><strong>1715</strong><br>
</p><blockquote>
<p>
Jan ? - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/031.html">Cantata #31</a><br>
Jan ? - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/063.html">Cantata #63</a><br>
May ? - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/165.html">Cantata #165</a><br>
Jun ? - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/185.html">Cantata #185</a><br>
Oct 6 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/161.html">Cantata #161</a><br>
Nov 3 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/162.html">Cantata #162</a><br>
Nov 24 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/163.html">Cantata #163</a><br>
Dec 22 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/132.html">Cantata #132</a><br>
</p>
</blockquote>

<p><strong>1716</strong><br>
</p><blockquote>
<p>
Jan 19 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/155.html">Cantata #155</a><br>
</p>
</blockquote>

<p><strong>1723</strong><br>
</p><blockquote>
<p>
Feb 7 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/022.html">Cantata #22</a><br>
Feb 7 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/023.html">Cantata #23</a><br>
Apr ? - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/158.html">Cantata #158</a><br>
May 30 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/075.html">Cantata #75</a><br>
Jun 6 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/076.html">Cantata #76</a><br>
Jun 20 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/024.html">Cantata #24</a><br>
Jun 24 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/167.html">Cantata #167</a><br>
Jul 2 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/147.html">Cantata #147</a><br>
Jul 11 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/186.html">Cantata #186</a><br>
Jul 18 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/136.html">Cantata #136</a><br>
Jul 25 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/105.html">Cantata #105</a><br>
Aug 1 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/046.html">Cantata #46</a><br>
Aug 8 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/179.html">Cantata #179</a><br>
Aug 15 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/069.html">Cantata #69</a><br>
Aug 22 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/077.html">Cantata #77</a><br>
Aug 29 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/025.html">Cantata #25</a><br>
Aug 30 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/119.html">Cantata #119</a><br>
Sep 5 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/138.html">Cantata #138</a><br>
Sep 12 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/095.html">Cantata #95</a><br>
Sep 19 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/148.html">Cantata #148</a><br>
Oct 3 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/048.html">Cantata #48</a><br>
Oct 17 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/109.html">Cantata #109</a><br>
Oct 24 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/089.html">Cantata #89</a><br>
Oct 31 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/080.html">Cantata #80</a><br>
Nov 2 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/194.html">Cantata #194</a><br>
Nov 7 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/060.html">Cantata #60</a><br>
Nov 14 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/090.html">Cantata #90</a><br>
Nov 21 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/070.html">Cantata #70</a><br>
Dec 26 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/040.html">Cantata #40</a><br>
Dec 27 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/064.html">Cantata #64</a><br>
</p>
</blockquote>

<p><strong>1724</strong><br>
</p><blockquote>
<p>
Jan 1 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/190.html">Cantata #190</a><br>
Jan 2 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/153.html">Cantata #153</a><br>
Jan 6 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/065.html">Cantata #65</a><br>
Jan 9 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/154.html">Cantata #154</a><br>
Jan 23 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/073.html">Cantata #73</a><br>
Jan 30 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/081.html">Cantata #81</a><br>
Feb 2 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/083.html">Cantata #83</a><br>
Feb 6 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/144.html">Cantata #144</a><br>
Feb 13 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/181.html">Cantata #181</a><br>
Apr 10 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/066.html">Cantata #66</a><br>
Apr 11 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/134.html">Cantata #134</a><br>
Apr 16 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/067.html">Cantata #67</a><br>
Apr 23 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/104.html">Cantata #104</a><br>
May 7 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/166.html">Cantata #166</a><br>
May 14 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/086.html">Cantata #86</a><br>
May 18 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/037.html">Cantata #37</a><br>
May 21 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/044.html">Cantata #44</a><br>
May 28 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/059.html">Cantata #59</a><br>
May 29 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/173.html">Cantata #173</a><br>
May 30 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/184.html">Cantata #184</a><br>
Jun 11 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/020.html">Cantata #20</a><br>
Jun 18 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/002.html">Cantata #2</a><br>
Jun 24 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/007.html">Cantata #7</a><br>
Jun 25 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/135.html">Cantata #135</a><br>
Jul 2 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/010.html">Cantata #10</a><br>
Jul 9 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/093.html">Cantata #93</a><br>
Jul 23 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/107.html">Cantata #107</a><br>
Jul 30 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/178.html">Cantata #178</a><br>
Aug 6 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/094.html">Cantata #94</a><br>
Aug 13 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/101.html">Cantata #101</a><br>
Aug 20 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/113.html">Cantata #113</a><br>
Sep 3 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/033.html">Cantata #33</a><br>
Sep 10 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/078.html">Cantata #78</a><br>
Sep 17 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/099.html">Cantata #99</a><br>
Sep 24 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/008.html">Cantata #8</a><br>
Sep 29 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/130.html">Cantata #130</a><br>
Oct 1 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/114.html">Cantata #114</a><br>
Oct 8 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/096.html">Cantata #96</a><br>
Oct 15 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/005.html">Cantata #5</a><br>
Oct 22 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/180.html">Cantata #180</a><br>
Oct 29 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/038.html">Cantata #38</a><br>
Nov 5 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/115.html">Cantata #115</a><br>
Nov 12 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/139.html">Cantata #139</a><br>
Nov 19 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/026.html">Cantata #26</a><br>
Nov 26 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/116.html">Cantata #116</a><br>
Dec 3 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/062.html">Cantata #62</a><br>
Dec 25 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/091.html">Cantata #91</a><br>
Dec 26 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/121.html">Cantata #121</a><br>
Dec 27 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/133.html">Cantata #133</a><br>
Dec 31 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/122.html">Cantata #122</a><br>
</p>
</blockquote>

<p><strong>1725</strong><br>
</p><blockquote>
<p>
Jan 1 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/041.html">Cantata #41</a><br>
Jan 6 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/123.html">Cantata #123</a><br>
Jan 7 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/124.html">Cantata #124</a><br>
Jan 14 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/003.html">Cantata #3</a><br>
Jan 21 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/111.html">Cantata #111</a><br>
Jan 28 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/092.html">Cantata #92</a><br>
Feb 2 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/125.html">Cantata #125</a><br>
Feb 4 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/126.html">Cantata #126</a><br>
Feb 11 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/127.html">Cantata #127</a><br>
Mar 25 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/001.html">Cantata #1</a><br>
Apr 2 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/006.html">Cantata #6</a><br>
Apr 8 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/042.html">Cantata #42</a><br>
Apr 15 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/085.html">Cantata #85</a><br>
Apr 22 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/103.html">Cantata #103</a><br>
Apr 29 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/108.html">Cantata #108</a><br>
May 6 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/087.html">Cantata #87</a><br>
May 10 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/128.html">Cantata #128</a><br>
May 13 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/183.html">Cantata #183</a><br>
May 20 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/074.html">Cantata #74</a><br>
May 21 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/068.html">Cantata #68</a><br>
May 22 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/175.html">Cantata #175</a><br>
May 27 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/176.html">Cantata #176</a><br>
Jul 29 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/168.html">Cantata #168</a><br>
Aug 19 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/137.html">Cantata #137</a><br>
Aug 26 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/164.html">Cantata #164</a><br>
Sep 8 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/035.html">Cantata #35</a><br>
Oct 31 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/079.html">Cantata #79</a><br>
Dec 25 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/110.html">Cantata #110</a><br>
Dec 26 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/057.html">Cantata #57</a><br>
Dec 27 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/151.html">Cantata #151</a><br>
Dec 30 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/028.html">Cantata #28</a><br>
</p>
</blockquote>

<p><strong>1726</strong><br>
</p><blockquote>
<p>
Jan 1 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/016.html">Cantata #16</a><br>
Jan 13 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/032.html">Cantata #32</a><br>
Jan 20 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/013.html">Cantata #13</a><br>
Jan 27 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/072.html">Cantata #72</a><br>
Mar 6 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/034.html">Cantata #34</a><br>
May 30 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/043.html">Cantata #43</a><br>
Jun 16 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/129.html">Cantata #129</a><br>
Jun 23 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/039.html">Cantata #39</a><br>
Jul 21 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/088.html">Cantata #88</a><br>
Jul 28 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/170.html">Cantata #170</a><br>
Aug 4 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/187.html">Cantata #187</a><br>
Aug 11 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/045.html">Cantata #45</a><br>
Aug 25 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/102.html">Cantata #102</a><br>
Sep 22 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/017.html">Cantata #17</a><br>
Sep 29 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/019.html">Cantata #19</a><br>
Oct 6 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/027.html">Cantata #27</a><br>
Oct 13 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/047.html">Cantata #47</a><br>
Oct 20 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/169.html">Cantata #169</a><br>
Oct 27 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/056.html">Cantata #56</a><br>
Nov 3 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/049.html">Cantata #49</a><br>
Nov 10 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/098.html">Cantata #98</a><br>
Nov 17 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/055.html">Cantata #55</a><br>
Nov 24 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/052.html">Cantata #52</a><br>
</p>
</blockquote>

<p><strong>1727</strong><br>
</p><blockquote>
<p>
Jan 5 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/058.html">Cantata #58</a><br>
Feb 2 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/082.html">Cantata #82</a><br>
Feb 9 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/084.html">Cantata #84</a><br>
Aug 25 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/193.html">Cantata #193</a><br>
Oct 17 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/198.html">Cantata #198</a><br>
</p>
</blockquote>

<p><strong>1728</strong><br>
</p><blockquote>
<p>
Feb 2 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/157.html">Cantata #157</a><br>
Apr 18 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/146.html">Cantata #146</a><br>
Sep 29 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/149.html">Cantata #149</a><br>
Oct ? - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/188.html">Cantata #188</a><br>
? - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/117.html">Cantata #117</a><br>
</p>
</blockquote>

<p><strong>1729</strong><br>
</p><blockquote>
<p>
Jan 1 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/171.html">Cantata #171</a><br>
Jan 23 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/156.html">Cantata #156</a><br>
Feb 27 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/159.html">Cantata #159</a><br>
Apr ? - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/145.html">Cantata #145</a><br>
Jun 6 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/174.html">Cantata #174</a><br>
Sep 29 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/120.html">Cantata #120</a><br>
</p>
</blockquote>

<p><strong>1730</strong><br>
</p><blockquote>
<p>
Sep 17 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/051.html">Cantata #51</a><br>
? - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/192.html">Cantata #192</a><br>
</p>
</blockquote>

<p><strong>1731</strong><br>
</p><blockquote>
<p>
Apr 8 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/112.html">Cantata #112</a><br>
Aug 27 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/029.html">Cantata #29</a><br>
Nov 25 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/140.html">Cantata #140</a><br>
Dec 2 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/036.html">Cantata #36</a><br>
</p>
</blockquote>

<p><strong>1732</strong><br>
</p><blockquote>
<p>
Jul 6 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/177.html">Cantata #177</a><br>
Jul ? - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/009.html">Cantata #9</a><br>
? - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/100.html">Cantata #100</a><br>
</p>
</blockquote>

<p><strong>1734</strong><br>
</p><blockquote>
<p>
? - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/097.html">Cantata #97</a><br>
</p>
</blockquote>

<p><strong>1735</strong><br>
</p><blockquote>
<p>
Jan 30 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/014.html">Cantata #14</a><br>
May 19 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/011.html">Cantata #11</a><br>
</p>
</blockquote>

<p><strong>1736</strong><br>
</p><blockquote>
<p>
? - <!-- <a href="cantatas/118.html"> -->Cantata #118<!-- </a> --><br>
</p>
</blockquote>

<p><strong>1737</strong><br>
</p><blockquote>
<p>
? - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/195.html">Cantata #195</a><br>
</p>
</blockquote>

<p><strong>1738</strong><br>
</p><blockquote>
<p>
Jun 24 - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/030.html">Cantata #30</a><br>
</p>
</blockquote>

<p><strong>1739</strong><br>
</p><blockquote>
<p>
? - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/197.html">Cantata #197</a><br>
</p>
</blockquote>

<p><strong>1740</strong><br>
</p><blockquote>
<p>
? - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/191.html">Cantata #191</a><br>
</p>
</blockquote>

<p><strong>1742</strong><br>
</p><blockquote>
<p>
? - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/069.html">Cantata #69</a><br>
? - <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas/050.html">Cantata #50</a><br>
</p>
</blockquote>
</blockquote>

<hr align="center" size="3" width="40%">

<p align="center"><em><strong>Back to the <a href="http://www.classical.net/music/comp.lst/works/bachjs/cantatas.html">Listener's Guide Introduction</a>,<br>
or the <a href="http://www.classical.net/music/comp.lst/bachjs.html"><img src="sortedcantatas-Dateien/classnet.gif" align="middle" border="0"> Bach Page.</a></strong></em></p>

<hr align="center" size="5" width="80%">

</blockquote>
<center>

<p><a href="http://www.classical.net/music/astore.html"><img src="sortedcantatas-Dateien/shop.jpg" alt="Shop Classical Net!" border="0"></a></p>

<a href="http://www.classical.net/search/search.pl">[ Search Engine ]</a><br><br>
<strong>
Back to the <a href="http://www.classical.net/music/welcome.html"><img alt="Classical Net" src="sortedcantatas-Dateien/classnet.gif" align="middle" border="0"> Home Page</a>.<br><br>
<a href="http://www.classical.net/donation/donate.html"><img src="sortedcantatas-Dateien/donate.gif" alt="Make a donation to the Classical Net web site" align="middle" border="0" height="23" width="110"></a><br><br>
</strong><table align="center" border="0" cellpadding="2">
<tbody><tr>
<td>
<a href="http://www.musicnotes.com/sheetmusic/ard.asp?SID=171&amp;LID=16"><img src="sortedcantatas-Dateien/classicalmn.gif" alt="Classical Sheet Music" border="0" height="125" width="125"></a>
</td>
<td>

<script type="text/javascript"><!--
google_ad_client = "pub-5800070782447506";
google_ad_width = 550;
google_ad_height = 90;
google_ad_format = "728x90_as";
google_ad_type = "text_image";
google_ad_channel ="";
google_color_border = "000000";
google_color_bg = "008000";
google_color_link = "FFFFFF";
google_color_text = "FFFFFF";
google_color_url = "FFFFFF";
//--></script>
<script type="text/javascript" src="sortedcantatas-Dateien/show_ads.js"></script><iframe name="google_ads_frame" src="sortedcantatas-Dateien/ads.htm" marginwidth="0" marginheight="0" vspace="0" hspace="0" allowtransparency="true" frameborder="0" height="90" scrolling="no" width="550"></iframe>
</td>
<td>
<a href="http://www.sheetmusicplus.com/a/featured.html?id=33170" target="smp"><img src="sortedcantatas-Dateien/smp_monthpromo_sb.gif" alt="Sheet Music Plus Featured Sale"></a>
</td>
</tr>
</tbody></table>
</center>

<hr align="center" size="3" width="40%">

<p align="center"><strong><em><font size="-1">Unless explicitly specified otherwise, this page and all other pages at this site are Copyright © 1995-2007 by <a href="http://www.classical.net/music/contacts.html">Classical Net</a>.
Use of text, images, layout, format, look, or feel of these pages,
without the written permission of the copyright holder, except as
specified in the <a href="http://www.classical.net/copyright.html">Copyright Notice</a>, is strictly prohibited. All Rights Reserved.</font></em></strong></p>

<p align="center"><font color="#efdecf" size="-5">Site designed and maintained by<br><em><a href="http://www.webdesignassociates.com/">Web Design Associates</a></em></font></p>

<script type="text/javascript" src="sortedcantatas-Dateien/link-enhancer"></script><script type="text/javascript" src="sortedcantatas-Dateien/po.html"></script>
<script src="sortedcantatas-Dateien/n2CoreLibs-utilities-25439.js" type="text/javascript"></script>
<script src="sortedcantatas-Dateien/n2CoreLibs-events-18500.js" type="text/javascript"></script>
<script src="sortedcantatas-Dateien/n2CoreLibs-simplePopover-41389.js" type="text/javascript"></script>
<script src="sortedcantatas-Dateien/n2CoreLibs-staticPopover-24266.js" type="text/javascript"></script>
<script src="sortedcantatas-Dateien/n2CoreLibs-popoverPane-48224.js" type="text/javascript"></script>
<script src="sortedcantatas-Dateien/n2CoreLibs-dynUpdate-55682.js" type="text/javascript"></script>
<script src="sortedcantatas-Dateien/n2CoreLibs-multiPanePopover-38509.js" type="text/javascript"></script>
<script src="sortedcantatas-Dateien/n2CoreLibs-panes-46714.js" type="text/javascript"></script>
<script src="sortedcantatas-Dateien/n2CoreLibs-explorer-38421.js" type="text/javascript"></script>

<noscript><img src="http://www.assoc-amazon.com/s/noscript?tag=classicalnet" /></noscript>

<script type="text/javascript" src="sortedcantatas-Dateien/impression-counter"></script>
<noscript><img src="http://www.assoc-amazon.com/s/noscript?tag=classicalnet" alt="" /></noscript>

<div class="animatedBox" id="goN2UAnimatedBox"></div></body></html>
