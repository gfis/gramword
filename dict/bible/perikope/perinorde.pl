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
# convert tab separated perikopes from nordelbien.de to XML
# 2007-02-07, Dr. Georg Fischer <punctum@punctum.com>: Dorothea = 97

use strict;

    print <<"GFis";
<?xml version="1.0" encoding="ISO-8859-1"?>
<html><head>
</head>
<body>
<table>
GFis
    my ($key, $text, $votum, $psalm);
    while (<DATA>) {
        s/\r?\n//; # chompr
        if (0) {
            s/ä/\&auml;/g;
            s/ö/\&ouml;/g;
            s/ü/\&uuml;/g;
            s/ß/\&szlig;/g;
        }

        if (0) {
        } elsif (length($_) <= 10) {
            $key = sprintf("%-8s", $_);
        } elsif (1) {
            my ($text, $no, $bgcolor, $color, $link) = split(/\t/);
            print <<"GFis";
<tr><td>$key</td><td>$no</td><td>$text</td><td bgcolor=\"$bgcolor\">$color</td><td>$link</td></tr>
GFis
        }
    } # while DATA
    print <<"GFis";
</table>
</body></html>
GFis

__DATA__
adv1
1. Advent   1   #ff00aa violett <a href="http://bibel-online.net/buch/40.matthaeus/21.html#21,1">Mt 21,1-9</a>
1. Advent   2   #ff00aa violett <a href="http://bibel-online.net/buch/45.roemer/13.html#13,8">Röm 13,8-12(14)</a>
1. Advent   3   #ff00aa violett <a href="http://bibel-online.net/buch/24.jeremia/23.html#23,5">Jer 23,5-8</a>
1. Advent   4   #ff00aa violett <a href="http://bibel-online.net/buch/66.offenbarung/5.html#5,1">Offb 5,1-5(14)</a>
1. Advent   5   #ff00aa violett <a href="http://bibel-online.net/buch/42.lukas/1.html#1,67">Lk 1,67-79</a>
1. Advent   6   #ff00aa violett <a href="http://bibel-online.net/buch/58.hebraeer/10.html#10,19">Hebr 10,19-25</a>
xmas1
1. So. n. Christfest    1   #ffffff weiß    <a href="http://bibel-online.net/buch/42.lukas/2.html#2,11">Lk 2,(11)25-38(40)</a>
1. So. n. Christfest    2   #ffffff weiß    <a href="http://bibel-online.net/buch/62.1-johannes/1.html#1,1">1 Joh 1,1-4</a>
1. So. n. Christfest    3   #ffffff weiß    <a href="http://bibel-online.net/buch/40.matthaeus/2.html#2,13">Mt 2,13-18(23)</a>
1. So. n. Christfest    4   #ffffff weiß    <a href="http://bibel-online.net/buch/62.1-johannes/2.html#2,21">1 JOh 2,21-25</a>
1. So. n. Christfest    5   #ffffff weiß    <a href="http://bibel-online.net/buch/43.johannes/12.html#12,44">Joh 12,44-50</a>
1. So. n. Christfest    6   #ffffff weiß    <a href="http://bibel-online.net/buch/23.jesaja/49.html#49,13">Jes 49,13-16</a>
trin1
1. So. n. Trinitatis    1   #00ff00 grün    <a href="http://bibel-online.net/buch/42.lukas/16.html#16,19">Lk 16,19-31</a>
1. So. n. Trinitatis    2   #00ff00 grün    <a href="http://bibel-online.net/buch/62.1-johannes/4.html#4,16">1 Joh 4,16b-21</a>
1. So. n. Trinitatis    3   #00ff00 grün    <a href="http://bibel-online.net/buch/43.johannes/5.html#5,39">Joh 5,39-47</a>
1. So. n. Trinitatis    4   #00ff00 grün    <a href="http://bibel-online.net/buch/24.jeremia/23.html#23,16">Jer 23,16-29</a>
1. So. n. Trinitatis    5   #00ff00 grün    <a href="http://bibel-online.net/buch/40.matthaeus/9.html#9,35">Mt 9,35-10,1(4)(7)</a>
1. So. n. Trinitatis    6   #00ff00 grün    <a href="http://bibel-online.net/buch/05.5-mose/6.html#6,4">5 Mose 6,4-9</a>
epi1
1. So. nach Epiphanias  1   #00ff00 grün    <a href="http://bibel-online.net/buch/40.matthaeus/3.html#3,13">Mt 3,13-17</a>
1. So. nach Epiphanias  2   #00ff00 grün    <a href="http://bibel-online.net/buch/45.roemer/12.html#12,1">Röm 12,1-3(8)</a>
1. So. nach Epiphanias  3   #00ff00 grün    <a href="http://bibel-online.net/buch/40.matthaeus/4.html#4,12">Mt 4,12-17</a>
1. So. nach Epiphanias  4   #00ff00 grün    <a href="http://bibel-online.net/buch/46.1-korinther/1.html#1,26">1 Kor 1,26-31</a>
1. So. nach Epiphanias  5   #00ff00 grün    <a href="http://bibel-online.net/buch/43.johannes/1.html#1,29">Joh 1,29-34</a>
1. So. nach Epiphanias  6   #00ff00 grün    <a href="http://bibel-online.net/buch/23.jesaja/42.html#42,1">Jes 42,1-4(9)</a>
trin10
10. So. n. Trinitatis   1   #00ff00 grün    <a href="http://bibel-online.net/buch/42.lukas/19.html#19,41">Lk 19,41-48</a>
10. So. n. Trinitatis   2   #00ff00 grün    <a href="http://bibel-online.net/buch/45.roemer/9.html#9,1">Röm 9,1-8.14-16</a>
10. So. n. Trinitatis   3   #00ff00 grün    <a href="http://bibel-online.net/buch/02.2-mose/19.html#19,1">2 Mose 19,1-6</a>
10. So. n. Trinitatis   4   #00ff00 grün    <a href="http://bibel-online.net/buch/23.jesaja/62.html#62,6">Jes 62,6-12</a>
10. So. n. Trinitatis   5   #00ff00 grün    <a href="http://bibel-online.net/buch/43.johannes/4.html#4,19">Joh 4,19-26</a>
10. So. n. Trinitatis   6   #00ff00 grün    <a href="http://bibel-online.net/buch/45.roemer/11.html#11,25">Röm 11,25-32</a>
trin11
11. So. n. Trinitatis   1   #00ff00 grün    <a href="http://bibel-online.net/buch/42.lukas/18.html#18,9">Lk 18,9-14</a>
11. So. n. Trinitatis   2   #00ff00 grün    <a href="http://bibel-online.net/buch/49.epheser/2.html#2,4">Eph 2,4-10</a>
11. So. n. Trinitatis   3   #00ff00 grün    <a href="http://bibel-online.net/buch/40.matthaeus/21.html#21,28">Mt 21,28-32</a>
11. So. n. Trinitatis   4   #00ff00 grün    <a href="http://bibel-online.net/buch/48.galater/2.html#2,16">Gal 2,16-21</a>
11. So. n. Trinitatis   5   #00ff00 grün    <a href="http://bibel-online.net/buch/42.lukas/7.html#7,36">Lk 7,36-50</a>
11. So. n. Trinitatis   6   #00ff00 grün    <a href="http://bibel-online.net/buch/10.2-samuel/12.html#12,1">2 Sam 12,1-10.13-15a</a>
trin12
12. So. n. Trinitatis   1   #00ff00 grün    <a href="http://bibel-online.net/buch/41.markus/7.html#7,31">Mk 7,31-37</a>
12. So. n. Trinitatis   2   #00ff00 grün    <a href="http://bibel-online.net/buch/44.apostel/9.html#9,1">Apg 9,1-20</a>
12. So. n. Trinitatis   3   #00ff00 grün    <a href="http://bibel-online.net/buch/23.jesaja/29.html#29,17">Jes 29,17-24</a>
12. So. n. Trinitatis   4   #00ff00 grün    <a href="http://bibel-online.net/buch/44.apostel/3.html#3,1">Apg 3,1-10(21)</a>
12. So. n. Trinitatis   5   #00ff00 grün    <a href="http://bibel-online.net/buch/41.markus/8.html#8,22">Mk 8,22-26</a>
12. So. n. Trinitatis   6   #00ff00 grün    <a href="http://bibel-online.net/buch/46.1-korinther/3.html#3,9">1 Kor 3,9-15</a>
trin13
13. So. n. Trinitatis   1   #00ff00 grün    <a href="http://bibel-online.net/buch/42.lukas/10.html#10,25">Lk 10,25-37</a>
13. So. n. Trinitatis   2   #00ff00 grün    <a href="http://bibel-online.net/buch/62.1-johannes/4.html#4,7">1 Joh 4,7-12(16)</a>
13. So. n. Trinitatis   3   #00ff00 grün    <a href="http://bibel-online.net/buch/41.markus/3.html#3,31">Mk 3,31-35</a>
13. So. n. Trinitatis   4   #00ff00 grün    <a href="http://bibel-online.net/buch/01.1-mose/4.html#4,1">1 Mose 4,1-16a</a>
13. So. n. Trinitatis   5   #00ff00 grün    <a href="http://bibel-online.net/buch/40.matthaeus/6.html#6,1">Mt 6,1-4</a>
13. So. n. Trinitatis   6   #00ff00 grün    <a href="http://bibel-online.net/buch/44.apostel/6.html#6,1">Apg 6,1-7</a>
trin14
14. So. n. Trinitatis   1   #00ff00 grün    <a href="http://bibel-online.net/buch/42.lukas/17.html#17,11">Lk 17,11-19</a>
14. So. n. Trinitatis   2   #00ff00 grün    <a href="http://bibel-online.net/buch/45.roemer/8.html#8,12">Röm 8,12-17</a>
14. So. n. Trinitatis   3   #00ff00 grün    <a href="http://bibel-online.net/buch/41.markus/1.html#1,40">Mk 1,40-45</a>
14. So. n. Trinitatis   4   #00ff00 grün    <a href="http://bibel-online.net/buch/52.1-thessalonicher/1.html#1,2">1 Thess 1,2-10</a>
14. So. n. Trinitatis   5   #00ff00 grün    <a href="http://bibel-online.net/buch/01.1-mose/28.html#28,10">1 Mose 28,10-22</a>
14. So. n. Trinitatis   6   #00ff00 grün    <a href="http://bibel-online.net/buch/52.1-thessalonicher/5.html#5,14">1 Thess 5,14-24</a>
trin15
15. So. n. Trinitatis   1   #00ff00 grün    <a href="http://bibel-online.net/buch/40.matthaeus/6.html#6,25">Mt 6,25-34</a>
15. So. n. Trinitatis   2   #00ff00 grün    <a href="http://bibel-online.net/buch/60.1-petrus/5.html#5,5">1 Pet 5,5c-11</a>
15. So. n. Trinitatis   3   #00ff00 grün    <a href="http://bibel-online.net/buch/42.lukas/18.html#18,28">Lk 18,28-30</a>
15. So. n. Trinitatis   4   #00ff00 grün    <a href="http://bibel-online.net/buch/48.galater/5.html#5,25">Gal 5,25-6,10</a>
15. So. n. Trinitatis   5   #00ff00 grün    <a href="http://bibel-online.net/buch/42.lukas/17.html#17,5">Lk 17,5-6</a>
15. So. n. Trinitatis   6   #00ff00 grün    <a href="http://bibel-online.net/buch/01.1-mose/2.html#2,4">1 Mose 2,4b-15(10-14</a>
trin16
16. So. n. Trinitatis   1   #00ff00 grün    <a href="http://bibel-online.net/buch/43.johannes/11.html#11,1">Joh 11,1-4.17-27.40-4</a>
16. So. n. Trinitatis   2   #00ff00 grün    <a href="http://bibel-online.net/buch/55.2-timotheus/1.html#1,7">2 Tim 1,7-10</a>
16. So. n. Trinitatis   3   #00ff00 grün    <a href="http://bibel-online.net/buch/25.klage/3.html#3,22">Klgl 3,22-26.31-32</a>
16. So. n. Trinitatis   4   #00ff00 grün    <a href="http://bibel-online.net/buch/44.apostel/12.html#12,1">Apg 12,1-11</a>
16. So. n. Trinitatis   5   #00ff00 grün    <a href="http://bibel-online.net/buch/42.lukas/7.html#7,11">Lk 7,11-16</a>
16. So. n. Trinitatis   6   #00ff00 grün    <a href="http://bibel-online.net/buch/58.hebraeer/10.html#10,35">Hebr 10,35-39</a>
trin17
17. So. n. Trinitatis   1   #00ff00 grün    <a href="http://bibel-online.net/buch/40.matthaeus/15.html#15,21">Mt 15,21-28</a>
17. So. n. Trinitatis   2   #00ff00 grün    <a href="http://bibel-online.net/buch/45.roemer/10.html#10,9">Röm 10,9-17(18)</a>
17. So. n. Trinitatis   3   #00ff00 grün    <a href="http://bibel-online.net/buch/41.markus/9.html#9,17">Mk 9,17-29</a>
17. So. n. Trinitatis   4   #00ff00 grün    <a href="http://bibel-online.net/buch/23.jesaja/49.html#49,1">Jes 49,1-6</a>
17. So. n. Trinitatis   5   #00ff00 grün    <a href="http://bibel-online.net/buch/43.johannes/9.html#9,35">Joh 9,35-41</a>
17. So. n. Trinitatis   6   #00ff00 grün    <a href="http://bibel-online.net/buch/49.epheser/4.html#4,1">Eph 4,1-6</a>
trin18
18. So. n. Trinitatis   1   #00ff00 grün    <a href="http://bibel-online.net/buch/41.markus/12.html#12,28">Mk 12,28-34</a>
18. So. n. Trinitatis   2   #00ff00 grün    <a href="http://bibel-online.net/buch/45.roemer/14.html#14,17">Röm 14,17-19</a>
18. So. n. Trinitatis   3   #00ff00 grün    <a href="http://bibel-online.net/buch/41.markus/10.html#10,17">Mk 10,17-27</a>
18. So. n. Trinitatis   4   #00ff00 grün    <a href="http://bibel-online.net/buch/59.jakobus/2.html#2,1">Jak 2,1-13</a>
18. So. n. Trinitatis   5   #00ff00 grün    <a href="http://bibel-online.net/buch/02.2-mose/20.html#20,1">2 Mose 20,1-17</a>
18. So. n. Trinitatis   6   #00ff00 grün    <a href="http://bibel-online.net/buch/49.epheser/5.html#5,15">Eph 5,15-21</a>
trin19
19. So. n. Trinitatis   1   #00ff00 grün    <a href="http://bibel-online.net/buch/41.markus/2.html#2,1">Mk 2,1-12</a>
19. So. n. Trinitatis   2   #00ff00 grün    <a href="http://bibel-online.net/buch/49.epheser/4.html#4,22">Eph 4,22-32</a>
19. So. n. Trinitatis   3   #00ff00 grün    <a href="http://bibel-online.net/buch/41.markus/1.html#1,32">Mk 1,32-39</a>
19. So. n. Trinitatis   4   #00ff00 grün    <a href="http://bibel-online.net/buch/59.jakobus/5.html#5,13">Jak 5,13-16</a>
19. So. n. Trinitatis   5   #00ff00 grün    <a href="http://bibel-online.net/buch/43.johannes/5.html#5,1">Joh 5,1-16</a>
19. So. n. Trinitatis   6   #00ff00 grün    <a href="http://bibel-online.net/buch/02.2-mose/34.html#34,4">2 Mose 34,4-10</a>
adv2
2. Advent   1   #ff00aa violett <a href="http://bibel-online.net/buch/42.lukas/21.html#21,25">Lk 21,25-33</a>
2. Advent   2   #ff00aa violett <a href="http://bibel-online.net/buch/59.jakobus/5.html#5,7">Jak 5,7-8</a>
2. Advent   3   #ff00aa violett <a href="http://bibel-online.net/buch/40.matthaeus/24.html#24,1">Mt 24,1-14</a>
2. Advent   4   #ff00aa violett <a href="http://bibel-online.net/buch/23.jesaja/63.html#63,15">Jes 63,15-64,3</a>
2. Advent   5   #ff00aa violett <a href="http://bibel-online.net/buch/23.jesaja/35.html#35,3">Jes 35,3-10</a>
2. Advent   6   #ff00aa violett <a href="http://bibel-online.net/buch/66.offenbarung/3.html#3,7">Offb 3,7-13</a>
trin2
2. So. n. Trinitatis    1   #00ff00 grün    <a href="http://bibel-online.net/buch/42.lukas/14.html#14,15">Lk 14,(15)16-24</a>
2. So. n. Trinitatis    2   #00ff00 grün    <a href="http://bibel-online.net/buch/49.epheser/2.html#2,17">Eph 2,17-22</a>
2. So. n. Trinitatis    3   #00ff00 grün    <a href="http://bibel-online.net/buch/40.matthaeus/22.html#22,1">Mt 22,1-14</a>
2. So. n. Trinitatis    4   #00ff00 grün    <a href="http://bibel-online.net/buch/46.1-korinther/14.html#14,1">1 Kor 14,1-3.20-25</a>
2. So. n. Trinitatis    5   #00ff00 grün    <a href="http://bibel-online.net/buch/23.jesaja/55.html#55,1">Jes 55,1-5</a>
2. So. n. Trinitatis    6   #00ff00 grün    <a href="http://bibel-online.net/buch/46.1-korinther/9.html#9,16">1 Kor 9,16-23</a>
xmas2
2. So. nach Christfest  1   #ffffff weiß    <a href="http://bibel-online.net/buch/42.lukas/2.html#2,41">Lk 2,41-52</a>
2. So. nach Christfest  2   #ffffff weiß    <a href="http://bibel-online.net/buch/62.1-johannes/5.html#5,11">1 Joh 5,11-13</a>
2. So. nach Christfest  3   #ffffff weiß    <a href="http://bibel-online.net/buch/43.johannes/1.html#1,43">Joh 1,43-51</a>
2. So. nach Christfest  4   #ffffff weiß    <a href="http://bibel-online.net/buch/23.jesaja/61.html#61,1">Jes 61,1-3(4.9)10-11</a>
2. So. nach Christfest  5   #ffffff weiß    <a href="http://bibel-online.net/buch/43.johannes/7.html#7,14">Joh 7,14-18</a>
2. So. nach Christfest  6   #ffffff weiß    <a href="http://bibel-online.net/buch/45.roemer/16.html#16,25">Röm 16,25-27</a>
epi2
2. So. n. Epiphanias    1   #00ff00 grün    <a href="http://bibel-online.net/buch/43.johannes/2.html#2,1">Joh 2,1-11</a>
2. So. n. Epiphanias    2   #00ff00 grün    <a href="http://bibel-online.net/buch/45.roemer/12.html#12,4">Röm 12,4(9)-16</a>
2. So. n. Epiphanias    3   #00ff00 grün    <a href="http://bibel-online.net/buch/02.2-mose/33.html#33,12">2 Mose 33,(12)17b-23</a>
2. So. n. Epiphanias    4   #00ff00 grün    <a href="http://bibel-online.net/buch/46.1-korinther/2.html#2,1">1 Kor 2,1-10</a>
2. So. n. Epiphanias    5   #00ff00 grün    <a href="http://bibel-online.net/buch/41.markus/2.html#2,18">Mk 2,18-20(22)</a>
2. So. n. Epiphanias    6   #00ff00 grün    <a href="http://bibel-online.net/buch/58.hebraeer/12.html#12,12">Hebr 12,12-25a (*)</a>
trin20
20. So. n. Trinitatis   1   #00ff00 grün    <a href="http://bibel-online.net/buch/41.markus/10.html#10,2">Mk 10,2-12</a>
20. So. n. Trinitatis   2   #00ff00 grün    <a href="http://bibel-online.net/buch/52.1-thessalonicher/4.html#4,1">1 Thess 4,1-8</a>
20. So. n. Trinitatis   3   #00ff00 grün    <a href="http://bibel-online.net/buch/01.1-mose/8.html#8,18">1 Mose 8,18-22</a>
20. So. n. Trinitatis   4   #00ff00 grün    <a href="http://bibel-online.net/buch/46.1-korinther/7.html#7,29">1 Kor 7,29-31</a>
20. So. n. Trinitatis   5   #00ff00 grün    <a href="http://bibel-online.net/buch/41.markus/2.html#2,23">Mk 2,23-28</a>
20. So. n. Trinitatis   6   #00ff00 grün    <a href="http://bibel-online.net/buch/47.2-korinther/3.html#3,3">2 Kor 3,3-9</a>
trin21
21. So. n. Trinitatis   1   #00ff00 grün    <a href="http://bibel-online.net/buch/40.matthaeus/5.html#5,38">Mt 5,38-48</a>
21. So. n. Trinitatis   2   #00ff00 grün    <a href="http://bibel-online.net/buch/49.epheser/6.html#6,10">Eph 6,10-17</a>
21. So. n. Trinitatis   3   #00ff00 grün    <a href="http://bibel-online.net/buch/40.matthaeus/10.html#10,34">Mt 10,34-39</a>
21. So. n. Trinitatis   4   #00ff00 grün    <a href="http://bibel-online.net/buch/24.jeremia/29.html#29,1">Jer 29,1.4-7.10-14</a>
21. So. n. Trinitatis   5   #00ff00 grün    <a href="http://bibel-online.net/buch/43.johannes/15.html#15,9">Joh 15,9-12(17)</a>
21. So. n. Trinitatis   6   #00ff00 grün    <a href="http://bibel-online.net/buch/46.1-korinther/12.html#12,12">1 Kor 12,12-14(25;27</a>
trin22
22. So. n. Trinitatis   1   #00ff00 grün    <a href="http://bibel-online.net/buch/40.matthaeus/18.html#18,21">Mt 18,21-35</a>
22. So. n. Trinitatis   2   #00ff00 grün    <a href="http://bibel-online.net/buch/50.philemon/1.html#1,3">Phil 1,3-11</a>
22. So. n. Trinitatis   3   #00ff00 grün    <a href="http://bibel-online.net/buch/40.matthaeus/18.html#18,15">Mt 18,15-20</a>
22. So. n. Trinitatis   4   #00ff00 grün    <a href="http://bibel-online.net/buch/45.roemer/7.html#7,14">Röm 7,14-25a(8,2)</a>
22. So. n. Trinitatis   5   #00ff00 grün    <a href="http://bibel-online.net/buch/33.micha/6.html#6,6">Mi 6,6-8</a>
22. So. n. Trinitatis   6   #00ff00 grün    <a href="http://bibel-online.net/buch/62.1-johannes/2.html#2,7">1 Joh 2,(7)12-17</a>
trin23
23. So. n. Trinitatis   1   #00ff00 grün    <a href="http://bibel-online.net/buch/40.matthaeus/22.html#22,15">Mt 22,15-22</a>
23. So. n. Trinitatis   2   #00ff00 grün    <a href="http://bibel-online.net/buch/50.philemon/3.html#3,17">Phil 3,17(18)-19(21)</a>
23. So. n. Trinitatis   3   #00ff00 grün    <a href="http://bibel-online.net/buch/43.johannes/15.html#15,18">Joh 15,18-21</a>
23. So. n. Trinitatis   4   #00ff00 grün    <a href="http://bibel-online.net/buch/45.roemer/13.html#13,1">Röm 13,1-7</a>
23. So. n. Trinitatis   5   #00ff00 grün    <a href="http://bibel-online.net/buch/40.matthaeus/5.html#5,33">Mt 5,33-37</a>
23. So. n. Trinitatis   6   #00ff00 grün    <a href="http://bibel-online.net/buch/01.1-mose/18.html#18,20">1 Mose 18,20-33</a>
trin24
24. So. n. Trinitatis   1   #00ff00 grün    <a href="http://bibel-online.net/buch/40.matthaeus/9.html#9,18">Mt 9,18-26</a>
24. So. n. Trinitatis   2   #00ff00 grün    <a href="http://bibel-online.net/buch/51.kolosser/1.html#1,8">Kol 1,(8-12)13-20</a>
24. So. n. Trinitatis   3   #00ff00 grün    <a href="http://bibel-online.net/buch/21.prediger/3.html#3,1">Pred 3,1-14</a>
24. So. n. Trinitatis   4   #00ff00 grün    <a href="http://bibel-online.net/buch/xxbook/x.html#x,x">?</a>
24. So. n. Trinitatis   5   #00ff00 grün    <a href="http://bibel-online.net/buch/xxbook/x.html#x,x">?</a>
24. So. n. Trinitatis   6   #00ff00 grün    <a href="http://bibel-online.net/buch/xxbook/x.html#x,x">?</a>
adv3
3. Advent   1   #ff00aa violett <a href="http://bibel-online.net/buch/40.matthaeus/11.html#11,2">Mt 11,2-6(11)</a>
3. Advent   2   #ff00aa violett <a href="http://bibel-online.net/buch/46.1-korinther/4.html#4,1">1 Kor 4,1-5</a>
3. Advent   3   #ff00aa violett <a href="http://bibel-online.net/buch/42.lukas/3.html#3,1">Lk 3,1-14</a>
3. Advent   4   #ff00aa violett <a href="http://bibel-online.net/buch/45.roemer/15.html#15,4">Röm 15,(4)5-13</a>
3. Advent   5   #ff00aa violett <a href="http://bibel-online.net/buch/23.jesaja/40.html#40,1">Jes 40,1-11</a>
3. Advent   6   #ff00aa violett <a href="http://bibel-online.net/buch/66.offenbarung/3.html#3,1">Offb 3,1-6</a>
trin3
3. So. n. Trinitatis    1   #00ff00 grün    <a href="http://bibel-online.net/buch/42.lukas/15.html#15,1">Lk 15,1-3.11b-32</a>
3. So. n. Trinitatis    2   #00ff00 grün    <a href="http://bibel-online.net/buch/54.1-timotheus/1.html#1,12">1 Tim 1,12-17</a>
3. So. n. Trinitatis    3   #00ff00 grün    <a href="http://bibel-online.net/buch/42.lukas/15.html#15,1">Lk 15,1-7(8-10)</a>
3. So. n. Trinitatis    4   #00ff00 grün    <a href="http://bibel-online.net/buch/62.1-johannes/1.html#1,5">1 Joh 1,5-2,6</a>
3. So. n. Trinitatis    5   #00ff00 grün    <a href="http://bibel-online.net/buch/42.lukas/19.html#19,1">Lk 19,1-10</a>
3. So. n. Trinitatis    6   #00ff00 grün    <a href="http://bibel-online.net/buch/26.hesekiel/18.html#18,1">Hes 18,1-4.21-24.30-32</a>
epi3
3. So. n. Epiphanias    1   #00ff00 grün    <a href="http://bibel-online.net/buch/40.matthaeus/8.html#8,5">Mt 8,5-13</a>
3. So. n. Epiphanias    2   #00ff00 grün    <a href="http://bibel-online.net/buch/45.roemer/1.html#1,14">Röm 1,14-17</a>
3. So. n. Epiphanias    3   #00ff00 grün    <a href="http://bibel-online.net/buch/43.johannes/4.html#4,46">Joh 4,46-54</a>
3. So. n. Epiphanias    4   #00ff00 grün    <a href="http://bibel-online.net/buch/12.2-koenige/5.html#5,1">2 Kön 5,(1)9-19a</a>
3. So. n. Epiphanias    5   #00ff00 grün    <a href="http://bibel-online.net/buch/43.johannes/4.html#4,5">Joh 4,5-14</a>
3. So. n. Epiphanias    6   #00ff00 grün    <a href="http://bibel-online.net/buch/44.apostel/10.html#10,21">Apg 10,21-35*</a>
adv4
4. Advent   1   #ff00aa violett <a href="http://bibel-online.net/buch/42.lukas/1.html#1,39">Lk 1,(39)46-55(56)</a>
4. Advent   2   #ff00aa violett <a href="http://bibel-online.net/buch/50.philemon/4.html#4,4">Phil 4,4-7(9)</a>
4. Advent   3   #ff00aa violett <a href="http://bibel-online.net/buch/42.lukas/1.html#1,26">Lk 1,26-38</a>
4. Advent   4   #ff00aa violett <a href="http://bibel-online.net/buch/47.2-korinther/1.html#1,18">2 Kor 1,18-22</a>
4. Advent   5   #ff00aa violett <a href="http://bibel-online.net/buch/43.johannes/1.html#1,19">Joh 1,19-28</a>
4. Advent   6   #ff00aa violett <a href="http://bibel-online.net/buch/23.jesaja/52.html#52,7">Jes 52,7-10</a>
trin4
4. So. n. Trinitatis    1   #00ff00 grün    <a href="http://bibel-online.net/buch/42.lukas/6.html#6,36">Lk 6,36-42</a>
4. So. n. Trinitatis    2   #00ff00 grün    <a href="http://bibel-online.net/buch/45.roemer/14.html#14,10">Röm 14,10-13</a>
4. So. n. Trinitatis    3   #00ff00 grün    <a href="http://bibel-online.net/buch/01.1-mose/50.html#50,15">1 Mose 50,15-21</a>
4. So. n. Trinitatis    4   #00ff00 grün    <a href="http://bibel-online.net/buch/60.1-petrus/3.html#3,8">1 Pet 3,8-15a(17)</a>
4. So. n. Trinitatis    5   #00ff00 grün    <a href="http://bibel-online.net/buch/43.johannes/8.html#8,3">Joh 8,3-11</a>
4. So. n. Trinitatis    6   #00ff00 grün    <a href="http://bibel-online.net/buch/45.roemer/12.html#12,17">Röm 12,17-21</a>
epi4
4. So. n. Epiphanias    1   #00ff00 grün    <a href="http://bibel-online.net/buch/41.markus/4.html#4,35">Mk 4,35-41</a>
4. So. n. Epiphanias    2   #00ff00 grün    <a href="http://bibel-online.net/buch/47.2-korinther/1.html#1,8">2 Kor 1,8-11</a>
4. So. n. Epiphanias    3   #00ff00 grün    <a href="http://bibel-online.net/buch/40.matthaeus/14.html#14,22">Mt 14,22-33</a>
4. So. n. Epiphanias    4   #00ff00 grün    <a href="http://bibel-online.net/buch/49.epheser/1.html#1,15">Eph 1,15-20a</a>
4. So. n. Epiphanias    5   #00ff00 grün    <a href="http://bibel-online.net/buch/23.jesaja/51.html#51,9">Jes 51,9-16</a>
4. So. n. Epiphanias    6   #00ff00 grün    <a href="http://bibel-online.net/buch/01.1-mose/8.html#8,1">1 Mose 8,1-12</a>
trin5
5. So. n. Trinitatis    1   #00ff00 grün    <a href="http://bibel-online.net/buch/42.lukas/5.html#5,1">Lk 5,1-11</a>
5. So. n. Trinitatis    2   #00ff00 grün    <a href="http://bibel-online.net/buch/46.1-korinther/1.html#1,18">1 Kor 1,18-25</a>
5. So. n. Trinitatis    3   #00ff00 grün    <a href="http://bibel-online.net/buch/43.johannes/1.html#1,35">Joh 1,35-42</a>
5. So. n. Trinitatis    4   #00ff00 grün    <a href="http://bibel-online.net/buch/01.1-mose/12.html#12,1">1 Mose 12,1-4</a>
5. So. n. Trinitatis    5   #00ff00 grün    <a href="http://bibel-online.net/buch/42.lukas/14.html#14,25">Lk 14,25-33</a>
5. So. n. Trinitatis    6   #00ff00 grün    <a href="http://bibel-online.net/buch/53.2-thessalonicher/3.html#3,1">2 Thess 3,1-5</a>
epi5
5. So. n. Epiphanias    1   #00ff00 grün    <a href="http://bibel-online.net/buch/40.matthaeus/13.html#13,24">Mt 13,24-30</a>
5. So. n. Epiphanias    2   #00ff00 grün    <a href="http://bibel-online.net/buch/47.2-korinther/1.html#1,4">2 Kor 1,(4-5)6-9</a>
5. So. n. Epiphanias    3   #00ff00 grün    <a href="http://bibel-online.net/buch/23.jesaja/40.html#40,12">Jes 40,12-25</a>
5. So. n. Epiphanias    4   #00ff00 grün    <a href="http://bibel-online.net/buch/xxbook/x.html#x,x">?</a>
5. So. n. Epiphanias    5   #00ff00 grün    <a href="http://bibel-online.net/buch/xxbook/x.html#x,x">?</a>
5. So. n. Epiphanias    6   #00ff00 grün    <a href="http://bibel-online.net/buch/xxbook/x.html#x,x">?</a>
trin6
6. So. n. Trinitatis    1   #00ff00 grün    <a href="http://bibel-online.net/buch/40.matthaeus/28.html#28,16">Mt 28,16-20</a>
6. So. n. Trinitatis    2   #00ff00 grün    <a href="http://bibel-online.net/buch/45.roemer/6.html#6,3">Röm 6,3-11</a>
6. So. n. Trinitatis    3   #00ff00 grün    <a href="http://bibel-online.net/buch/05.5-mose/7.html#7,6">5 Mose 7,6-12</a>
6. So. n. Trinitatis    4   #00ff00 grün    <a href="http://bibel-online.net/buch/44.apostel/8.html#8,26">Apg 8,26-39</a>
6. So. n. Trinitatis    5   #00ff00 grün    <a href="http://bibel-online.net/buch/23.jesaja/43.html#43,1">Jes 43,1-7</a>
6. So. n. Trinitatis    6   #00ff00 grün    <a href="http://bibel-online.net/buch/60.1-petrus/2.html#2,1">1 Pet 2,1-10</a>
trin7
7. So. n. Trinitatis    1   #00ff00 grün    <a href="http://bibel-online.net/buch/43.johannes/6.html#6,1">Joh 6,1-15</a>
7. So. n. Trinitatis    2   #00ff00 grün    <a href="http://bibel-online.net/buch/44.apostel/2.html#2,41">Apg 2,41-47</a>
7. So. n. Trinitatis    3   #00ff00 grün    <a href="http://bibel-online.net/buch/43.johannes/6.html#6,30">Joh 6,30-35</a>
7. So. n. Trinitatis    4   #00ff00 grün    <a href="http://bibel-online.net/buch/50.philemon/2.html#2,1">Phil 2,1-4</a>
7. So. n. Trinitatis    5   #00ff00 grün    <a href="http://bibel-online.net/buch/42.lukas/9.html#9,10">Lk 9,10-17</a>
7. So. n. Trinitatis    6   #00ff00 grün    <a href="http://bibel-online.net/buch/02.2-mose/16.html#16,2">2 Mose 16,2-3.11-18</a>
trin8
8. So. n. Trinitatis    1   #00ff00 grün    <a href="http://bibel-online.net/buch/40.matthaeus/5.html#5,13">Mt 5,13-16</a>
8. So. n. Trinitatis    2   #00ff00 grün    <a href="http://bibel-online.net/buch/49.epheser/5.html#5,8">Eph 5,8b-14</a>
8. So. n. Trinitatis    3   #00ff00 grün    <a href="http://bibel-online.net/buch/23.jesaja/2.html#2,1">Jes 2,1-5</a>
8. So. n. Trinitatis    4   #00ff00 grün    <a href="http://bibel-online.net/buch/46.1-korinther/6.html#6,9">1 Kor 6,9-14(15-17)1</a>
8. So. n. Trinitatis    5   #00ff00 grün    <a href="http://bibel-online.net/buch/43.johannes/9.html#9,1">Joh 9,1-7</a>
8. So. n. Trinitatis    6   #00ff00 grün    <a href="http://bibel-online.net/buch/45.roemer/6.html#6,19">Röm 6,19-23</a>
trin9
9. So. n. Trinitatis    1   #00ff00 grün    <a href="http://bibel-online.net/buch/40.matthaeus/25.html#25,14">Mt 25,14-30</a>
9. So. n. Trinitatis    2   #00ff00 grün    <a href="http://bibel-online.net/buch/50.philemon/3.html#3,4">Phil 3,(4b)7-14</a>
9. So. n. Trinitatis    3   #00ff00 grün    <a href="http://bibel-online.net/buch/40.matthaeus/7.html#7,21">Mt 7,21-27</a>
9. So. n. Trinitatis    4   #00ff00 grün    <a href="http://bibel-online.net/buch/24.jeremia/1.html#1,4">Jer 1,4-10</a>
9. So. n. Trinitatis    5   #00ff00 grün    <a href="http://bibel-online.net/buch/40.matthaeus/13.html#13,44">Mt 13,44-46</a>
9. So. n. Trinitatis    6   #00ff00 grün    <a href="http://bibel-online.net/buch/60.1-petrus/4.html#4,7">1 Pet 4,7-11</a>
ashes
Aschermittwoch  1   #ff00aa violett <a href="http://bibel-online.net/buch/40.matthaeus/6.html#6,16">Mt 6,16-21</a>
Aschermittwoch  2   #ff00aa violett <a href="http://bibel-online.net/buch/61.2-petrus/1.html#1,2">2 Pet 1,2-11</a>
Aschermittwoch  3   #ff00aa violett <a href="http://bibel-online.net/buch/29.joel/2.html#2,12">Joel 2,12-18</a>
Aschermittwoch  4   #ff00aa violett <a href="http://bibel-online.net/buch/47.2-korinther/7.html#7,8">2 Kor 7,8-10</a>
Aschermittwoch  5   #ff00aa violett <a href="http://bibel-online.net/buch/40.matthaeus/7.html#7,21">Mt 7,21 -23</a>
Aschermittwoch  6   #ff00aa violett <a href="http://bibel-online.net/buch/02.2-mose/32.html#32,1">2 Mose 32,1-6.15-20</a>
prayer
Buß-und Bettag  1   #ff00aa violett <a href="http://bibel-online.net/buch/42.lukas/13.html#13,1">Lk 13,1-9</a>
Buß-und Bettag  2   #ff00aa violett <a href="http://bibel-online.net/buch/45.roemer/2.html#2,1">Röm 2,1-11</a>
Buß-und Bettag  3   #ff00aa violett <a href="http://bibel-online.net/buch/40.matthaeus/12.html#12,31">Mt 12,(31)33-37</a>
Buß-und Bettag  4   #ff00aa violett <a href="http://bibel-online.net/buch/66.offenbarung/3.html#3,14">Offb 3,14-22</a>
Buß-und Bettag  5   #ff00aa violett <a href="http://bibel-online.net/buch/42.lukas/13.html#13,22">Lk 13,22-27(30)</a>
Buß-und Bettag  6   #ff00aa violett <a href="http://bibel-online.net/buch/23.jesaja/1.html#1,10">Jes 1,10-17</a>
xmas1st
Christfest I    1   #ffffff weiß    <a href="http://bibel-online.net/buch/42.lukas/2.html#2,1">Lk 2,(1)15-20</a>
Christfest I    2   #ffffff weiß    <a href="http://bibel-online.net/buch/56.titus/3.html#3,4">Tit 3,4-7</a>
Christfest I    3   #ffffff weiß    <a href="http://bibel-online.net/buch/33.micha/5.html#5,1">Mi 5,1-4a</a>
Christfest I    4   #ffffff weiß    <a href="http://bibel-online.net/buch/62.1-johannes/3.html#3,1">1 Joh 3,1-6</a>
Christfest I    5   #ffffff weiß    <a href="http://bibel-online.net/buch/43.johannes/3.html#3,31">Joh 3,31-36</a>
Christfest I    6   #ffffff weiß    <a href="http://bibel-online.net/buch/48.galater/4.html#4,4">Gal 4,4-7</a>
xmas2nd
Christfest II   1   #ffffff weiß    <a href="http://bibel-online.net/buch/43.johannes/1.html#1,1">Joh 1,1-5(6-8)9-14</a>
Christfest II   2   #ffffff weiß    <a href="http://bibel-online.net/buch/58.hebraeer/1.html#1,1">Hebr 1,1-6</a>
Christfest II   3   #ffffff weiß    <a href="http://bibel-online.net/buch/43.johannes/8.html#8,12">Joh 8,12-16</a>
Christfest II   4   #ffffff weiß    <a href="http://bibel-online.net/buch/66.offenbarung/7.html#7,9">Offb 7,9-12(17)</a>
Christfest II   5   #ffffff weiß    <a href="http://bibel-online.net/buch/23.jesaja/11.html#11,1">Jes 11,1-9</a>
Christfest II   6   #ffffff weiß    <a href="http://bibel-online.net/buch/47.2-korinther/8.html#8,9">2 Kor 8,9</a>
ascensn
Christi Himmelfahrt 1   #ffffff weiß    <a href="http://bibel-online.net/buch/42.lukas/24.html#24,44">Lk 24,(44)50-53</a>
Christi Himmelfahrt 2   #ffffff weiß    <a href="http://bibel-online.net/buch/44.apostel/1.html#1,1">Apg 1,1-11</a>
Christi Himmelfahrt 3   #ffffff weiß    <a href="http://bibel-online.net/buch/11.1-koenige/8.html#8,22">1 Kön 8,22-24.26-28</a>
Christi Himmelfahrt 4   #ffffff weiß    <a href="http://bibel-online.net/buch/66.offenbarung/1.html#1,4">Offb 1,4-8</a>
Christi Himmelfahrt 5   #ffffff weiß    <a href="http://bibel-online.net/buch/43.johannes/17.html#17,20">Joh 17,20-26</a>
Christi Himmelfahrt 6   #ffffff weiß    <a href="http://bibel-online.net/buch/49.epheser/1.html#1,20">Eph 1,20b-23</a>
xmaseve
Christnacht 1   #ffffff weiß    <a href="http://bibel-online.net/buch/40.matthaeus/1.html#1,1">Mt 1,(1)18-25</a>
Christnacht 2   #ffffff weiß    <a href="http://bibel-online.net/buch/45.roemer/1.html#1,1">Röm 1,1-7</a>
Christnacht 3   #ffffff weiß    <a href="http://bibel-online.net/buch/10.2-samuel/7.html#7,4">2 Sam 7,4-6.12-14a</a>
Christnacht 4   #ffffff weiß    <a href="http://bibel-online.net/buch/23.jesaja/7.html#7,10">Jes 7,10-14</a>
Christnacht 5   #ffffff weiß    <a href="http://bibel-online.net/buch/26.hesekiel/37.html#37,24">Hes 37,24-28</a>
Christnacht 6   #ffffff weiß    <a href="http://bibel-online.net/buch/51.kolosser/2.html#2,3">Kol 2,3-10</a>
xmasvesp
Christvesper    1   #ffffff weiß    <a href="http://bibel-online.net/buch/42.lukas/2.html#2,1">Lk 2,1-14(20)</a>
Christvesper    2   #ffffff weiß    <a href="http://bibel-online.net/buch/56.titus/2.html#2,11">Tit 2,11-14</a>
Christvesper    3   #ffffff weiß    <a href="http://bibel-online.net/buch/43.johannes/3.html#3,16">Joh 3,16-21</a>
Christvesper    4   #ffffff weiß    <a href="http://bibel-online.net/buch/23.jesaja/9.html#9,1">Jes 9,1-6</a>
Christvesper    5   #ffffff weiß    <a href="http://bibel-online.net/buch/43.johannes/7.html#7,28">Joh 7,28-29</a>
Christvesper    6   #ffffff weiß    <a href="http://bibel-online.net/buch/54.1-timotheus/3.html#3,16">1 Tim 3,16</a>
trin97
Drittl.S.d.Kj.  1   #00ff00 grün    <a href="http://bibel-online.net/buch/42.lukas/17.html#17,20">Lk 17,20-24(30)</a>
Drittl.S.d.Kj.  2   #00ff00 grün    <a href="http://bibel-online.net/buch/45.roemer/14.html#14,7">Röm 14,7-9</a>
Drittl.S.d.Kj.  3   #00ff00 grün    <a href="http://bibel-online.net/buch/42.lukas/11.html#11,14">Lk 11,14-23</a>
Drittl.S.d.Kj.  4   #00ff00 grün    <a href="http://bibel-online.net/buch/18.hiob/14.html#14,1">Hiob 14,1-6</a>
Drittl.S.d.Kj.  5   #00ff00 grün    <a href="http://bibel-online.net/buch/42.lukas/18.html#18,1">Lk 18,1-8</a>
Drittl.S.d.Kj.  6   #00ff00 grün    <a href="http://bibel-online.net/buch/52.1-thessalonicher/5.html#5,1">1 Thess 5,1-11</a>
epi0
Epiphanias (Hl. Drei Könige)    1   #ffffff weiß    <a href="http://bibel-online.net/buch/40.matthaeus/2.html#2,1">Mt 2,1-12</a>
Epiphanias (Hl. Drei Könige)    2   #ffffff weiß    <a href="http://bibel-online.net/buch/49.epheser/3.html#3,2">Eph 3,2-3a.5-6</a>
Epiphanias (Hl. Drei Könige)    3   #ffffff weiß    <a href="http://bibel-online.net/buch/43.johannes/1.html#1,15">Joh 1,15-18</a>
Epiphanias (Hl. Drei Könige)    4   #ffffff weiß    <a href="http://bibel-online.net/buch/51.kolosser/1.html#1,24">Kol 1,24-27(29)</a>
Epiphanias (Hl. Drei Könige)    5   #ffffff weiß    <a href="http://bibel-online.net/buch/23.jesaja/60.html#60,1">Jes 60,1-6</a>
Epiphanias (Hl. Drei Könige)    6   #ffffff weiß    <a href="http://bibel-online.net/buch/47.2-korinther/4.html#4,1">2 Kor 4,1-6</a>
thank
Erntedank   1   #00ff00 grün    <a href="http://bibel-online.net/buch/42.lukas/12.html#12,13">Lk 12,(13-14)15-21</a>
Erntedank   2   #00ff00 grün    <a href="http://bibel-online.net/buch/47.2-korinther/9.html#9,6">2 Kor 9,6-15</a>
Erntedank   3   #00ff00 grün    <a href="http://bibel-online.net/buch/23.jesaja/58.html#58,7">Jes 58,7-12</a>
Erntedank   4   #00ff00 grün    <a href="http://bibel-online.net/buch/54.1-timotheus/4.html#4,4">1 Tim 4,4-5</a>
Erntedank   5   #00ff00 grün    <a href="http://bibel-online.net/buch/40.matthaeus/6.html#6,19">Mt 6,19-23</a>
Erntedank   6   #00ff00 grün    <a href="http://bibel-online.net/buch/58.hebraeer/13.html#13,15">Hebr 13,15-16</a>
lent_1
Estomihi    1   #00ff00 grün    <a href="http://bibel-online.net/buch/41.markus/8.html#8,31">Mk 8,31-38(9,1)</a>
Estomihi    2   #00ff00 grün    <a href="http://bibel-online.net/buch/46.1-korinther/13.html#13,1">1 Kor 13</a>
Estomihi    3   #00ff00 grün    <a href="http://bibel-online.net/buch/42.lukas/10.html#10,38">Lk 10,38-42</a>
Estomihi    4   #00ff00 grün    <a href="http://bibel-online.net/buch/30.amos/5.html#5,21">Amos 5,21-24</a>
Estomihi    5   #00ff00 grün    <a href="http://bibel-online.net/buch/42.lukas/18.html#18,31">Lk 18,31-43</a>
Estomihi    6   #00ff00 grün    <a href="http://bibel-online.net/buch/23.jesaja/58.html#58,1">Jes 58,1-9a</a>
trin99
Ewigkeitssonntag    1   #00ff00 grün    <a href="http://bibel-online.net/buch/40.matthaeus/25.html#25,1">Mt 25,1-13</a>
Ewigkeitssonntag    2   #00ff00 grün    <a href="http://bibel-online.net/buch/66.offenbarung/21.html#21,1">Offb 21,1-7(8)</a>
Ewigkeitssonntag    3   #00ff00 grün    <a href="http://bibel-online.net/buch/42.lukas/12.html#12,42">Lk 12,42-48</a>
Ewigkeitssonntag    4   #00ff00 grün    <a href="http://bibel-online.net/buch/23.jesaja/65.html#65,17">Jes 65,17-19(22;25)</a>
Ewigkeitssonntag    5   #00ff00 grün    <a href="http://bibel-online.net/buch/41.markus/13.html#13,31">Mk 13,31-37</a>
Ewigkeitssonntag    6   #00ff00 grün    <a href="http://bibel-online.net/buch/61.2-petrus/3.html#3,3">2 Pet 3,(3)8-13</a>
east6
Exaudi  1   #ffffff weiß    <a href="http://bibel-online.net/buch/43.johannes/15.html#15,26">Joh 15,26-16,4</a>
Exaudi  2   #ffffff weiß    <a href="http://bibel-online.net/buch/49.epheser/3.html#3,14">Eph 3,14-21</a>
Exaudi  3   #ffffff weiß    <a href="http://bibel-online.net/buch/43.johannes/7.html#7,37">Joh 7,37-39</a>
Exaudi  4   #ffffff weiß    <a href="http://bibel-online.net/buch/24.jeremia/31.html#31,31">Jer 31,31-34</a>
Exaudi  5   #ffffff weiß    <a href="http://bibel-online.net/buch/43.johannes/14.html#14,15">Joh 14,15-19</a>
Exaudi  6   #ffffff weiß    <a href="http://bibel-online.net/buch/45.roemer/8.html#8,26">Röm 8,26-30</a>
hsupper
Gründonnerstag  1   #ffffff weiß    <a href="http://bibel-online.net/buch/43.johannes/13.html#13,1">Joh 13,1-15(+34f)</a>
Gründonnerstag  2   #ffffff weiß    <a href="http://bibel-online.net/buch/46.1-korinther/11.html#11,23">1 Kor 11,23-26</a>
Gründonnerstag  3   #ffffff weiß    <a href="http://bibel-online.net/buch/41.markus/14.html#14,17">Mk 14,17-26</a>
Gründonnerstag  4   #ffffff weiß    <a href="http://bibel-online.net/buch/46.1-korinther/10.html#10,16">1 Kor 10,16-17</a>
Gründonnerstag  5   #ffffff weiß    <a href="http://bibel-online.net/buch/02.2-mose/12.html#12,1">2 Mose 12,1-14</a>
Gründonnerstag  6   #ffffff weiß    <a href="http://bibel-online.net/buch/58.hebraeer/2.html#2,10">Hebr 2,10-18</a>
lent1
Invocavit   1   #ff00aa violett <a href="http://bibel-online.net/buch/40.matthaeus/4.html#4,1">Mt 4,1-11</a>
Invocavit   2   #ff00aa violett <a href="http://bibel-online.net/buch/58.hebraeer/4.html#4,14">Hebr  4,14-16</a>
Invocavit   3   #ff00aa violett <a href="http://bibel-online.net/buch/01.1-mose/3.html#3,1">1 Mose 3,1-19(24)</a>
Invocavit   4   #ff00aa violett <a href="http://bibel-online.net/buch/47.2-korinther/6.html#6,1">2 Kor 6,1-10</a>
Invocavit   5   #ff00aa violett <a href="http://bibel-online.net/buch/42.lukas/22.html#22,31">Lk 22,31-34</a>
Invocavit   6   #ff00aa violett <a href="http://bibel-online.net/buch/59.jakobus/1.html#1,12">Jak 1,12-18</a>
east3
Jubilate    1   #ffffff weiß    <a href="http://bibel-online.net/buch/43.johannes/15.html#15,1">Joh 15,1-8</a>
Jubilate    2   #ffffff weiß    <a href="http://bibel-online.net/buch/62.1-johannes/5.html#5,1">1 Joh 5,1-4</a>
Jubilate    3   #ffffff weiß    <a href="http://bibel-online.net/buch/43.johannes/16.html#16,16">Joh 16,16(17)-19(23a</a>
Jubilate    4   #ffffff weiß    <a href="http://bibel-online.net/buch/47.2-korinther/4.html#4,16">2 Kor 4,16-18</a>
Jubilate    5   #ffffff weiß    <a href="http://bibel-online.net/buch/01.1-mose/1.html#1,1">1 Mose 1,1(26)-31(2,</a>
Jubilate    6   #ffffff weiß    <a href="http://bibel-online.net/buch/44.apostel/17.html#17,16">Apg 17,(16)22-28a(34</a>
lent5
Judika  1   #ff00aa violett <a href="http://bibel-online.net/buch/41.markus/10.html#10,35">Mk 10,35-45</a>
Judika  2   #ff00aa violett <a href="http://bibel-online.net/buch/58.hebraeer/5.html#5,7">Hebr 5,7-9</a>
Judika  3   #ff00aa violett <a href="http://bibel-online.net/buch/01.1-mose/22.html#22,1">1 Mose 22,1-13</a>
Judika  4   #ff00aa violett <a href="http://bibel-online.net/buch/04.4-mose/21.html#21,4">4 Mose 21,4-9</a>
Judika  5   #ff00aa violett <a href="http://bibel-online.net/buch/43.johannes/9.html#9,47">Joh 9,47-53</a>
Judika  6   #ff00aa violett <a href="http://bibel-online.net/buch/58.hebraeer/13.html#13,9">Hebr 13,(9)12-14</a>
east4
Kantate 1   #ffffff weiß    <a href="http://bibel-online.net/buch/40.matthaeus/11.html#11,25">Mt 11,25-30</a>
Kantate 2   #ffffff weiß    <a href="http://bibel-online.net/buch/51.kolosser/3.html#3,12">Kol 3,12-17</a>
Kantate 3   #ffffff weiß    <a href="http://bibel-online.net/buch/40.matthaeus/21.html#21,14">Mt 21,14-17(22)</a>
Kantate 4   #ffffff weiß    <a href="http://bibel-online.net/buch/44.apostel/16.html#16,23">Apg 16,(23)25-34</a>
Kantate 5   #ffffff weiß    <a href="http://bibel-online.net/buch/23.jesaja/12.html#12,1">Jes 12</a>
Kantate 6   #ffffff weiß    <a href="http://bibel-online.net/buch/66.offenbarung/15.html#15,2">Offb 15,2-4</a>
hfriday
Karfreitag  1   #000000 schwarz <a href="http://bibel-online.net/buch/43.johannes/19.html#19,16">Joh 19,16-30</a>
Karfreitag  2   #000000 schwarz <a href="http://bibel-online.net/buch/47.2-korinther/5.html#5,14">2 Kor 5,(14b)19-21</a>
Karfreitag  3   #000000 schwarz <a href="http://bibel-online.net/buch/42.lukas/23.html#23,33">Lk 23,33-49</a>
Karfreitag  4   #000000 schwarz <a href="http://bibel-online.net/buch/58.hebraeer/9.html#9,15">Hebr 9,15.26b-28</a>
Karfreitag  5   #000000 schwarz <a href="http://bibel-online.net/buch/40.matthaeus/27.html#27,33">Mt 27,33-50(54)</a>
Karfreitag  6   #000000 schwarz <a href="http://bibel-online.net/buch/23.jesaja/52.html#52,13">Jes (52,13)53,1-12</a>
lent4
Lätare  1   #ff00aa violett <a href="http://bibel-online.net/buch/43.johannes/12.html#12,20">Joh 12,20-26</a>
Lätare  2   #ff00aa violett <a href="http://bibel-online.net/buch/47.2-korinther/1.html#1,3">2 Kor 1,3-7</a>
Lätare  3   #ff00aa violett <a href="http://bibel-online.net/buch/43.johannes/6.html#6,55">Joh 6,55-65</a>
Lätare  4   #ff00aa violett <a href="http://bibel-online.net/buch/50.philemon/1.html#1,15">Phil 1,15-21</a>
Lätare  5   #ff00aa violett <a href="http://bibel-online.net/buch/43.johannes/6.html#6,47">Joh 6,47-51</a>
Lätare  6   #ff00aa violett <a href="http://bibel-online.net/buch/23.jesaja/54.html#54,7">Jes 54,7-10</a>
michael
Michaelistag    1   #ffffff weiß    <a href="http://bibel-online.net/buch/42.lukas/10.html#10,17">Lk 10,17-20</a>
Michaelistag    2   #ffffff weiß    <a href="http://bibel-online.net/buch/66.offenbarung/12.html#12,7">Offb 12,7-12</a>
Michaelistag    3   #ffffff weiß    <a href="http://bibel-online.net/buch/06.josua/5.html#5,13">Jos 5,13-15</a>
Michaelistag    4   #ffffff weiß    <a href="http://bibel-online.net/buch/44.apostel/5.html#5,17">Apg 5,17-20(33)</a>
Michaelistag    5   #ffffff weiß    <a href="http://bibel-online.net/buch/40.matthaeus/18.html#18,1">Mt 18,(1-6)10</a>
Michaelistag    6   #ffffff weiß    <a href="http://bibel-online.net/buch/58.hebraeer/1.html#1,7">Hebr 1,7.13-14</a>
east2
Misericordias Domini    1   #ffffff weiß    <a href="http://bibel-online.net/buch/43.johannes/10.html#10,11">Joh 10,11-16(27-30)</a>
Misericordias Domini    2   #ffffff weiß    <a href="http://bibel-online.net/buch/60.1-petrus/2.html#2,21">1 Pet 2,21b-25</a>
Misericordias Domini    3   #ffffff weiß    <a href="http://bibel-online.net/buch/26.hesekiel/34.html#34,1">Hes 34 (*)</a>
Misericordias Domini    4   #ffffff weiß    <a href="http://bibel-online.net/buch/60.1-petrus/5.html#5,1">1 Pet 5,1-5</a>
Misericordias Domini    5   #ffffff weiß    <a href="http://bibel-online.net/buch/43.johannes/21.html#21,15">Joh 21,15-19</a>
Misericordias Domini    6   #ffffff weiß    <a href="http://bibel-online.net/buch/58.hebraeer/13.html#13,20">Hebr 13,20-21</a>
fix0101
Neujahr 1   #ffffff weiß    <a href="http://bibel-online.net/buch/42.lukas/4.html#4,16">Lk 4,16-21</a>
Neujahr 2   #ffffff weiß    <a href="http://bibel-online.net/buch/59.jakobus/4.html#4,13">Jak 4,13-15</a>
Neujahr 3   #ffffff weiß    <a href="http://bibel-online.net/buch/43.johannes/14.html#14,1">Joh 14,1-6</a>
Neujahr 4   #ffffff weiß    <a href="http://bibel-online.net/buch/06.josua/1.html#1,1">Jos 1,1-9</a>
Neujahr 5   #ffffff weiß    <a href="http://bibel-online.net/buch/20.sprueche/16.html#16,1">Spr 16,1-9</a>
Neujahr 6   #ffffff weiß    <a href="http://bibel-online.net/buch/50.philemon/4.html#4,10">Phil 4,10-13(20)</a>
lent3
Okuli   1   #ff00aa violett <a href="http://bibel-online.net/buch/42.lukas/9.html#9,57">Lk 9,57-62</a>
Okuli   2   #ff00aa violett <a href="http://bibel-online.net/buch/49.epheser/5.html#5,1">Eph 5,1-8a</a>
Okuli   3   #ff00aa violett <a href="http://bibel-online.net/buch/41.markus/12.html#12,41">Mk 12,41-44</a>
Okuli   4   #ff00aa violett <a href="http://bibel-online.net/buch/60.1-petrus/1.html#1,13">1 Pet 1,(13)18-21</a>
Okuli   5   #ff00aa violett <a href="http://bibel-online.net/buch/24.jeremia/20.html#20,7">Jer 20,7-11a(13)</a>
Okuli   6   #ff00aa violett <a href="http://bibel-online.net/buch/11.1-koenige/19.html#19,1">1 Kön 19,1-8(13a)</a>
eastmon
Ostermontag 1   #ffffff weiß    <a href="http://bibel-online.net/buch/42.lukas/24.html#24,13">Lk 24,13-35</a>
Ostermontag 2   #ffffff weiß    <a href="http://bibel-online.net/buch/46.1-korinther/15.html#15,12">1 Kor 15,12-20</a>
Ostermontag 3   #ffffff weiß    <a href="http://bibel-online.net/buch/42.lukas/24.html#24,36">Lk 24,36-47</a>
Ostermontag 4   #ffffff weiß    <a href="http://bibel-online.net/buch/46.1-korinther/15.html#15,50">1 Kor 15,50-58</a>
Ostermontag 5   #ffffff weiß    <a href="http://bibel-online.net/buch/23.jesaja/25.html#25,6">Jes 25,6-9</a>
Ostermontag 6   #ffffff weiß    <a href="http://bibel-online.net/buch/44.apostel/10.html#10,34">Apg 10,34a.36-43</a>
easteve
Osternacht  1   #ffffff weiß    <a href="http://bibel-online.net/buch/40.matthaeus/28.html#28,1">Mt 28,1-10</a>
Osternacht  2   #ffffff weiß    <a href="http://bibel-online.net/buch/51.kolosser/3.html#3,1">Kol 3,1-4</a>
Osternacht  3   #ffffff weiß    <a href="http://bibel-online.net/buch/23.jesaja/26.html#26,13">Jes 26,13-14(18)(19)</a>
Osternacht  4   #ffffff weiß    <a href="http://bibel-online.net/buch/52.1-thessalonicher/4.html#4,13">1 Thess 4,13-14</a>
Osternacht  5   #ffffff weiß    <a href="http://bibel-online.net/buch/43.johannes/5.html#5,19">Joh 5,19-21</a>
Osternacht  6   #ffffff weiß    <a href="http://bibel-online.net/buch/55.2-timotheus/2.html#2,8">2 Tim 2,8a(-13)</a>
eastsun
Ostersonntag    1   #ffffff weiß    <a href="http://bibel-online.net/buch/41.markus/16.html#16,1">Mk 16,1-8</a>
Ostersonntag    2   #ffffff weiß    <a href="http://bibel-online.net/buch/46.1-korinther/15.html#15,1">1 Kor 15,1-11</a>
Ostersonntag    3   #ffffff weiß    <a href="http://bibel-online.net/buch/40.matthaeus/28.html#28,1">Mt 28,1-10</a>
Ostersonntag    4   #ffffff weiß    <a href="http://bibel-online.net/buch/09.1-samuel/2.html#2,1">1 Sam 2,1-2(3-5)6-8a</a>
Ostersonntag    5   #ffffff weiß    <a href="http://bibel-online.net/buch/43.johannes/20.html#20,11">Joh 20,11-18</a>
Ostersonntag    6   #ffffff weiß    <a href="http://bibel-online.net/buch/46.1-korinther/15.html#15,19">1 Kor 15,19-28</a>
lent6
Palmarum    1   #ff00aa violett <a href="http://bibel-online.net/buch/43.johannes/12.html#12,12">Joh 12,12-19</a>
Palmarum    2   #ff00aa violett <a href="http://bibel-online.net/buch/50.philemon/2.html#2,5">Phil 2,5-11</a>
Palmarum    3   #ff00aa violett <a href="http://bibel-online.net/buch/41.markus/14.html#14,3">Mk 14,3-9</a>
Palmarum    4   #ff00aa violett <a href="http://bibel-online.net/buch/23.jesaja/50.html#50,4">Jes 50,4-9</a>
Palmarum    5   #ff00aa violett <a href="http://bibel-online.net/buch/43.johannes/17.html#17,1">Joh 17,1-8</a>
Palmarum    6   #ff00aa violett <a href="http://bibel-online.net/buch/58.hebraeer/12.html#12,1">Hebr 12,1-3</a>
pentmon
Pfingstmontag   1   #ff0000 rot <a href="http://bibel-online.net/buch/40.matthaeus/16.html#16,13">Mt 16,13-19</a>
Pfingstmontag   2   #ff0000 rot <a href="http://bibel-online.net/buch/46.1-korinther/12.html#12,4">1 Kor 12,4-11</a>
Pfingstmontag   3   #ff0000 rot <a href="http://bibel-online.net/buch/01.1-mose/11.html#11,1">1 Mose 11,1-9</a>
Pfingstmontag   4   #ff0000 rot <a href="http://bibel-online.net/buch/49.epheser/4.html#4,11">Eph 4,11-16</a>
Pfingstmontag   5   #ff0000 rot <a href="http://bibel-online.net/buch/43.johannes/4.html#4,19">Joh 4,19-26</a>
Pfingstmontag   6   #ff0000 rot <a href="http://bibel-online.net/buch/44.apostel/2.html#2,22">Apg 2,22f (*)</a>
pent
Pfingstsonntag  1   #ff0000 rot <a href="http://bibel-online.net/buch/43.johannes/14.html#14,23">Joh 14,23-27</a>
Pfingstsonntag  2   #ff0000 rot <a href="http://bibel-online.net/buch/44.apostel/2.html#2,1">Apg 2,1-21(36)</a>
Pfingstsonntag  3   #ff0000 rot <a href="http://bibel-online.net/buch/43.johannes/16.html#16,5">Joh 16,5-15</a>
Pfingstsonntag  4   #ff0000 rot <a href="http://bibel-online.net/buch/46.1-korinther/2.html#2,12">1 Kor 2,12-16</a>
Pfingstsonntag  5   #ff0000 rot <a href="http://bibel-online.net/buch/04.4-mose/11.html#11,11">4 Mose 11,11-25*</a>
Pfingstsonntag  6   #ff0000 rot <a href="http://bibel-online.net/buch/45.roemer/8.html#8,1">Röm 8,1-11</a>
east1
Quasimodogeniti 1   #ffffff weiß    <a href="http://bibel-online.net/buch/43.johannes/20.html#20,19">Joh 20,19-31</a>
Quasimodogeniti 2   #ffffff weiß    <a href="http://bibel-online.net/buch/60.1-petrus/1.html#1,1">1 Pet 1,1-9</a>
Quasimodogeniti 3   #ffffff weiß    <a href="http://bibel-online.net/buch/43.johannes/21.html#21,1">Joh 21,1-14</a>
Quasimodogeniti 4   #ffffff weiß    <a href="http://bibel-online.net/buch/51.kolosser/2.html#2,12">Kol 2,12-15</a>
Quasimodogeniti 5   #ffffff weiß    <a href="http://bibel-online.net/buch/41.markus/16.html#16,9">Mk 16,9-14(20)</a>
Quasimodogeniti 6   #ffffff weiß    <a href="http://bibel-online.net/buch/23.jesaja/40.html#40,26">Jes 40,26-31</a>
fix1031
Reformationsfest    1   #ff0000 rot <a href="http://bibel-online.net/buch/40.matthaeus/5.html#5,1">Mt 5,1-10(12)</a>
Reformationsfest    2   #ff0000 rot <a href="http://bibel-online.net/buch/45.roemer/3.html#3,21">Röm 3,21-28(31)</a>
Reformationsfest    3   #ff0000 rot <a href="http://bibel-online.net/buch/40.matthaeus/10.html#10,26">Mt 10,26b-33</a>
Reformationsfest    4   #ff0000 rot <a href="http://bibel-online.net/buch/48.galater/5.html#5,1">Gal 5,1-6</a>
Reformationsfest    5   #ff0000 rot <a href="http://bibel-online.net/buch/23.jesaja/62.html#62,6">Jes 62,6-7.10-12</a>
Reformationsfest    6   #ff0000 rot <a href="http://bibel-online.net/buch/50.philemon/2.html#2,12">Phil 2,12-18</a>
lent2
Reminiscere 1   #ff00aa violett <a href="http://bibel-online.net/buch/41.markus/12.html#12,1">Mk 12,1-12</a>
Reminiscere 2   #ff00aa violett <a href="http://bibel-online.net/buch/45.roemer/5.html#5,1">Röm 5,1-5(11)</a>
Reminiscere 3   #ff00aa violett <a href="http://bibel-online.net/buch/40.matthaeus/12.html#12,38">Mt 12,38-42</a>
Reminiscere 4   #ff00aa violett <a href="http://bibel-online.net/buch/23.jesaja/5.html#5,1">Jes 5,1-7</a>
Reminiscere 5   #ff00aa violett <a href="http://bibel-online.net/buch/43.johannes/8.html#8,21">Joh 8,(21)26b-30</a>
Reminiscere 6   #ff00aa violett <a href="http://bibel-online.net/buch/58.hebraeer/11.html#11,1">Hebr 11,1-3.8-10</a>
east5
Rogate  1   #ffffff weiß    <a href="http://bibel-online.net/buch/43.johannes/16.html#16,23">Joh 16,23b-28(32)(33)</a>
Rogate  2   #ffffff weiß    <a href="http://bibel-online.net/buch/54.1-timotheus/2.html#2,1">1 Tim 2,1-6a</a>
Rogate  3   #ffffff weiß    <a href="http://bibel-online.net/buch/42.lukas/11.html#11,5">Lk 11,5-13</a>
Rogate  4   #ffffff weiß    <a href="http://bibel-online.net/buch/51.kolosser/4.html#4,2">Kol 4,2-4(6)</a>
Rogate  5   #ffffff weiß    <a href="http://bibel-online.net/buch/40.matthaeus/6.html#6,5">Mt 6,5(7)-13(15)</a>
Rogate  6   #ffffff weiß    <a href="http://bibel-online.net/buch/02.2-mose/32.html#32,7">2 Mose 32,7-14</a>
lent_3
Septuagesimä    1   #00ff00 grün    <a href="http://bibel-online.net/buch/40.matthaeus/20.html#20,1">Mt 20,1-16a</a>
Septuagesimä    2   #00ff00 grün    <a href="http://bibel-online.net/buch/46.1-korinther/9.html#9,24">1 Kor 9,24-27</a>
Septuagesimä    3   #00ff00 grün    <a href="http://bibel-online.net/buch/42.lukas/17.html#17,7">Lk 17,7-10</a>
Septuagesimä    4   #00ff00 grün    <a href="http://bibel-online.net/buch/24.jeremia/9.html#9,22">Jer 9,22-23</a>
Septuagesimä    5   #00ff00 grün    <a href="http://bibel-online.net/buch/40.matthaeus/9.html#9,9">Mt 9,9-13</a>
Septuagesimä    6   #00ff00 grün    <a href="http://bibel-online.net/buch/45.roemer/9.html#9,14">Röm 9,14-24</a>
lent_2
Sexagesimä  1   #00ff00 grün    <a href="http://bibel-online.net/buch/42.lukas/8.html#8,4">Lk 8,4-8(15)</a>
Sexagesimä  2   #00ff00 grün    <a href="http://bibel-online.net/buch/58.hebraeer/4.html#4,12">Hebr 4,12-13</a>
Sexagesimä  3   #00ff00 grün    <a href="http://bibel-online.net/buch/41.markus/4.html#4,26">Mk 4,26-29</a>
Sexagesimä  4   #00ff00 grün    <a href="http://bibel-online.net/buch/47.2-korinther/11.html#11,18">2 Kor (11,18)12,1-10</a>
Sexagesimä  5   #00ff00 grün    <a href="http://bibel-online.net/buch/23.jesaja/55.html#55,6">Jes 55,6-12a</a>
Sexagesimä  6   #00ff00 grün    <a href="http://bibel-online.net/buch/44.apostel/16.html#16,9">Apg 16,9-15</a>
fix1231
Silvester   1   #ffffff weiß    <a href="http://bibel-online.net/buch/42.lukas/12.html#12,35">Lk 12,35-40</a>
Silvester   2   #ffffff weiß    <a href="http://bibel-online.net/buch/45.roemer/8.html#8,31">Röm 8,31b-39</a>
Silvester   3   #ffffff weiß    <a href="http://bibel-online.net/buch/23.jesaja/30.html#30,8">Jes 30,(8)15-17</a>
Silvester   4   #ffffff weiß    <a href="http://bibel-online.net/buch/02.2-mose/13.html#13,20">2 Mose 13,20-22</a>
Silvester   5   #ffffff weiß    <a href="http://bibel-online.net/buch/43.johannes/8.html#8,31">Joh 8,31-36</a>
Silvester   6   #ffffff weiß    <a href="http://bibel-online.net/buch/58.hebraeer/13.html#13,8">Hebr 13,8-9b</a>
trin99
Totensonntag    1   #ffffff weiß    <a href="http://bibel-online.net/buch/43.johannes/5.html#5,24">Joh 5,24-29</a>
Totensonntag    2   #ffffff weiß    <a href="http://bibel-online.net/buch/46.1-korinther/15.html#15,35">1 Kor 15,35-38.42-44</a>
Totensonntag    3   #ffffff weiß    <a href="http://bibel-online.net/buch/27.daniel/12.html#12,1">Dan 12,1b-3</a>
Totensonntag    4   #ffffff weiß    <a href="http://bibel-online.net/buch/50.philemon/1.html#1,21">Phil 1,21-26</a>
Totensonntag    5   #ffffff weiß    <a href="http://bibel-online.net/buch/40.matthaeus/22.html#22,23">Mt 22,23-33</a>
Totensonntag    6   #ffffff weiß    <a href="http://bibel-online.net/buch/58.hebraeer/4.html#4,9">Hebr 4,9-11</a>
trin0
Trinitatis  1   #ffffff weiß    <a href="http://bibel-online.net/buch/43.johannes/3.html#3,1">Joh 3,1-8(15)</a>
Trinitatis  2   #ffffff weiß    <a href="http://bibel-online.net/buch/45.roemer/11.html#11,33">Röm 11,33-36</a>
Trinitatis  3   #ffffff weiß    <a href="http://bibel-online.net/buch/23.jesaja/6.html#6,1">Jes 6,1-13</a>
Trinitatis  4   #ffffff weiß    <a href="http://bibel-online.net/buch/49.epheser/1.html#1,3">Eph 1,3-14</a>
Trinitatis  5   #ffffff weiß    <a href="http://bibel-online.net/buch/04.4-mose/6.html#6,22">4 Mose 6,22-27</a>
Trinitatis  6   #ffffff weiß    <a href="http://bibel-online.net/buch/47.2-korinther/13.html#13,11">2 Kor 13,11(12)-13</a>
trin98
Volkstrauertag  1   #00ff00 grün    <a href="http://bibel-online.net/buch/40.matthaeus/25.html#25,31">Mt 25,31-46</a>
Volkstrauertag  2   #00ff00 grün    <a href="http://bibel-online.net/buch/45.roemer/8.html#8,18">Röm 8,18-23(24-25)</a>
Volkstrauertag  3   #00ff00 grün    <a href="http://bibel-online.net/buch/42.lukas/16.html#16,1">Lk 16,1-8(9)</a>
Volkstrauertag  4   #00ff00 grün    <a href="http://bibel-online.net/buch/66.offenbarung/2.html#2,8">Offb 2,8-11</a>
Volkstrauertag  5   #00ff00 grün    <a href="http://bibel-online.net/buch/24.jeremia/8.html#8,4">Jer 8,4-7</a>
Volkstrauertag  6   #00ff00 grün    <a href="http://bibel-online.net/buch/47.2-korinther/5.html#5,1">2 Kor 5,1-10</a>
epi99
letzter So. nach Epiphanias 1   #ffffff weiß    <a href="http://bibel-online.net/buch/40.matthaeus/17.html#17,1">Mt 17,1-9</a>
letzter So. nach Epiphanias 2   #ffffff weiß    <a href="http://bibel-online.net/buch/47.2-korinther/4.html#4,6">2 Kor 4,6-10</a>
letzter So. nach Epiphanias 3   #ffffff weiß    <a href="http://bibel-online.net/buch/02.2-mose/3.html#3,1">2 Mose 3,1-10(14)</a>
letzter So. nach Epiphanias 4   #ffffff weiß    <a href="http://bibel-online.net/buch/66.offenbarung/1.html#1,9">Offb 1,9-18</a>
letzter So. nach Epiphanias 5   #ffffff weiß    <a href="http://bibel-online.net/buch/43.johannes/12.html#12,34">Joh 12,34-36(41)</a>
letzter So. nach Epiphanias 6   #ffffff weiß    <a href="http://bibel-online.net/buch/61.2-petrus/1.html#1,16">2 Pet 1,16-19(21)</a>
