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
# list of Chemical Elements in German
# from http://de.wikipedia.org/wiki/Chemisches_Element
# @(#) $Id: de.sb_chemelem.pl 36 2008-09-08 06:05:06Z gfis $
# 2006-08-13, Georg Fischer

use strict;
    binmode(STDOUT, ":utf8");

    while (<DATA>) {
        next if ! m/^\|\[\[(\w+)\]\]\|\|(\w+)\|\|/;
        my $word = $1;
        next if $word =~ m/^Unun/;
        my $iso = $2;
        print "$word    =SbSgNtChem.$iso\n";
    }
__DATA__
|[[Actinium]]||Ac||89||227,0278||10,07 kg/l||1047||3197||1899||[[André-Louis Debierne|Debierne]] 
|-
|[[Aluminium]]||Al||13||26,981539||2,70 kg/l||660,5||2467||1825||[[Hans Christian Ørsted|Ørsted]]
|-
|[[Americium]]||Am||95||243,0614||13,67 kg/l||994||2607||1944||[[Glenn Theodore Seaborg|Seaborg]]
|-
|[[Antimon]]||Sb||51||121,75||6,69 kg/l||630,7||1750||prähistorisch||unbekannt
|-
|[[Argon]]||Ar||18||39,948||1,66 g/l||-189,4||-185,9||1894||[[William Ramsay|Ramsay]] und [[John William Strutt, 3. Lord Rayleigh|Rayleigh]] 
|-
|[[Arsen]]||As||33||74,92159||5,72 kg/l||613||([[Sublimation]])|| ca. 1250 || [[Albertus Magnus]]
|-
|[[Astat]]||At||85||209,9871|| ||302||337||1940||[[Dale Corson|Corson]], [[Kenneth MacKenzie|MacKenzie]] und [[Emilio Segrè|Segrè]]
|-
|[[Barium]]||Ba||56||137,327||3,65 kg/l||725||1640||1808||[[Humphry Davy|Davy]]
|-
|[[Berkelium]]||Bk||97||247,0703||13,25 kg/l||986|| ||1949||[[Glenn Theodore Seaborg|Seaborg]]
|-
|[[Beryllium]]||Be||4||9,012182||1,85 kg/l||1278||2970||1797||[[Louis-Nicolas Vauquelin|Vauquelin]]
|-
|[[Bismut]]||Bi||83||208,98037||9,80 kg/l||271,4||1560||1540||[[Georgius Agricola|Agricola]]
|-
|[[Blei]]||Pb||82||207,2||11,34 kg/l||327,5||1740||prähistorisch||unbekannt
|-
|[[Bohrium]]||Bh||107||262,1229|| || || ||1976||[[Y. Oganessian|Oganessian]]
|-
|[[Bor]]||B||5||10,811||2,46 kg/l||2300||2550||1808||[[Humphry Davy|Davy]] und [[Joseph Louis Gay-Lussac|Gay-Lussac]]
|-
|[[Brom]]||Br||35||79,904||3,14 kg/l ||-7,3||58,8||1826||[[Antoine-Jérôme Balard|Balard]]
|-
|[[Cadmium]]||Cd||48||112,411||8,64 kg/l||321||765||1817||[[Friedrich Stromeyer|Stromeyer]] und [[Carl Samuel Hermann|Hermann]] 
|-
|[[Caesium]]||Cs||55||132,90543||1,90 kg/l||28,4||690||1860||[[Gustav Robert Kirchhoff|Kirchhoff]] und [[Robert Wilhelm Bunsen|Bunsen]] 
|-
|[[Calcium]]||Ca||20||40,078||1,54 kg/l||839||1487||1808||[[Humphry Davy|Davy]]
|-
|[[Californium]]||Cf||98||251,0796||15,1 kg/l||900|| ||1950||[[Glenn Theodore Seaborg|Seaborg]]
|-
|[[Cer]]||Ce||58||140,115||6,77 kg/l||798||3257||1803||[[Wilhelm von Hisinger|von Hisinger]], [[Jöns Jakob Berzelius|Berzelius]] und [[Martin Heinrich Klaproth|Klaproth]]
|-
|[[Chlor]]||Cl||17||35,4527||2,95 g/l||-101||-34,6||1774||[[Carl Wilhelm Scheele|Scheele]]
|-
|[[Chrom]]||Cr||24||51,9961||7,14 kg/l||1857||2482||1797||[[Louis-Nicolas Vauquelin|Vauquelin]]
|-
|[[Curium]]||Cm||96||247,0703||13,51 kg/l||1340||3110||1944||[[Glenn Theodore Seaborg|Seaborg]]
|-
|[[Darmstadtium]]||Ds||110||269|| || || ||1994||[[Gesellschaft für Schwerionenforschung|GSI]] 
|-
|[[Dubnium]]||Db||105||262,1138||  ||  || ||1967/70||[[G.N. Flerow|Flerow]] oder [[Albert Ghiorso|Ghiorso]] 
|-
|[[Dysprosium]]||Dy||66||162,5||8,56 kg/l||1409||2335||1886||[[Paul Emile Lecoq de Boisbaudran|Lecoq de Boisbaudran]] 
|-
|[[Einsteinium]]||Es||99||252,0829|| ||860|| ||1952||[[Glenn Theodore Seaborg|Seaborg]]
|-
|[[Eisen]]||Fe||26||55,847||7,87 kg/l||1535||2750||prähistorisch||unbekannt
|-
|[[Erbium]]||Er||68||167,26||9,05 kg/l||1522||2510||1842||[[Carl Gustav Mosander|Mosander]] 
|-
|[[Europium]]||Eu||63||151,965||5,25 kg/l||822||1597||1901||[[Eugene Anatole Demarçay|Demaçay]]
|-
|[[Fermium]]||Fm||100||257,0951|| || || ||1952||[[Glenn Theodore Seaborg|Seaborg]] 
|-
|[[Fluor]]||F||9||18,9984032||1,58 g/l||-219,6||-188,1||1886||[[Henri Moissan|Moissan]]
|-
|[[Francium]]||Fr||87||223,0197|| ||27||677||1939||[[Marguerite Perey|Perey]] 
|-
|[[Gadolinium]]||Gd||64||157,25||7,89 kg/l||1311||3233||1880||[[Jean Charles Galissard de Marignac|de Marignac]] 
|-
|[[Gallium]]||Ga||31||69,723||5,91 kg/l||29,8||2403||1875||[[Paul Emile Lecoq de Boisbaudran|Lecoq de Boiskaudran]] 
|-
|[[Germanium]]||Ge||32||72,61||5,32 kg/l||937,4||2830||1886||[[Clemens Winkler|Winkler]]
|-
|[[Gold]]||Au||79||196,96654||19,32 kg/l||1064,4||2940||prähistorisch||unbekannt
|-
|[[Hafnium]]||Hf||72||178,49||13,31 kg/l||2150||5400||1923||[[Dirk Coster|Coster]] und [[George de Hevesy|de Hevesy]] 
|-
|[[Hassium]]||Hs||108||265|| || || ||1984||[[Gesellschaft für Schwerionenforschung|GSI]]
|-
|[[Helium]]||He||2||4,002602||0,17||-272,2||-268,9||1895||[[William Ramsay|Ramsay]], [[William Crookes|Crookes]], [[Per Teodor Cleve|Cleve]] und [[Nicolas Langlet|Langlet]]
|-
|[[Holmium]]||Ho||67||164,93032||8,78 kg/l||1470||2720||1878||[[Marc Delafontaine|Delafontaine]] und [[Jacques Louis Soret|Soret]]
|-
|[[Indium]]||In||49||114,82||7,31 kg/l||156,2||2080||1863||[[Ferdinand Reich|Reich]] und [[Theodor Richter|Richter]]
|-
|[[Iod]]||I||53||126,90447||4,94 kg/l||113,5||184,4||1811||[[Bernard Courtois|Courtois]]
|-
|[[Iridium]]||Ir||77||192,22||22,65 kg/l||2410||4130||1803||[[Smithson Tennant|Tennant]]
|-
|[[Kalium]]||K||19||39,0983||0,86 kg/l||63,7||774||1807||[[Humphry Davy|Davy]]
|-
|[[Kobalt]]||Co||27||58,9332||8,89 kg/l||1495||2870||1735||[[Georg Brandt|Brandt]]
|-
|[[Kohlenstoff]]||C||6||12,011||3,51 kg/l||3550||4827||prähistorisch||unbekannt
|-
|[[Krypton]]||Kr||36||83,8||3,48 g/l||-156,6||-152,3||1898||[[William Ramsay|Ramsay]] und [[Morris William Travers|Travers]]
|-
|[[Kupfer]]||Cu||29||63,546||8,92 kg/l||1083,5||2595||prähistorisch||unbekannt
|-
|[[Lanthan]]||La||57||138,9055||6,16 kg/l||920||3454||1839||[[Carl Gustav Mosander|Mosander]]
|-
|[[Lawrencium]]||Lr||103||260,1053|| || || ||1961||[[Albert Ghiorso|Ghiorso]]
|-
|[[Lithium]]||Li||3||6,941||0,53 kg/l||180,5||1317||1817||[[Johan August Arfwedson|Arfwedson]]
|-
|[[Lutetium]]||Lu||71||174,967||9,84 kg/l||1656||3315||1907||[[Carl Auer von Welsbach|von Welsbach]], [[Charles James|James]] und [[Georges Urbain|Urbain]]
|-
|[[Magnesium]]||Mg||12||24,305||1,74 kg/l||648,8||1107||1828||[[Antoine Bussy|Bussy]]
|-
|[[Mangan]]||Mn||25||54,93805||7,44 kg/l||1244||2097||1774||[[Johan Gottlieb Gahn|Gahn]]
|-
|[[Meitnerium]]||Mt||109||266|| || || ||1982||[[Gesellschaft für Schwerionenforschung|GSI]]
|-
|[[Mendelevium]]||Md||101||258,0986|| || || ||1955||[[Glenn Theodore Seaborg|Seaborg]]
|-
|[[Molybdän]]||Mo||42||95,94||10,28 kg/l||2617||5560||1778||[[Carl Wilhelm Scheele|Scheele]]
|-
|[[Natrium]]||Na||11||22,989768||0,97 kg/l||97,8||892||1807||[[Humphry Davy|Davy]]
|-
|[[Neodym]]||Nd||60||144,24||7,00 kg/l||1010||3127||1895||[[Carl Auer von Welsbach|von Welsbach]]
|-
|[[Neon]]||Ne||10||20,1797||0,84 g/l||-248,7||-246,1||1898||[[William Ramsay|Ramsay]] und [[Morris William Travers|Travers]]
|-
|[[Neptunium]]||Np||93||237,0482||20,48 kg/l||640||3902||1940||[[Edwin Mattison McMillan|McMillan]] und [[Philip Hauge Abelson|Abelson]] 
|-
|[[Nickel]]||Ni||28||58,69||8,91 kg/l||1453||2732||1751||[[Axel Frederic Cronstedt|Cronstedt]]
|-
|[[Niob]]||Nb||41||92,90638||8,58 kg/l||2468||4927||1801||[[Charles Hatchett|Hatchet]]
|-
|[[Nobelium]]||No||102||259,1009|| || || ||1958||[[Glenn Theodore Seaborg|Seaborg]]
|-
|[[Osmium]]||Os||76||190,2||22,61 kg/l||3045||5027||1803||[[Smithson Tennant|Tennant]]
|-
|[[Palladium]]||Pd||46||106,42||12,02 kg/l||1552||3140||1803||[[William Hyde Wollaston|Wollaston]]
|-
|[[Phosphor]]||P||15||30,973762||1,82 kg/l||44 (P4)||280 (P4)||1669||[[Hennig Brand|Brandt]]
|-
|[[Platin]]||Pt||78||195,08||21,45 kg/l||1772||3827||1557||[[Julius Caesar Scaliger|Scaliger]]
|-
|[[Plutonium]]||Pu||94||244,0642||19,74 kg/l||641||3327||1940||[[Glenn Theodore Seaborg|Seaborg]]
|-
|[[Polonium]]||Po||84||208,9824||9,20 kg/l||254||962||1898||[[Marie Curie|Curie]]
|-
|[[Praseodym]]||Pr||59||140,90765||6,48 kg/l||931||3212||1895||[[Carl Auer von Welsbach|von Welsbach]]
|-
|[[Promethium]]||Pm||61||146,9151||7,22 kg/l||1080||2730||1945||[[Jack Marinsky|Marinsky]], [[Lawrence E. Glendenin|Glendenin]] und [[Charles D. Coryell|Coryell]]
|-
|[[Protactinium]]||Pa||91||231,0359||15,37 kg/l||1554||4030||1917||[[Kasimir Fajans|Fajans]], [[O. H. Göring|Göring]],[[Otto Hahn|Hahn]] und [[Lise Meitner|Meitner]]
|-
|[[Quecksilber]]||Hg||80||200,59||13,55 kg/l||-38,9||356,6||prähistorisch||unbekannt
|-
|[[Radium]]||Ra||88||226,0254||5,50 kg/l||700||1140||1898||[[Marie Curie|Marie]] und [[Pierre Curie]] 
|-
|[[Radon]]||Rn||86||222,0176||9,23 g/l||-71||-61,8||1900||[[Friedrich Ernst Dorn|Dorn]]
|-
|[[Rhenium]]||Re||75||186,207||21,03 kg/l||3180||5627||1925||[[Walter Noddack|Noddack]], [[Ida Noddack-Tacke|Tacke]] und [[Otto Berg|Berg]]
|-
|[[Rhodium]]||Rh||45||102,9055||12,41 kg/l||1966||3727||1803||[[William Hyde Wollaston|Wollaston]]
|-
|[[Roentgenium]]||Rg||111||272|| || || ||1994||[[Gesellschaft für Schwerionenforschung|GSI]]
|-
|[[Rubidium]]||Rb||37||85,4678||1,53 kg/l||39||688||1861||[[Robert Wilhelm Bunsen|Bunsen]] und [[Gustav Robert Kirchhoff|Kirchhoff]]
|-
|[[Ruthenium]]||Ru||44||101,07||12,45 kg/l||2310||3900||1844||[[Karl Ernst Claus|Claus]]
|-
|[[Rutherfordium]]||Rf||104||261,1087|| || || ||1964/69||[[G.N. Flerow|Flerow]] oder [[Albert Ghiorso|Ghiorso]] 
|-
|[[Samarium]]||Sm||62||150,36||7,54 kg/l||1072||1778||1879||[[Paul Emile Lecoq de Boisbaudran|Lecoq de Boisbaudran]]
|-
|[[Sauerstoff]]||O||8||15,9994||1,33 g/l||-218,4||-182,9||1774||[[Joseph Priestley|Priestley]] und [[Carl Wilhelm Scheele|Scheele]]
|-
|[[Scandium]]||Sc||21||44,95591||2,99 kg/l||1539||2832||1879||[[Lars Fredrick Nilson|Nilson]]
|-
|[[Schwefel]]||S||16||32,066||2,06 kg/l||113||444,7||prähistorisch||unbekannt
|-
|[[Seaborgium]]||Sg||106||263,1182|| || || ||1974||[[G.N. Flerow|Flerow]] und [[J.C. Oganesjan|Oganessian]]
|-
|[[Selen]]||Se||34||78,96||4,82 kg/l||217||685||1817||[[Jöns Jakob Berzelius|Berzelius]]
|-
|[[Silber]]||Ag||47||107,8682||10,49 kg/l||961,9||2212||prähistorisch||unbekannt
|-
|[[Silizium]]||Si||14||28,0855||2,33 kg/l||1410||2355||1824|| [[Jöns Jakob Berzelius|Berzelius]]
|-
|[[Stickstoff]]||N||7||14,00674||1,17 g/l||-209,9||-195,8||1771||[[Carl Wilhelm Scheele|Scheele]]
|-
|[[Strontium]]||Sr||38||87,62||2,63 kg/l||769||1384||1798||[[Martin Heinrich Klaproth|Klaproth]]
|-
|[[Tantal]]||Ta||73||180,9479||16,68 kg/l||2996||5425||1802||[[Anders Gustav Ekeberg|Ekeberg]]
|-
|[[Technetium]]||Tc||43||98,9063||11,49 kg/l||2172||5030||1937||[[Carlo Perrier|Perrier]] und [[Emilio Segrè|Segrè]]
|-
|[[Tellur]]||Te||52||127,6||6,25 kg/l||449,6||990||1782||[[Franz Joseph Müller von Reichenstein|von Reichenstein]]
|-
|[[Terbium]]||Tb||65||158,92534||8,25 kg/l||1360||3041||1843||[[Carl Gustav Mosander|Mosander]]
|-
|[[Thallium]]||Tl||81||204,3833||11,85 kg/l||303,6||1457||1861||[[William Crookes|Crookes]]
|-
|[[Thorium]]||Th||90||232,0381||11,72 kg/l||1750||4787||1829||[[Jöns Jakob Berzelius|Berzelius]]
|-
|[[Thulium]]||Tm||69||168,93421||9,32 kg/l||1545||1727||1879||[[Per Teodor Cleve|Cleve]]
|-
|[[Titan (Element)|Titan]]||Ti||22||47,88||4,51 kg/l||1660||3260||1791||[[William Gregor|Gregor]] und [[Martin Heinrich Klaproth|Klaproth]]
|-
|[[Ununbium]]||Uub||112||277|| || || ||1996||[[Gesellschaft für Schwerionenforschung|GSI]]
|-
|[[Ununhexium]]||Uuh||116|| || || || ||2000||
|-
|[[Ununoctium]]||Uuo||118|| || || || || ||
|-
|[[Ununpentium]]||Uup||115|| || || || ||2006||
|-
|[[Ununquadium]]||Uuq||114|| || || || ||1999||
|-
|[[Ununseptium]]||Uus||117|| || || || || ||
|-
|[[Ununtrium]]||Uut||113|| || || || ||2006||
|-
|[[Uran]]||U||92||238,0289||18,97 kg/l||1132,4||3818||1789||[[Martin Heinrich Klaproth|Klaproth]]
|-
|[[Vanadium]]||V||23||50,9415||6,09 kg/l||1890||3380||1801||[[Andrés Manuel del Río|del Río]]
|-
|[[Wasserstoff]]||H||1||1,00794||0,084 g/l||-259,1||-252,9||1766||[[Henry Cavendish|Cavendish]]
|-
|[[Wolfram]]||W||74||183,85 g/mol||19,26 kg/l||3407||5927||1783||[[Fausto Elhuyar|Fausto]] und [[Juan José Elhuyar|Juan]] de Elhuyar
|-
|[[Xenon]]||Xe||54||131,29||4,49 g/l||-111,9||-107||1898||[[William Ramsay|Ramsay]] und [[Morris William Travers|Travers]]
|-
|[[Ytterbium]]||Yb||70||173,04||6,97 kg/l||824||1193||1878||[[Jean Charles Galissard de Marignac|de Marignac]]
|-
|[[Yttrium]]||Y||39||88,90585||4,47 kg/l||1523||3337||1794||[[Johan Gadolin|Gadolin]]
|-
|[[Zink]]||Zn||30||65,39||7,14 kg/l||419,6||907||prähistorisch||unbekannt
|-
|[[Zinn]]||Sn||50||118,71||7,29 kg/l||232||2270||prähistorisch||unbekannt
|-
|[[Zirkonium]]||Zr||40||91,224||6,51 kg/l||1852||4377||1789||[[Martin Heinrich Klaproth|Klaproth]]
