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
# Bach's cantata mapped to the destination day, with remarks
# @(#) $Id: bwv5_datum.pl 36 2008-09-08 06:05:06Z gfis $
# 2007-03-10, Dr. Georg Fischer <punctum@punctum.com>
# activation:
#   perl bwv5_datum.pl > bwv5.dic
#
# For each input line, the following rows for table INFOS
# (with dict columns ENTRY, MORPH, ENREL, MOREL) are generated:
# bwv.$bwv_no#datum#$datum#bwv5
# bwv.$bwv_no#holyd#$holyd#bwv5
# bwv.$bwv_no#remrk#$remrk#bwv5
#
# caution, this file uses UTF-8 encoding: äöüÄÖÜ
#------------------------------------------------------------
use strict;
use utf8;
    binmode(STDOUT, ":utf8");
    
    while (<DATA>) {
        s/\r?\n//; # chompr
        my ($bwv_no, $datum, $holyd, $remrk) = split(/\#/);
        if ($datum !~ m/\?/) {
            print <<"GFis";
bwv.$bwv_no#datum#$datum#bwv5
GFis
        }
        if ($holyd !~ m/\?/) {
            print <<"GFis";
bwv.$bwv_no#holyd#$holyd#bwv5
GFis
        }
        if (length($remrk) > 0) {
            print <<"GFis";
bwv.$bwv_no#remrk#$remrk#bwv5
GFis
        }
    } # while DATA          
__DATA__
1#1725-03-25#marann#
2#1724-06-18#trin2#Ps 12
3#1725-01-14#epi2#
4#1707+1????#east0#
4#1724-04-09#east0#WA
4#1725-04-01#east0#?WA
5#1724-10-15#trin19#
5#1732+3????#trin19#WA
6#1725-04-02#east0#eastP1????<----
7#1724-06-24#joabapt#
8#1724-09-24#trin16#
9#1732+3????#trin6#
10#1724-07-02#marvis#Lk 1,46-55
11#1735-05-19#chrasc#Lk 24,50-52 / Apg 1,9-12 / Mk 16,19 Oratorium
12#1714-04-22#jubil#Apg 14,22
12#1724-04-30#jubil#WA
13#1726-01-20#epi2#
14#1725-01-30#epi4#Ps 124
15#??????????#???????#(Joh.Ludwig Bach)
16#1726-01-01#circ#
16#1749-01-01#circ#WA
17#1726-09-22#trin14#Ps 50,23 / Lk 17,15-16
18#1713+2????#sexag#Jes 55,10-11
18#1724-02-13#sexag#WA
19#1726-09-29#michael#
20#1724-06-11#trin1#
21#1714-06-17#trin3#Ps 94,19 / Ps 42,12 / Ps 116,7 / Offb 5,12-13
21#1717+5????#trin3#WA
21#1723-06-13#trin3#WA
22#1723-02-07#estom#Lk 18, 31+34
23#1723-02-07#estom#
23#1724-02-20#estom#WA
23#1728+3????#estom#WA
24#1723-06-20#trin4#Mt 7,12
25#1723-08-29#trin14#Ps 38,4
26#1724-11-19#trin24#
27#1726-10-06#trin16#
28#1725-12-30#xmasS1#
28/2a#1725++??????#????#
29#1731-08-27#profan#Ps 75,2
29#1739-08-31#profan#WA
29#1749-08-25#profan#WA
30#1738+-1???#joabapt#
30a#1737-09-28#profan#
31#1715-04-21#east0#
31#1724-04-09#east0#WA
31#1731-03-25#east0#WA
32#1726-01-13#epi1#
33#1724-09-03#trin13#
34#1746+1????#pent0#Ps 128,6b
34a#1726??????#profan#Ps 128, 4-6b / Ps 128, 6b / 4 Mose 6,24-26
35#1726-09-08#trin12#
36fr#1726+4????#adv1#
36sp#1731-12-02#adv1#
36a#1726-11-30#profan#oder 1725?
36b#1735+-1????#profan#
36c#1725?04?05#profan#
37#1724-05-18#chrasc#
37#1731-05-03#chrasc#WA
38#1724-10-29#trin21#
39#1726-06-23#trin1#Jes 58,7-8 / Hebr 13,16
40#1723-12-26#xmasP2#1 Joh 3,8
40#1746+3????#xmasP2#WA
41#1725-01-01#circ#
41#1732+3????#circ#WA
42#1725-04-08#quasi#Joh 20,19 / 1 Tim 2,2
42#1731-04-01#quasi#WA
42#1742+-????#quasi#WA
43#1726-05-30#chrasc#Ps 47,6-7 / Mk 16,19
44#1724-05-21#exaud#Joh 16,2
45#1726-08-11#trin8#Micha 6,8 / Mt 7,22-23
46#1723-08-01#trin10#Klgl 1,12
47#1726-10-13#trin17#Lk 14,11
47#1735+5????#trin17#WA
47#1742+-????#trin17#WA
48#1723-10-03#trin19#Röm 7,24
49#1726-11-03#trin20#
50#??????????#michael#Offb 12,10 
51#1730-09-17?#trin15#
52#1726-11-24#trin23#
53#??????????#??????#(Melchior Hoffmann?)
54#1714??????#oculi#oder trin7?
55#1726-11-17#trin22#
56#1726-10-27#trin19#
57#1725-12-26#xmasP2#Jak 1,12
58#1727-01-05#xmasS2#
58#1733-01-04#xmasS2#WA?
58#1734-01-03#xmasS2#WA?
59#1723-05-16#pent0#1 Joh 14,23
59#1724-05-28#pent0#WA?
60#1723-11-07#trin24#1 Mose 49,18 / Offb 14,13#
61#1714-12-02#adv1#Offb 3,20#
62#1724-12-03#adv1#
62#1732+3????#adv1#WA
63#1714-12-25#xmasP1#
63#1723-12-25#xmasP1#WA
63#1729-12-25#xmasP1#WA?
64#1723-12-27#xmasP3#
64#1742+-????#xmasP3#WA
65#1724-01-06#epi#Jes 60,6
66#1724-04-10#eastP1#
66#1731-03-26#eastP1#WA
66#1735??????#eastP1#WA?
66a#1718-12-10#profan#
67#1724-04-16#quasi#2 Tim 2,8 / Joh 2,19
68#1725-05-21#pentP1#Joh 3,18
68#1735+5????#pentP1#WA
69#1748-08-26#profan#Ps 103
69a#1723-08-15#trin12#Ps 103
69a#1727-08-31#trin12#WA
70#1723-11-21#trin26#
70#1731-11-18#trin26#
70a#1716-12-06#adv2#
71#1708-02-04#profan#Ps 74,12 / 2 Sam 19,25.37 / 5 Mose 33,25 / 1 Mose 21,22b / Ps 74,16-17 / Ps 74,19
72#1726-01-27#epi3#
73#1724-01-23#epi3#
74#1725-05-20#pent0#Joh 14,23 / Joh 14,28 / Röm 8,1 
75#1723-05-30#trin1#Ps 22,27
76#1723-06-06#trin2#Ps 12,2 / Ps 67
76#1724+1????#trin2#WA
76#1740+10???#reform#WA??
77#1723-08-22#trin13#Lk 10,27
78#1724-09-10#trin14#
78#1735+5????#trin14#WA?
79#1725-10-31#reform#Ps 84,12
79#1730-10-31#reform#WA
80#1730+5????#reform#
80a#1715-03-24#oculi#
80b#1728+3????#reform#
81#1724-01-30#epi4#Ps 10,1 / Mt 8,26
82#1727-02-02#marpur#
82#1731-02-31#marpur#WA? oder 1730?
82#1735-02-02#marpur#WA
82#1746-02-02#marpur#WA? oder 1747?
82#1747-02-02#marpur#WA? oder 1748
83#1724-02-02#marpur#Lk 2,29-31 / Hebr 4,16
83#1727-02-02#marpur#WA
84#1727-02-09#septu#?
85#1725-04-15#miser#Joh 10,12 / Ps 23
86#1724-05-14#rogat#Joh 16,23
87#1725-05-06#rogat#Joh 16,24
88#1726-07-21#trin5#Jer 16,16 / Lk 5,10
89#1723-10-24#trin22#Hos 11,8
90#1723-11-14#trin25#
91#1724-12-25#xmasP1#
91#1731-12-25#xmasP1#WA? oder 1732?
91#1746-12-25#xmasP1#WA? oder 1747?
92#1725-01-28#septu#
93#1724-07-09#trin5#
93#1732+1????#trin5#WA
94#1724-08-06#trin9#
94#1732+3????#trin9#WA?
95#1723-09-12#trin16#Lk 2,29-32
96#1734-10-24#trin18#WA?
96#1747-10-01#trin18#WA?
97#1734#?????##
97#1730+5????##WA
97#1740+7????##WA
98#1726-11-10#trin21#
99#1724-09-17#trin15#
100#1734+1????#??????#
100#1737+1????#??????#WA?
100#1742+-1???#??????#WA?
101#1724-08-13#trin10#
102#1726-08-25#trin10#Jer 5,3 / Röm 2,4-5
103#1725-04-22#jubil#Joh 16,20
103#1731-04-15#jubil#WA
104#1724-04-23#miser#Ps 80,2 / Ps 23
105#1723-07-25#trin9#Ps 143,2
106#1707??????#profan#Apg 17,28 / Ps 90,12 / Jes 38,1 / Sir 14,18 / Offb 22,20 / Ps 31,6 / Lk 23,43
107#1724-07-23#trin7#
108#1725-04-29#canta#Joh 16,7 / Joh 16,13
109#1723-10-17#trin21#Mk 9,24
110#1725-12-25#xmasP1#Ps 126,2-3 / Jer 10,6 / Lk 2,14
111#1725-02-21#epi3#
112#1731-04-08#miser#Ps 23
113#1724-08-20#trin11#
114#1724-10-01#trin17#
114#1740+7????#trin17#WA
115#1724-11-05#trin22#
116#1724-11-26#trin25#
117#1728+3????#??????#
118#1736+1????#??????#Motette
119#1723-08-30#profan#Ps 147,12-14
120#1729??????#profan#Ps 65,2
120#1742+-????#profan#WA
120a#1729??????#profan#Sir 50,24
120b#1730-06-26#augsb#Ps 65,2
121#1724-12-26#xmasP2#
122#1724-12-31#xmasS1#
123#1725-01-06#epi#
124#1725-01-07#epi1#
125#1725-02-02#marpur#Lk 2,29-32
125#1730+5????#marpur#WA
126#1725-02-04#sexag#
127#1725-02-11#estom#
128#1725-05-10#chrasc#
129#1726-06-16#trin0#?
129#1732+5????#trin0#WA
129#1743+4????#trin0#WA
130#1724-09-29#michael#
131#1707??????#???????#Ps 130
132#1715-12-22#adv4#
133#1724-12-27#xmasP3#
134#1724-04-11#eastP2#
134a1719-01-01#nyear#
135#1724-06-25#trin3#Ps 6
136#1723-07-18#trin8#Ps 139,23
137#1725-08-19#trin12#?
137#1746+1????#trin12#WA
138#1723-09-05#trin15#
139#1724-11-12#trin23#
139#1744+3????#trin23#WA
140#1731-11-25#trin27#
143#1708+6????#circ#Ps 146,1.5.10a.10b
144#1724-02-06#septu#
145#1729-04-19#eastP2#oder sp.?
146#??????????#jubil#Apg 14,22 / 1726-05-12 oder 1728-04-18?
147#1723-07-02#marvis#
147#1728+3????#marvis#WA
147#1735+5????#marvis#WA
147a#1716-12-20#adv4#
148#1723-09-19#trin17#?? oder 1727-09-23?
148#1727-09-23#trin17#?? oder 1723-09-19?
149#1728-09-29#michael#Ps 118,15-16 / oder 1728?
150#1708+2????#??????#
151#1725-12-27#xmasP3#
151#1728+3????#xmasP3#
152#1714-12-30#xmasS1#
153#1724-01-02#xmasS2#
154#1724-01-09#epi1#
154#1736+1????#epi1#WA
155#1716-01-19#epi2#
155#1724-01-16#epi2#
156#1729-01-23#epi3#?
157#1728-02-02#marpur#1 Mose 32,27
158#??????????#eastP2#
159#1729-02-27#estom#Lk 18,31 / Joh 19,30 / ?? oder sp.
161#1715-10-06#trin16#oder 1716-09-27?
161#1715-09-27#trin16#oder 1715-10-06?
162#1716-10-25#trin20#oder 1715-11-03?
162#1715-11-03#trin20#oder 1716-10-25?
163#1715-11-24#trin23#
164#1725-08-26#trin13#
165#1715-06-16#trin0#
165#1724-06-04#trin0#WA 06-04?
166#1724-05-07#canta#Joh 16,5
167#1724-06-24#joabapt#oder 1723?
168#1725-07-29#trin9#
168#1746+3????#trin9#WA
169#1726-10-20#trin18#
170#1726-07-28#trin6#
170#1746+1????#trin6#WA
171#1729-01-01#circ#Ps 48,11 / oder sp.? oder 1736/37?
172#1714-05-20#pent0#Joh 14,23
172#1717+6????#pent0#WA
172#1724-05-28#pent0#WA
172#1731-05-13#pent0#WA
172#1732+?????#pent0#WA
173#1724-05-29#pentP1#
173#1731-05-14#pentP1#
173a#171?-12-10#profan#zw. 1717-22
174#1729-06-06#pentP1#
175#1725-05-22#pentP2#Joh 10,3.6
175#1726+24???#pentP2#WA
176#1725-05-27#trin0#Jer 17,9
177#1732-07-06#trin4#
177#1742+-????#trin4#
178#1724-07-30#trin8#Ps 124
179#1723-08-08#trin11#Sir 1,34
180#1724-10-22#trin20#
181#1724-02-13#sexag#
181#1743+3????#sexag#WA
182#1714-03-25#palma#Ps 40,8-9
182#1724-03-25#palma#WA
182#1728+3????#palma#WA
183#1725-05-13#exaud#Joh 16,2
184#1724-05-30#pentP2#
184#1731-05-15#pentP2#WA
185#1715-07-14#trin4#
185#1723-06-20#trin4#WA
185#1746+1????#trin4#WA
186#1723-07-11#trin7#
186#1746+3????#trin7#WA
186a#1723-12-13#adv3#
187#1726-08-04#trin7#Ps 104,27-28
187#1735+5????#trin7#WA
187#1749-07-20#trin7#WA?
188#1728-10-17#trin21#oder sp.
190#1724-01-01#circ#Ps 149,1 / Ps 150,4.6
190#1735+5????#circ#WA
190a#1730-06-25#augsb#Ps 67
191#1743+3????#xmas0#Lk 2,14
192#1730-00-00#reform#??
193#1727-08-25#profan#
194#1723-11-02#profan#
194#1723-11-02#profan#WA????<---
194#1724-06-04#trin0#WA
194#1726-06-16#trin0#WA
194#1731-05-20#trin0#WA
194a#1717+6????#??????#
195#1742+-????#profan#Ps 97,11-12
196#1708-06-05#profan#?
197#1736+1????#profan#
197a#1728-12-25#xmasP1#Lk 2,14 / oder sp.
198#1727-10-17#profan#
199#1714-08-12#trin11#
199#1718+4????#trin11#WA
199#1723-08-08#trin11#WA
200#1742+-????#marpur#
201#1729??????#profan#
201#1735+5????#profan#WA
201#1749??????#profan#WA
202#1717+6????#profan#
203#??????????#profan#
204#1726+1????#profan#
205#1725-08-03#profan#
206#1734-01-17#profan#
206#1734-10-07#profan#Auff. 1736
206#1740-08-03#profan#WA
207#1726-12-11#profan#
207a#1735-08-03#profan#oder +-?
208#1713-02-23#profan#oder -1
208a#1740-08-03#profan#
209#??????????#profan#
210#1738+3????#profan#
210a#1729-01-12#profan#
211#1734??????#profan#Kaffee-K.
212#1742-08-30#profan#Oberkeet
213#1733-09-05#profan#
214#1733-12-08#profan#
215#1734-10-05#profan#
216#1728-02-05#profan#
216a#1729+??????#profan#
