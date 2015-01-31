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
# generate several tables for Epistel and Evangelium
# after Luther and in Germany in the 19th century;
# from my grandfathers evangelic songbook (about 1884)
# @(#) $Id: luther_perikope.pl 36 2008-09-08 06:05:06Z gfis $
# 2007-02-28, Dr. Georg Fischer <punctum@punctum.com>
# activation:
#   perl luther_perikope.pl [abbr|html|xml]
#
# caution, this file is ISO-8859-1 encoded: äöüÄÖÜ
#------------------------------------------------------------
use strict;
#use utf8;
#   binmode(STDOUT, ":utf8");

# evaluate arguments
    my $action = shift(@ARGV);
    
# read DATA
    if (0) {
    } elsif ($action eq "abbr") {
        while (<DATA>) {
            s/\r?\n//; # chompr
            s/\s*\/\s*/\t/g; # multiple references separated by "/"
            my ($day, @refs) = split (/\;/);
            foreach my $ref (@refs) {
                $ref =~ m/(\d\s*)?([a-zA-ZäöüÄÖÜß]+)/;
                print "$2\n";
            } # foreach
        } # while DATA
    } elsif ($action eq "html") {
# the following requires online access to the DTD
# <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
#     "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
# <html xmlns="http://www.w3.org/1999/xhtml">
        print <<'GFis';
<?xml version="1.0" encoding="ISO-8859-1"?>
<html>
<head>
<title>Perikopen im 19. Jahrhundert</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link rel="stylesheet" title="all" type="text/css" href="stylesheet.css" />
</head>
<body>
<h2>Perikopen im 19. Jahrhundert</h2>
<table border="1" summary="Perikopen im 19. Jahrhundert">
<tr><th>Tag</th>
<th>Epistel     &lt; 1880</th>
<th>Evangelium  &lt; 1880</th>
<th>Epistel     &gt;= 1880</th>
<th>Evangelium  &gt;= 1880</th>
<th>Lesung AT</th>
</tr>
GFis
        while (<DATA>) {
            s/\r?\n//; # chompr
            my ($day, @refs) = split (/\;/);
            my $iref = 0;
            print "<tr valign=\"top\"><td>$day</td>";
            foreach my $ref (@refs) {
                $iref ++;
                $ref =~ s/\s*\/\s*/\<br \/\>/g;
                print "<td col=\"$iref\">$ref</td>";        
            } # foreach
            while ($iref < 5) {
                print "<td col=\"$iref\">&#xa0;</td>";      
                $iref ++;
            } # while < 5
            print "</tr>\n";
        } # while DATA          
        print <<'GFis';
</table>
</body></html>
GFis
    } elsif ($action eq "xml") {
        print <<'GFis';
<?xml version="1.0" encoding="ISO-8859-1"?>
<html><head>
</head>
<body>
<table>
GFis
        while (<DATA>) {
            s/\r?\n//; # chompr
            my ($day, @refs) = split (/\;/);
            my $iref = 0;
            print "<tr><td>$day</td>";
            foreach my $ref (@refs) {
                $iref ++;
                $ref =~ s/\s*\/\s*/\<br \/\>/g;
                print "<td col=\"$iref\">$ref</td>";        
            } # foreach
            while ($iref < 5) {
                print "<td col=\"$iref\"></td>";        
                $iref ++;
            } # while < 5
            print "</tr>\n";
        } # while DATA          
        print <<'GFis';
</table>
</body></html>
GFis
    } else {
        print STDERR "invalid action code $action\n";
    }
# unclear: hfriday II, Leidensgesch. = Mt 27,1-52?
__DATA__
adv1;Röm 13,11-14;Mt 21,1-9;Hebr 10,19-25;Lk 1,68-79;Jer 31,31-34
adv2;Röm 15,4-13;Lk 21,25-36;2 Petr 1,3-11;Lk 17,20-30;Mal 3,19-24
adv3;1 Kor 4,1-5;Mt 11,2-10;2 Tim 4,5-8;Mt 3,1-11;Jes 40,1-8
adv4;Phil 4,4-7;Joh 1,19-28;1 Joh 1,1-4;Joh 1,15-18;5 Mose 18,15-19
xmas.1225;Tit 2,11-14/Jes 9,2-7;Lk 2,1-14;1 Joh 3,1-5;Mt 1,18-23;Jes 9,6-7
steph.1226;Tit 3,4-7;Lk 2,15-20;Hebr 1,1-6;Joh 1,1-14;Micha 5,1-3
johap.1227;Hebr 1,1-12/Sir 15,1-8/1 Joh 1;Joh 1,1-14/Joh 21,20-24
xmas1;Gal 4,1-7;Lk 2,33-40;2 Kor 5,1-9;Lk 2,25-32/Joh 12,35-41;Jes 63,7-16
year.0101;Gal 3,23-29;Lk 2,21;Röm 8,24-32;Lk 4,16-21;Ps 90,1-17/Ps 121
xmas2;1 Petr 4,12-19/1 Petr 3,20-22/Tit 3,4-7;Mt 2,13-23;Jak 4,13-17;Mt 16,1-4;Ps 73,23-28
bapt.0113;Mt 3,13-17
epi0;Jes 60,1-6;Mt 2,1-12 ;2 Kor 4,3-6;Mt 3,13-17;Jes 2,2-5
epi1;Röm 12,1-6;Lk 2,41-52;2 Kor 6,14-7,1;Joh 1,35-42;Ps 122
epi2;Röm 12,7-16;Joh 2,1-11;1 Kor 2,6-16;Joh 1,43-51;Jes 61,1-6
epi3;Röm 12,17-21;Mt 8,1-13;Röm 1,13-20;Joh 4,5-14;2 Kön 5,1-19a
epi4;Röm 13,(1-)8-10;Mt 8,23-27;Röm 7,7-16;Joh 4,31-42;Ps 93
epi5;Kol 3,12-17;Mt 13,24-30;Röm 8,1-9;Mt 7,24-29;Hes 33,10-16
epi99;2 Petr 1,16-21/Kol 3,18-4,1;Mt 17,1-9;2 Kor 3,12-18;Joh 5,39-47;2 Mose 3,1-6
lent_3;1 Kor 9,24-27;Mt 20,1-16;Phil 1,27-2,4;Lk 10,38-42;Jer 9,23-24
lent_2;2 Kor 12,1-10;Lk 8,4-15;Phil 1,12-21;Joh 11,20-27;Amos 8,11-12
lent_1;1 Kor 13;Lk 18,31-43;1 Kor 1,21-31;Mk 10,35-45/Joh 11,47-57;Jer 8,4-9
lent1;2 Kor 6,1-10;Mt 4,1-11;Hebr 4,15-16;Mt 16,21-26/Lk 22,39-46;1 Mose 22,1-14
lent2;1 Thess 4,1-12;Mt 15,21-28;1 Joh 2,12-17;Lk 10,17-20/Lk 22,54-62;2 Mose 33,17-23
lent3;Eph 5,1-9;Lk 11,14-28;1 Petr 1,13-16;Lk 9,51-56/Lk 22,63-71;Jer 26,1-15
lent4;Röm 5,1-11;Joh 6,1-15;2 Kor 7,4-10;Joh 6,47-57/Mt 27,15-31;Jes 52,7-10
lent5;Hebr 9,11-15;Joh 8,46-59;1 Petr 1,17-25;Joh 13,31-35/Lk 23,27-34a;4 Mose 21,4-9
lent6;Phil 2,5-11;Mt 21,1-9/Joh 12,12-18;Hebr 12,1-6;Joh 12, 1-8;Sach 9,8-12
hsupper;1 Kor 11,23-32;Joh 13,1-15;1 Kor 10,16-17;Lk 22,14-20;Ps 111
hfriday;Jes 53;Mt 27,1-52;2 Kor 5,14-21;Lk 23,39-46;Ps 22,2-20
eastsun;1 Kor 5,7b-8;Mk 16,1-8;1 Kor 15,12-20;Mt 28,1-10;Ps 118,14-24
eastmon;Apg 10,34-41;Lk 24,13-35;1 Kor 15,54-58;Joh 20,11-18;Ps 16,8-11
east1;1 Joh 5,1-5;Joh 20,19-31;1 Petr 1,3-9;Joh 21,15-19;1 Mose 32,22-31
east2;1 Petr 2,21-25;Joh 10,12-16;Eph 2,4-10;Joh 14,1-6;Ps 23
east3;1 Petr 2,11-20;Joh 16,16-23a;1 Joh 4,9-14;Joh 12,20-26;Jes 40,26-31
east4;Jak 1,16-21;Joh 16,5-15;2 Tim 2,8-13;Joh 6,60-69;Ps 98
east5;Jak 1,22-27;Joh 16,23b-33;1 Tim 2,1-6;Lk 11,5-13;Jes 55,6-11
ascensn;Apg 1,1-11;Mk 16,14-20;Kol 3,1-14;Lk 24,50-53/Joh 17,11-26;Ps 110,1-4
east6;1 Petr 4,8-11;Joh 15,26-16,4;Eph 1,15-23;Joh 7,33-39;Ps 42
pent;Apg 2,1-13;Joh 14,23-31;Eph 2,19-22;Joh 14,15-21;Hes 36,22-28
pentmon;Apg 10,42-48;Joh 3,16-21;Eph 4,11-16;Joh 15,9-16;Jes 44,1-6
trin0;Röm 11,33-36;Joh 3,1-15;Eph 1,3-14;Mt 28,16-20/2 Kor 13,11-13;Jes 6,1-8/4 Mose 6,22-27
trin1;1 Joh 4,16-21;Lk 16,19-31;Apg 4,32-25;Mt 13,31-35;5 Mose 6,4-13
trin2 ;1 Joh 3,13-18;Lk 14,16-24;Röm 10,1-15;Mt 9,9-13;Spr 9,1-10
trin3;1 Petr 5,5b-11;Lk 15,1-10;Apg 3,1-16;Lk 15,11-32;Jes 12
trin4;Röm 8,18-27;Lk 6,36-42;Apg 4,1-12;Mt 5,13-16;Jes 6,1-19.24-25
trin5;1 Petr 3,8-15;Lk 5,1-11;Apg 5,34-42;Lk 9,18-26;Klgl 3,22-32
trin6;Röm 6,3-11;Mt 5,20-26;Apg 8,26-38;Mt 21,28-32;Ps 1
trin7;Röm 6,19-23;Mt 9,35-38;1 Tim 6,6-12;Mk 4,26-29;Jes 62,6-12
trin8;Röm 8,12-17;Mt 7,13-23;Apg 16,16-32;Mt 12,46-50;Jer 23,16-29
trin9;1 Kor 10,1-13;Lk 16,1-12;Apg 17,16-34;Mt 13,44-46;Spr 16,1-9
trin10;1 Kor 12,1-11;Lk 19,41-48;Apg 20,17-38;Mt 23,34-39;Jer 7,1-11
trin11;1 Kor 15,1-10;Lk 18,9-14;Röm 8,33-39;Lk 7,36-50;Dan 9,15-18
trin12;2 Kor 3,4-9;Mk 7,31-37;Apg 16,9-15;Joh 8,31-36;Jes 29,18-21
trin13;Röm 3,21-28;Lk 10,23-37;1 Petr 2,1-10;Mk 12,41-44;Sach 7,4-10
trin14;Gal 5,16-24;Lk 17,11-19;1 Tim 1,12-17;Joh 5,1-14;Ps 50,14-23
trin15;Gal 5,25-6,10;Mt 6,24-34;2 Thess 3,6-13;Joh 11,1-11;1 Kön 17,8-16
trin16;Eph 3,13-21;Lk 7,11-17;Hebr 12,18-24;Mt 11,25-30;Hiob 5,17-26
trin17;Eph 4,1-6;Lk 14,1-11;Hebr 4,9-13;Mt 12,1-8;Ps 75,5-8
trin18;1 Kor 1,4-9;Mt 22,34-46;Jak 2,10-17;Mk 10,17-27;2 Chr 1,7-12
trin19;Eph 4,22-32;Mt 9,1-8;Jak 5,13-20;Joh 9,24-41;Ps 32,1-7
trin20;Eph 5,15-21;Mt 22,1-14;Röm 14,1-9;Joh 15,1-8;Spr 2,1-8
trin21;Eph 6,10-17;Joh 4,47-54;Eph 6,1-9;Mk 10,13-16;2 Sam 7,17-29
trin22;Phil 1,3-11;Mt 18,21-35;Hebr 13,1-9;Lk 9,57-62;Spr 24,14-20
trin23;Phil 3,17-21;Mt 22,15-22;1 Tim 4,4-11;Mt 10,24-33;Ps 85,9-14
trin24;Kol 1,9-14;Mt 9,18-2?;1 Thess 5,14-24;Joh 10,23-30;Ps 39,5-14
trin25;1 Thess 4,13-18;Mt 24,15-28;Hebr 10,32-39;Joh 5,19-29;Hiob 14,1-5
trin26;2 Thess 1,3-10;Mt 25,31-36;Offb 2,8-11;Lk 19,11-27;Ps 126
trin99;2 Petr 3,3-14;Mt 15,1-13;Offb 7,9-17;Lk 12,35-43;Jes 35,3-10
fix1031;Gal 5,1-15;Mt 5,1-12;1 Kor 3,11-23;Joh 2,13-17;Ps 46
erntedank;Ps 145,15-21;Lk 12,15-21;2 Kor 9,6-11;Joh 6,24-29;Ps 24,2-9
bussbet;Röm 2,1-11;Lk 13,1-9;Hebr 12,12-17;Mt 11,16-24;Ps 130
marrein.0202;Mal 3,1-4;Lk 2,22-32;1 Joh 5,9-15;Mt 21,42-44;Ps 96,1-10
marank.0325;Jes 7,10-16;Lk 1,26-38;Röm 5,12-21;Joh 18,33-40;Ps 2
johann.0624;Jes 40,1-8;Lk 1,57-80;Apg 19,1-7;Mk 6,17-29;Jes 54,7-10
marheim.0702;Jes 11,1-5;Lk 1,39-56;Röm 16,1-5a;Joh 19,26-27;Ps 8,2-6
michael.0929;Offb 12,7-12;Mt 18,1-11;Offb 5,11-14;Joh 12,28-32;1 Mose 28,10-22
kirchweih;Offb 21,1-5;Lk 19,1-10;2 Tim 3,14-17;Joh 4,21-24;Ps 84
andreas.1130;Röm 10,8-18;Mt 4,18-22
niko.1206;2 Kor 1,3-7;Lk 12,35-40
paul.0125;Apg 9,1-22;Mt 19,27-30
mathias.0225;Apg 1,15-26;Mt 11,25-30
easttue;Apg 13,26-33;Lk 24,36-48
philjak.0503;Eph 2,19-22/Weish 5,1-22;Joh 14,1-14
penttue;Apg 8,14-17/Apg 2,29-36;Joh 10,1-11
petpaul.0629;Apg 12,1-11;Mt 16,13-20
marmagd.0722;Spr 31,10-31;Lk 7,36-50
jakob.0725;Röm 8,28-39;Mt 20,20-23
lauren.0810;2 Kor 9,6-10;Joh 12,24-26
barthol.0824;2 Kor 4,5-10/Eph 2,19-22;Lk 22,24-30
margeb.0908;Sir 24,22-31;Mt 1,1-16
kreuzerh.0914;Phil 2,5-11;Joh 12,31-36
matthae.0921;1 Kor 12,4-11/Eph 4,7-14;Mt 9,9-13
simonjud.1028;1 Petr 1,3-9;Joh 15,17-21
reform.1031;Offb 14,6-7;Mt 11,12-15
halow.1101;Offb 7,2-3;Mt 5,1-12
