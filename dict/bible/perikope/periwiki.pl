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
# check books from nordelbien.de/glaube
# 2007-02-07, Dr. Georg Fischer <punctum@punctum.com>: Dorothea = 97

use strict;

    print <<"GFis";
<?xml version="1.0" encoding="ISO-8859-1"?>
<html><head>
</head>
<body>
<table>
GFis

    my $eventno = 0;
    my $state = 0;
    my ($text, $votum, $psalm);
    while (<DATA>) {
        s/\r?\n//; # chompr
        s/\x96/\-/g;
        if (0) {
            s/ä/\&auml;/g;
            s/ö/\&ouml;/g;
            s/ü/\&uuml;/g;
            s/ß/\&szlig;/g;
        }
        if (0) {
        } elsif (m/^\'\'\'([^\']+)/) {
            $text = $1;
            $state = 1;
        } elsif ($state == 1) {
            if (0) {
            } elsif (m/^\*Wochenspruch/) {
                s/\*Wochenspruch\/Votum:\s*//;
                $votum = $_;
                # $votum = "";
            } elsif (m/^\*Psalm/) {
                s/^\*//;
                s/\, /\,/g;
                s/Psalm/Ps/g;
                $psalm = $_;
                $state = 0;
                $eventno ++;
                my $event = sprintf("%0002d", $eventno);
                print <<"GFis";
<tr><td>        </td><td>$event</td><td>$text</td><td>$psalm</td>
    <td>$votum</td></tr>
GFis
            }
        }
    } # while DATA
    print <<"GFis";
</table>
</body></html>
GFis

# noch in Wikipedia aendern:
# Psalm: Psalm
# mehrfach 0x96 statt '-'
# Michaelis u.a. Feiertage
# Osternacht, Aschermittwoch
# klären, woher die Varianten beim Ewigkeitssonntag stammen
# Nummernzeichen statt römischer Reihennummern an Weihnachten etc.
# ''' bei 11.So.n.Trin. + 2 Wochenspr.
# am 2007-03-04: Advents's'zeit, 8 x "*Reihen:" entf.
# Schrägstriche in Sonntagsnamen
__DATA__
==Übersicht über die evangelische Perikopenordnung nach dem [[Kirchenjahr]]==

Innerhalb der [[EKD]] gilt seit 1977/1978 die folgende Ordnung der Predigttexte und Leseabschnitte für Gottesdienste. Diese Texte werden als Empfehlungen für evangelische Gottesdienste an den jeweiligen Sonn- und Feiertagen angesehen. Es liegt im Rahmen des Kanzelrechts weithin in der Hand der verantwortlichen Pfarrer, wie sie eingesetzt werden. Die [[Presbyterium|Presbyterien]] und Kirchenvorstände entscheiden im Rahmen des Liturgierechts, der ''ius liturgica'', örtlich über die Zahl der Lesungen im Gottesdienst. Am weitesten verbreitet ist die Praxis zweier Lesungen, meist Epistel und [[Evangelium]], wobei dann über die zweite Lesung gepredigt wird; seltener werden regelmässig drei Lesungen vorgetragen, von denen jeweils eine dem [[Altes Testament|Alten Testament]], eine den Episteln und eine den Evangelien entstammen; auch in diesem Fall liegt die letzte Lesung der Predigt zu Grunde. Seit Einführung des neuen [[Evangelisches Gesangbuch|Evangelischen Gesangbuchs]] ist in vielen Gemeinden das gemeinsame Psalmgebet üblich geworden. Dieses beschränkt sich dann meist auf die im Gesangbuch abgedruckten Auszüge aus den Psalmen.
 
Zu jedem Sonn- und Feiertag im liturgischen Kalender wird aufgeführt:
*Zeile 1: Name des Tages
*Zeile 2: Wochenspruch (auch als Eingangsvotum)
*Zeile 3: Wochenpsalm
*Zeile 4 - 9: Die sechs Textreihen 

Reihe I ist immer das  [[Evangelium (Liturgie)|Evangelium des Tages]] als Leittext. Die anderen Texte sind unter Bezug darauf zusammengestellt. 

Reihe II ist immer die [[Epistel]] des Tages.

Wo eine alttestamentliche Lesung üblich ist, findet sich diese in den Reihen III - VI.

Für die Predigttexte wird ein jährlicher Wechsel entsprechend den Reihen empfohlen. 

Vom 1. Advent 2006 bis zum Ewigkeitssonntag 2007 gilt die Reihe V.

Dementsprechend ergibt sich: 
*Reihe VI  2007/2008
*Reihe I   2008/2009 (Predigttext gleich Evangelium)
*Reihe II  2009/2010 (Predigttext gleich Epistel)
*Reihe III 2010/2011
*Reihe IV  2011/2012

==Diskussion über Veränderungen==
Seit einigen Jahren wird in den evangelischen Kirchen über eine Änderung dieser Empfehlungen diskutiert. Das Anliegen der vorliegenden Ordnung ist es, möglichst viele verschiedene Texte der Bibel zur Sprache kommen zu lassen. Kritiker wenden ein, dass damit zu häufig Texte vorkommen, die Zeitgenossen des 21. Jahrhunderts nur noch mit Mühe oder gar nicht mehr ansprechen. Eine veränderte Reihe sollte mehr Konzentration auf "Basistexte" vornehmen.

==Perikopenordnungen im Ökumenischen Vergleich==
Die evangelisch-reformierte Kirche in der Schweiz hat bisher die Einführung einer Perikopenordnung abgelehnt. Praktisch hat die EKD-Ordnung dennoch einen gewissen Einfluss auch in der Schweiz, weil sich die deutschsprachige evangelische Predigtliteratur und die Hilfen zur Vorbereitung daran orientieren.

In der Katholischen Kirche gilt im deutschsprachigen Raum eine [[Leseordnung]] mit drei Textreihen (A, B, C). Diese orientieren sich am Prinzip der [[Bahnlesung]], also der fortlaufenden Lesung von biblischen Büchern.

In liturgisch geprägten Kirchen des englischsprachigen Raumes sind ebenfalls Perikopenordnungen mit drei bis vier Reihen üblich. Besonders verbreitet ist seit 1994 das "Revised Common Lectionary", das gemeinsam von Katholiken, Anglikanern, Lutheranern verantwortet wird. Es entspricht der katholischen Leseordnung, wie sie nach dem 2. Vatikanischen Konzil herausgegeben wurde, und wird  in den evangelischen Kirchen mehr oder minder frei angewandt. 

==[[Adventsszeit]]==

'''1. Sonntag im Advent'''
*Wochenspruch/Votum: Siehe, dein König kommt zu dir, ein Gerechter und ein Helfer. Sacharja 9,9
*Psalm 24
*I.     Matthäus 21, 1-9 
*II.    Römer 13, 8-12 (13-14)
*III.   Jeremia 23, 5-8
*IV.    Offenbarung 5, 1-5 (6-14)
*V. Lukas 1, 67-79 
*VI.    Hebräer 10, (19-22) 23-25 

'''2. Sonntag im Advent'''
*Wochenspruch/Votum: Seht auf und erhebt eure Häupter, weil sich eure Erlösung naht. Lukas 21, 28
*Psalm 80, 2-7; 15-20
*I.     Lukas 21, 25-33 
*II.    Jakobus 5, 7-8 (9-11)
*III.   Matthäus 24, 1-14
*IV.    Jesaja 63, 15-16 (17-19); 64, 1-3
*V. Jesaja 35, 3-10 
*VI.    Offenbarung 3, 7-13 

'''3. Sonntag im Advent'''
*Wochenspruch/Votum: Bereitet dem Herrn den Weg; denn siehe, der Herr kommt gewaltig. Jesaja 40, 3.10
*Psalm 85, 2-8
*I.     Matthäus 11, 2-6 (7-10) 
*II.    1. Korinther 4, 1-5 
*III.   Lukas 3, 1-14 
*IV.    Römer 15, (4)5-13 
*V. Jesaja 40, 1-8 (9-11) 
*VI.    Offenbarung 3, 1-6 

'''4. Sonntag im Advent'''
*Wochenspruch/Votum: Freuet euch in dem Herrn allewege, und abermals sage ich: Freuet euch! Der Herr ist nahe! Philipper 4, 4-5
*Psalm 102, 17-23
*I.     Lukas 1, (39-45) 46-55 (56) 
*II.    Philipper 4, 4-7 
*III.   Lukas 1, 26-33. (34-37) 38 
*IV.    2. Korinther 1, 18-22 
*V. Johannes 1, 19-23 (24-28) 
*VI.    Jesaja 52, 7-10

==Weihnachtszeit==

'''Heiliger Abend - Christvesper'''
*Wochenspruch/Votum: Das Wort ward Fleisch und wohnte unter uns, und wir sahen seine Herrlichkeit. Johannes 1,14b
*Psalm 96
*Reihen:
*I. Lukas 2,1-14(15-20)
*II.    Titus 2,11-14
*III.   Johannes 3,16-21
*IV.    Jesaja 9,1-6
*V. Johannes 7,28-29
*VI.    1. Timotheus 3,16

'''Heiliger Abend - Christnacht'''
*Wochenspruch/Votum: Das Wort ward Fleisch und wohnte unter uns, und wir sahen seine Herrlichkeit. Johannes 1,14b
*Psalm 2
*Reihen:
*I. Matthäus 1,(1-17) 18-21 (22-25)
*II.    Römer 1,1-7
*III.   2. Samuel 7,4-6.12-14a
*IV.    Jesaja 7,10-14
*V. Hesekiel 37,24-28
*VI.    Kolosser 2,3-10

'''Christfest - 1. Feiertag'''
*Wochenspruch/Votum: Das Wort ward Fleisch und wohnte unter uns, und wir sahen seine Herrlichkeit. Johannes 1,14b
*Psalm 96
*Reihen:
*I. Lukas 2,(1-14) 15-20
*II.    Titus 3,4-7
*III.   Micha 5,1-4a;
*IV.    1. Johannes 3,1-6
*V. Johannes 3,31-36
*VI.    Galater 4,4-7

'''Christfest - 2. Feiertag'''
*Wochenspruch/Votum: Das Wort ward Fleisch und wohnte unter uns, und wir sahen seine Herrlichkeit. Johannes 1,14b
*Psalm 96
*Reihen:
*I. Johannes 1,1-5 (6-8) 9-14
*II.    Hebräer 1,1-3 (4-6)
*III.   Johannes 8,12-16
*IV.    Jesaja 11,1-9
*V. Johannes 3,31-36
*VI.    2. Korinther 8,9

'''1. Sonntag nach dem Christfest'''
*Wochenspruch/Votum: Das Wort ward Fleisch und wohnte unter uns, und wir sahen seine Herrlichkeit. Johannes 1,14b
*Psalm 71,14-18
*Reihen:
*I. Lukas 2,(22-24) 25-38 (39-40)
*II.    1. Johannes 1,1-4
*III.   Matthäus 2,13-18 (19-23)
*IV.    1. Johannes 2,21-25
*V. Johannes 12,44-50
*VI.    Jesaja 49,13-16

'''Altjahrsabend: Silvester'''
*Wochenspruch/Votum: Barmherzig und gnädig ist der Herr, geduldig und von großer Güte. Psalm 103,8
*Psalm 121
*Reihen:
*I. Lukas 12,35-40
*II.    Römer 8,31b-39 
*III.   Jesaja 30,(8-14) 15-17
*IV.    2. Mose 13,20-22
*V. Johannes 8,31-36
*VI.    Hebräer 13,8-9b

'''Neujahrstag'''
*Wochenspruch/Votum: Alles, was ihr tut mit Worten oder mit Werken, das tut alles im Namen des Herrn Jesus uns dankt Gott, dem Vater, durch ihn. Kolosser 3,17
*Psalm 8
*Reihen:
*I. Lukas 4,16-21 (22-30)
*II.    Jakobus 4,13-15 (16-17)
*III.   Johannes 14,1-6
*IV.    Josua 1,1-9
*V. Sprüche Salomos 16,1-96
*VI.    Philipper 4,10-13 (14-20)

'''2. Sonntag nach dem Christfest'''
*Wochenspruch/Votum: Wir sahen seine Herrlichkeit, eine Herrlichkeit als des eingeborenen Sohnes vom Vater, voller Gnade und Wahrheit. Johannes 1,14
*Psalm 138, 2-5
*Reihen:
*I. Lukas 2,41-52
*II.    1. Johannes 5,11-13
*III.   Johannes 1,43-51 
*IV.    Jesaja 61,1-3 (4.9) 10-11
*V. Johannes 7,14-18
*VI.    Römer 16,25-27

'''Epiphanias'''
*Wochenspruch/Votum: Die Finsternis vergeht, und das wahre Licht scheint jetzt. 1. Johannes 2,8b
*Psalm 72, 1-3.10-13.19 oder Psalm 100
*Reihen:
*I. Matthäus 2,1-12
*II.    Epheser 3,2-3a.5-6 
*III.   Johannes 1,15-18 
*IV.    Kolosser 1,24-27
*V. Jesaja 60,1-6
*VI.    2. Korinther 4,3-6

==Nach Epiphanias und Vorfastenzeit==

'''1. Sonntag nach Epiphanias'''
*Wochenspruch/Votum: Welche der Geist Gottes treibt, die sind Gottes Kinder. Römer 8, 14
*Psalm 89, 2-6.20-23.27-30 oder Psalm 100
*I.     Matthäus 3, 13-17
*II.    Römer 12, 1-3 (4-8)
*III.   Matthäus 4, 12-17
*IV.    1. Korinther 1, 26-31
*V. Johannes 1, 29-34 
*VI.    Jesaja 42, 1-4 (5-9)

'''2. Sonntag nach Epiphanias'''
*Wochenspruch/Votum: Das Gesetz ist durch Mose gegeben; die Gnade und Wahrheit ist durch Jesus Christus geworden. Johannes 1, 17
*Psalm 105, 1-8 oder Psalm 100
*I.     Johannes 2, 1-11
*II.    Römer 12, (4-8) 9-16
*III.   2. Mose 33, 17b-23
*IV.    1. Korinther 2, 1-10
*V. Markus 2, 18-20 (21-22)
*VI.    Hebräer 12, 12-18. (19-21) 22-25a 

'''3. Sonntag nach Epiphanias'''
*Wochenspruch/Votum: Es werden kommen von Osten und von Westen, von Norden und von Süden, die zu tisch sitzen werden im Reich Gottes. Lukas 13, 29
*Psalm 86, 1-11.17 oder Psalm 100
*I.     Matthäus 8, 5-13
*II.    Römer 1, (14-15) 16-17
*III.   Johannes 4, 46-54
*IV.    2. Könige 5, (1-8) 9-15. (16-18) 19a
*V. Johannes 4, 5-14
*VI.    Apostelgeschichte 10, 21-35

'''4. Sonntag nach Epiphanias'''
*Wochenspruch/Votum: Kommt her und sehet an die Werke Gottes, der so wunderbar ist seinem Tun an den Menschenkindern. Psalm 66, 5
*Psalm 107, 1-2.23-32 oder Psalm 100
*I.     Markus 4, 35-41
*II.    2. Korinther 1, 8-11
*III.   Matthäus 14, 22-33
*IV.    Epheser 1, 15-20a 
*V. Jesaja 51, 9-16
*VI.    1. Mose 8, 1-12 

'''5. Sonntag nach Epiphanias'''
*Wochenspruch/Votum: Der Herr wird and Licht bringen, was im Finsternis verborgen ist, und wird das Trachten der Herzen offenbar machen. 1. Korinther 4,5
*Psalm 37, 1-7a
*I.     Matthäus 13, 24-30
*II.    2.Korinther 1, (4-5) 6-9
*III.   Jesaja 40, 12-25

'''Letzter Sonntag nach Epiphanias'''
*Wochenspruch/Votum: Über dir geht auf der Herr, und seine Herrlichkeit erscheint über dir. Jesaja 60,2
*Psalm 97 oder Psalm 100
*I.     Matthäus 17, 1-9
*II.    2. Korinther 4, 6-10
*III.   2. Mose 3, 1-10 (11-14)
*IV.    Offenbarung 1, 9-18 
*V. Johannes 12, 34-36 (37-41)
*VI.    2. Petrus 1, 16-19 (20-21) 

'''Septuagesimä: 3. Sonntag vor der Passionszeit'''
*Wochenspruch/Votum: Wir liegen vor dir mit unsrem Gebet und vertrauen nicht auf unsere Gerechtigkeit, sondern auf deine große Barmherzigkeit. Daniel 9, 18
*Psalm 31, 20-25
*I.     Matthäus 20, 1-16a 
*II.    1. Korinther 9, 24-27
*III.   Lukas 17, 7-10
*IV.    Jeremia 9, 22-23)
*V. Matthäus 9, 9-13 
*VI.    Römer 9, 14-24 

'''Sexagesimä: 2. Sonntag vor der Passionszeit'''
*Wochenspruch/Votum: Heute, wenn ihr seine Stimme hören werdet, so verstockt eure Herzen nicht. Hebräer 3, 15
*Psalm 119, 89-91.105.116
*I.     Lukas 8, 4-8 (9-15)
*II.    Hebräer 4, 12-13 
*III.   Markus 4, 26-29 
*IV.    2. Korinther (11, 18.23b-30)12, 1-10
*V. Jesaja 55, (6-9) 10-12a 
*VI.    Apostelgeschichte 16, 9-15

'''Estomihi: Sonntag vor der Passionszeit'''
*Wochenspruch/Votum: Seht, wir gehen hinauf nach Jerusalem, und es wird alles vollendet werden, was geschrieben ist durch die Propheten von dem Menschensohn. Lukas 18, 31
*Psalm 31, 2-6
*I.     Markus 8, 31-38
*II.    1. Korinther 13 
*III.   Lukas 10, 38-42
*IV.    Amos 5, 21-24
*V. Lukas 18, 31-43 
*VI.    Jesaja 58, 1-9a

==Passionszeit==

'''Invokavit: 1. Sonntag der Passionszeit'''
*Wochenspruch/Votum: Dazu ist erschienen der Sohn Gottes, dass er die Werke des Teufels zerstöre. 1. Johannes 3, 8
*Psalm 91, 1-4.11-12
*I.     Matthäus 4, 1-11
*II.    Hebräer 4, 14-16 
*III.   1. Mose 3, 1-19 (20-24)
*IV.    2. Korinther 6, 1-10
*V. Lukas 22, 31-34 
*VI.    Jakobus 1, 12-18

'''Reminiszere: 2. Sonntag der Passionszeit'''
*Wochenspruch/Votum: Gott erweist seine Liebe zu uns darin, dass Christus für uns gestorben ist, als wir noch Sünder waren. Römer 5, 8
*Psalm 10, 4.11-14.17-18
*I.     Markus 12, 1-12
*II.    Römer 5, 1-5 (6-11) 
*III.   Matthäus 12, 38-42
*IV.    Jesaja 5, 1-7
*V. Johannes 8, (21-26a) 26b-30
*VI.    Hebräer 11, 8-10 

'''Okuli: 3. Sonntag der Passionszeit'''
*Wochenspruch/Votum: Wer seine Hand an den Pflug legt und sieht zurück, der ist nicht geschickt für das Reich Gottes. Lukas 9, 62
*Psalm 34; 25, 16-23
*I.     Lukas 9, 57-62
*II.    Epheser 5, 1-8a 
*III.   Markus 12, 41-44 
*IV.    1. Petrus 1, (13-17) 18-21
*V. Jeremia 20, 7-11a (11b-13)
*VI.    1. Könige 19, 1-8 (9-13a) 

'''Lätare: 4. Sonntag der Passionszeit'''
*Wochenspruch/Votum: Wenn das Weizenkorn nicht in der Erde fällt und erstirbt, bleibt es allein; wenn es aber erstirbt, bringt es viel Frucht. Johannes 12, 24
*Psalm 84, 6-13
*I.     Johannes 12, 20-26
*II.    2. Korinther 1, 3-7 
*III.   Johannes 6, 55-65 
*IV.    Philipper 1, 15-21 
*V. Johannes 6, 47-51
*VI.    Jesaja 54, 7-10 

'''Judika: 5. Sonntag der Passionszeit'''
*Wochenspruch/Votum: Der Menschensohn ist nicht gekommen, dass er sich dienen lasse, sondern dass er diene und gebe sein Leben zu einer Erlösung für viele. Matthäus 20, 28
*Psalm 43
*I.     Markus 10, 35-45
*II.    Hebräer 5, 7-9
*III.   1. Mose 22, 1-13
*IV.    4. Mose 21, 4-9
*V. Johannes 11, 47-53
*VI.    Hebräer 13, 12-14

'''Palmsonntag: 6. Sonntag der Passionszeit'''
*Wochenspruch/Votum: Der Menschensohn muss erhöht werden, damit alle, die an ihn glauben, das ewige Leben haben. Johannes 3, 14-15
*Psalm 22 oder Psalm 24
*Psalm 69, 2-4.8-11.21b-22.30
*I.     Johannes 12, 12-19 
*II.    Philipper 2, 5-11
*III.   Markus 14, 3-9
*IV.    Jesaja 50, 4-9
*V. Johannes 17, 1. (2-5) 6-8
*VI.    Hebräer 12, 1-3 

'''Gründonnerstag: Tag der Einsetzung des Abendmahls'''
*Wochenspruch/Votum: Er hat ein Gedächtnis gestiftet seiner Wunder, der gnädige und barmherzige Herr. Psalm 111,4
*Psalm 111
*I.     Johannes 13, 1-15 (34-35) 
*II.    1. Korinther 11, 23-26
*III.   Markus 14, 17-26 
*IV.    1. Korinther 10, 16-17
*V. 2. Mose 12, 1.3-4.6-7.11-14
*VI.    Hebräer 2, 10-18 

'''Karfreitag: Tag der Kreuzigung des Herrn'''
*Wochenspruch/Votum: Also hat Gott die Welt geliebt, dass er seinen eingeborenen Sohn gab, damit alle, die an ihn glauben, nicht verloren werden, sondern das ewige Leben haben. Johannes 3, 16
*Psalm 22
*Wochenspruch/Votum:
*I.     Johannes 19, 16-30 
*II.    2. Korinther 5, (14b-18)19-21
*III.   Lukas 23, 33-49 
*IV.    Hebräer 9, 15.26b-28
*V. Matthäus 27, 33-50 (51-54) 
*VI.    Jesaja (52, 13-15) 53, 1-12 

'''Karsonnabend'''
*Wochenspruch/Votum: Also hat Gott die Welt geliebt, dass er seinen eingeborenen Sohn gab, damit alle, die an ihn glauben, nicht verloren werden, sondern das ewige Leben haben. Johannes 3, 16
*Psalm 88 in Auswahl oder wie Karfreitag
*I.     Matthäus 27, (57-61).62-66
*II.    1. Petrus 3, 18-22
*III.   Jona 2
*IV.    Hebräer 9, 11-12.24
*V. Johannes 19, (31-37).38-42
*VI.    Hesekiel 37, 1-14*

==Ostern, Osterzeit, Pfingsten==

'''Osternacht
*Wochenspruch/Votum: Christus spricht: Ich war tot, und siehe, ich bin lebendig von Ewigkeit zu Ewigkeit und habe die Schlüssel des Todes und der Hölle. Offenbarung 1, 18
*Psalm 118, 14-24
*I.     Matthäus 28, 1-10
*II.    Kolosser 3, 1-4
*III.   Jesaja 26, 13-14.(15-18).19*
*IV.    1. Thessalonicher 4, 13-14
*V. Johannes 5, 19-21
*VI.    2. Timotheus 2, 8a.(8b-13)

'''Ostersonntag: Tag der Auferstehung des Herrn'''
*Wochenspruch/Votum: Christus spricht: Ich war tot, und siehe, ich bin lebendig von Ewigkeit zu Ewigkeit und habe die Schlüssel des Todes und der Hölle. Offenbarung 1, 18
*Psalm 118, 14-24
*I.     Markus 16, 1-8 
*II.    1. Korinther 15, 1-11
*III.   Matthäus 28, 1-10
*IV.    1. Samuel 2, 1-2, 6-8a
*V. Johannes 20, 11-18 
*VI.    1. Korinther 15, 19-28 

'''Ostermontag'''
*Wochenspruch/Votum: Christus spricht: Ich war tot, und siehe, ich bin lebendig von Ewigkeit zu Ewigkeit und habe die Schlüssel des Todes und der Hölle. Offenbarung 1, 18
*Psalm 118, 14-24
*I.     Lukas 24, 13-35 
*II.    1. Korinther 15, 12-20 
*III.   Lukas 24, 36-45 
*IV.    1. Korinther 15, 50-58
*V. Jesaja 25, 8-9 
*VI.    Apostelgeschichte 10, 34a.36-43 

'''Quasimodogeniti: 1. Sonntag nach Ostern'''
*Wochenspruch/Votum: Gelobt sei Gott, der Vater unseres Herrn Jesus Christus, der uns nach seiner großen Barmherzigkeit wiedergeboren hat zu einer lebendigen Hoffnung durch die Auferstehung Jesu Christi von den Toten. 1. Petrus 1,3
*Psalm 116, 1-9
*I.     Johannes 20, 19-29
*II.    1. Petrus 1, 3-9
*III.   Johannes 21, 1-14
*IV.    Kolosser 2, 12-15 
*V. Markus 16, 9-14 (15-20) 
*VI.    Jesaja 40, 26-31 

'''Miserikordias Domini: 2. Sonntag nach Ostern'''
*Wochenspruch/Votum: Christus spricht: Ich bin der gute Hirte. Meine Schafe hören meine Stimme, und ich kenne sie, und sie folgen mir; und ich gebe ihnen das ewige Leben. Johannes 10, 11.27-28
*Psalm 23
*Wochenspruch/Votum:2/88; 1/92
*I.     Johannes 10, 11-16 (27-30)
*II.    1. Petrus 2, 21b-25 
*III.   Hesekiel 34, 1-2. (3-9) 10-16.31
*IV.    1. Petrus 5, 1-4 
*V. Johannes 21, 15-19 
*VI.    Hebräer 13, 20-21 

'''Jubilate: 3. Sonntag nach Ostern'''
*Wochenspruch/Votum: Ist jemand in Christus, so ist er eine neue Kreatur; das Alte ist vergangen, siehe, Neues ist geworden. 2. Korinther 5, 17
*Psalm 34
*Psalm 66, 1-9
*I.     Johannes 15, 1-8 
*II.    1. Johannes 5, 1-4 
*III.   Johannes 16, 16. (17-19) 20-23a
*IV.    2. Korinther 4, 16-18 
*V. 1. Mose 1, 1-4a.26-31; 2, 1-4a 
*VI.    Apostelgeschichte 17,22-28a(28b-34) 

'''Kantate: 4. Sonntag nach Ostern'''
*Wochenspruch/Votum: Singet dem Herrn ein neues Lied, denn er tut Wunder. Psalm 98,1
*Psalm 98
*I.     Matthäus 11, 25-30
*II.    Kolosser 3, 12-17 
*III.   Matthäus 21, 14-17 (18-22) 
*IV.    Apostelgeschichte 16, 23-34 
*V. Jesaja 12, 1-6 
*VI.    Offenbarung 15, 2-4 

'''Rogate: 5. Sonntag nach Ostern'''
*Wochenspruch/Votum: Gelobt sei Gott, der meine Gebet nicht verwirft noch seine Güte von mir wendet. Psalm 66, 20
*Psalm 95, 1-7b
*Psalm 102
*I.     Johannes 16, 23b-28. (29-32) 33
*II.    1. Timotheus 2, 1-6a 
*III.   Lukas 11, 5-13 
*IV.    Kolosser 4, 2-4 (5-6) 
*V. Matthäus 6, (5-6) 7-13 (14-15) 
*VI.    2. Mose 32, 7-14 

'''Christi Himmelfahrt'''
*Wochenspruch/Votum: Christus spricht: Wenn ich erhöht werde von der Erde, so will ich alle zu mir ziehen. Johannes 12, 32
*Psalm 47, 2-10
*I.     Lukas 24, (44-49) 50-53
*II.    Apostelgeschichte 1, 3-4. (5-7) 8-11 
*III.   1. Könige 8, 22-24. 26-28
*IV.    Offenbarung 1, 4-8 
*V. Johannes 17, 20-26 
*VI.    Epheser 1, 20b-23 

'''Exaudi: 6. Sonntag nach Ostern'''
*Wochenspruch/Votum: Christus spricht: Wenn ich erhöht werde von der Erde, so will ich alle zu mir ziehen. Johannes 12, 32
*Psalm 27, 1.7-14
*I.     Johannes 15, 26-16,4
*II.    Epheser 3, 14-21 
*III.   Johannes 7, 37-39
*IV.    Jeremia 31, 31-34 
*V. Johannes 14, 15-19 
*VI.    Römer 8, 26-30 

'''Pfingstsonntag: Tag der Ausgießung des Heiligen Geistes'''
*Wochenspruch/Votum: Es soll nicht durch Heer oder Kraft, sondern durch meinen Geist geschehen, spricht der Herr Zebaoth. Sacharja 4,6
*Psalm 118, 24-29
*I.     Johannes 14, 23-27 
*II.    Apostelgeschichte 2, 1-18
*III.   Johannes 16, 5-15 
*IV.    1. Korinther 2, 12-16 
*V. 4. Mose 11, 11-12.14-17.24-25 
*VI.    Römer 8, 1-2. (3-9) 10-11 

'''Pfingstmontag'''
*Wochenspruch/Votum: Es soll nicht durch Heer oder Kraft, sondern durch meinen Geist geschehen, spricht der Herr Zebaoth. Sacharja 4,6
*Psalm 100
*I.     Matthäus 16, 13-19 
*II.    1. Korinther 12, 4-11 
*III.   1. Mose 11, 1-9 
*IV.    Epheser 4, 11-15 (16) 
*V. Johannes 4, 19-26 
*VI.    Apostelgeschichte 2,22-23.32-33.36-39

==Sonntage nach Trinitatis==

'''Trinitatis: Tag der Dreieinigkeit'''
*Wochenspruch/Votum: Heilig, heilig, heilig ist der Herr Zebaoth, alle Lande sind seiner Ehre voll. Jesaja 6, 3
*Psalm 145
*I.     Johannes 3, 1-8 (9-15) 
*II.    Römer 11, (32) 33-36 
*III.   Jesaja 6, 1-13 
*IV.    Epheser 1, 3-14
*V. 4. Mose 6, 22-27 
*VI.    2. Korinther 13, 11 (12) 13

'''1. Sonntag nach Trinitatis'''
*Wochenspruch/Votum: Christus spricht zu seinen Jüngern: Wer euch hört, der hört mich; und wer euch verachtet, der verachtet mich. Lukas 10, 16
*Psalm 34, 2-11
*I.     Lukas 16, 19-31
*II.    1. Johannes 4, 16b-21 
*III.   Johannes 5, 39-47
*IV.    Jeremia 23, 16-29
*V. Matthäus 9, 35-38; 10, 1. (2-4) 5-7
*VI.    5. Mose 6, 4-9 

'''2. Sonntag nach Trinitatis'''
*Wochenspruch/Votum: Christus spricht: kommt her zu mir, alle, die ihr mühselig und beladen seid; ich will euch erquicken. Matthäus 11, 28
*Psalm 36, 6-11
*I.     Lukas 14, (15)16-24 
*II.    Epheser 2, 17-22 
*III.   Matthäus 22, 1-14 
*IV.    1.Korinther 14, 1-3.20-25 
*V. Jesaja 55, 1-3b (3c-5)
*VI.    1. Korinther 9, 16-23

'''3. Sonntag nach Trinitatis'''
*Wochenspruch/Votum: Der Menschensohn ist gekommen, zu suchen und selig zu machen, was verloren ist. Lukas 19,10
*Psalm 103, 1-5.8-13
*I.     Lukas 15, 1-7 (8-10) 
*II.    1. Timotheus 1, 12-17 
*III.   Lukas 15, 1-3.11b-32 
*IV.    1. Johannes 1,5-2,6 
*V. Lukas 19, 1-10 
*VI.    Hesekiel 18, 1-4.21-24.30-32 

'''4. Sonntag nach Trinitatis'''
*Wochenspruch/Votum: Einer trage des anderen Last, so werdet ihr das Gesetz Christi erfüllen. Galater 6, 2
*Psalm 42, 2-12
*I.     Lukas 6, 36-42 
*II.    Römer 14, 10-13 
*III.   1. Mose 50, 15-21 
*IV.    1. Petrus 3, 8-15a (15b-17) 
*V. Johannes 8, 3-11 
*VI.    Römer 12, 17-21 

'''5. Sonntag nach Trinitatis'''
*Wochenspruch/Votum: Aus Gnade seid ihr selig geworden durch den Glauben, und das nicht aus euch: Gottes Gabe ist es. Epheser 2, 8
*Psalm 73, 14.23-26.28
*I.     Lukas 5, 1-11 
*II.    1. Korinther 1, 18-25 
*III.   Johannes 1, 35-42 
*IV.    1. Mose 12, 1-4 
*V. Lukas 14, 25-33 
*VI.    2. Thessalonicher 3, 1-5 

'''6. Sonntag nach Trinitatis'''
*Wochenspruch/Votum: So spricht der Herr, der dich geschaffen hat: Fürchte dich nicht, denn ich habe dich erlöst; ich habe dich bei deinem Namen gerufen; du bist mein! Jesaja 43, 1
*Psalm 139, 1-16.23-24
*Wochenspruch/Votum:3/82; 4/92; 3/93
*I.     Matthäus 28, 16-20 
*II.    Römer 6, 3-8 (9-11) 
*III.   5. Mose 7, 6-12 
*IV.    Apostelgeschichte 8, 26-39 
*V. Jesaja 43, 1-7 
*VI.    1. Petrus 2, 2-10 

'''7. Sonntag nach Trinitatis'''
*Wochenspruch/Votum: So seid ihr nun nicht mehr Gäste und Fremdlinge, sondern Mitbürger der Heiligen und Gottes Hausgenossen. Epheser 2, 19
*Psalm 107, 1-9
*I.     Johannes 6, 1-15 
*II.    Apostelgeschichte 2, 41a.42-47 
*III.   Johannes 6, 30-35 
*IV.    Philipper 2,1-4 
*V. Lukas 9, 10-17 
*VI.    2. Mose 16, 2-3.11-18

'''8. Sonntag nach Trinitatis'''
*Wochenspruch/Votum: Lebt als Kinder des Lichts; die Frucht des Lichts ist lauter Güte und Gerechtigkeit und Wahrheit. Epheser 5, 8-9
*Psalm 48, 2-3a.9-11
*I.     Matthäus 5, 13-16 
*II.    Epheser 5, 8b-14 
*III.   Jesaja 2, 1-5 
*IV.    1. Korinther 6, 9-14.18-20 
*V. Johannes 9, 1-7 
*VI.    Römer 6, 19-23 

'''9. Sonntag nach Trinitatis'''
*Wochenspruch/Votum: Wem viel gegeben ist, bei dem wird man viel suchen; und wem viel anvertraut ist, von dem wird man um so mehr fordern. Lukas 12, 48
*Psalm 40, 9-12
*I.     Matthäus 25, 14-30 
*II.    Philipper 3, 7-11 (12-14) 
*III.   Matthäus 7, 24-27 
*IV.    Jeremia 1, 4-10 
*V. Matthäus 13, 44-46 
*VI.    1. Petrus 4, 7-11 

'''10. Sonntag nach Trinitatis'''
(Traditionell "Israelsonntag" genannt)
*Wochenspruch/Votum: Wohl dem Volk, dessen Gott der Herr ist, dem Volk, das er zum Erbe erwählt hat! Psalm 33, 12
*Psalm 74, 1-3.8-11.20-21
*I.     Lukas 19, 41-48 
*II.    Römer 11, 25-32 
*III.   Johannes 2, 13-22 
*IV.    Römer 9, 1-5.31;10,1-4 
*V. Jeremia 7, 1-11 (12-15) 
*VI.    2. Könige 25, 8-12 

'''11. Sonntag nach Trinitatis'''
*Wochenspruch/Votum: Gott widersteht den Hochmütigen, aber den Demütigen gibt er Gnade. 1. Petrus 5,5
*Psalm 113, 1-8
*I.     Lukas 18, 9-14
*II.    Epheser 2, 4-10 
*III.   Matthäus 21, 28-32 
*IV.    Galater 2, 16-21 
*V. Lukas 7, 36-50 
*VI.    2. Samuel 12, 1-10.13-15a 

'''12. Sonntag nach Trinitatis'''
*Wochenspruch/Votum: Das geknickte Rohr wird er nicht zerbrechen, und den glimmemden Docht wird er nicht auslöschen. Jesaja 42,3
*Psalm 147, 1-3.11-14a
*I.     Markus 7, 31-37
*II.    Apostelgeschichte 9, 1-9 (10-20) 
*III.   Jesaja 29, 17-24 
*IV.    Apostelgeschichte 3, 1-10 (11-12) 
*V. Markus 8, 22-26
*VI.    1. Korinther 3, 9-15 

'''13. Sonntag nach Trinitatis'''
*Wochenspruch/Votum: Christus spricht: Was ihr getan habt einem von diesen meinen geringsten Brüdern, das habt ihr mir getan. Matthäus 25, 40
*Psalm 112, 5-9
*I.     Lukas 10, 25-37 
*II.    1. Johannes 4, 7-12 
*III.   Markus 3, 31-35 
*IV.    1. Mose 4, 1-16a 
*V. Matthäus 6, 1-4 
*VI.    Apostelgeschichte 6, 1-7 

'''14. Sonntag nach Trinitatis'''
*Wochenspruch/Votum: Lobe den Herrn, meine Seele, und vergiss nicht, was er dir Gutes getan hat. Psalm 103, 2
*Psalm 146
*I.     Lukas 17, 11-19
*II.    Römer 8, (12-13) 14-17 
*III.   Markus 1, 40-45 
*IV.    1. Thessalonicher 1, 2-10 
*V. 1. Mose 28, 10-19a 
*VI.    1. Thessalonicher 5, 14-24 

'''15. Sonntag nach Trinitatis'''
*Wochenspruch/Votum: Alle eure Sorge werft auf ihn; denn er sorgt für euch. 1. Petrus 5, 7
*Psalm 127, 1-2
*I.     Matthäus 6, 25-43
*II.    1. Petrus 5, 5c-11 
*III.   Lukas 18, 28-30 
*IV.    Galater 5, 25-26; 6, 1-3.7-10 
*V. Lukas 17, 5-6
*VI.    1. Mose 2, 4b-9. (10-14) 15 

'''16. Sonntag nach Trinitatis'''
*Wochenspruch/Votum: Christus Jesus hat dem Tod die Macht genommen und das Leben und ein unvergängliches Wesen ans Licht gebracht durch das Evangelium. 2. Timotheus 1, 10
*Psalm 68, 1-7a.20-21
*I.     Johannes 11, 1. (2) 3.17-27 (41-45)
*II.    2. Timotheus 1, 7-10 
*III.   Klagelieder 3, 22-26.31-32 
*IV.    Apostelgeschichte 12, 1-11 
*V. Lukas 7, 11-16 
*VI.    Hebräer 10, 35-36. (37-38) 39 

'''17. Sonntag nach Trinitatis'''
*Wochenspruch/Votum: Unser Glaube ist der Sieg, der die Welt überwunden hat. 1. Johannes 5, 4
*Psalm 25, 8-15
*I.     Matthäus 15, 21-28 
*II.    Römer 10, 9-17 (18) 
*III.   Markus 9, 17-27 
*IV.    Jesaja 49, 1-6 
*V. Johannes 9, 35-41 
*VI.    Epheser 4, 1-6 

'''18. Sonntag nach Trinitatis'''
*Wochenspruch/Votum: Dies Gebot haben wir von ihm, dass, wer Gott liebt, dass der auch seinen Bruder liebe. 1. Johannes 4, 21
*Psalm 1
*I.     Markus 12, 28-34 
*II.    Römer 14, 17-19 
*III.   Markus 10, 17-27 
*IV.    Jakobus 2, 1-13 
*V. 2. Mose 20, 1-17 
*VI.    Epheser 5, 15-21

'''19. Sonntag nach Trinitatis'''
*Wochenspruch/Votum: Heile du mich, Herr, so werde ich heil; hilf du mir, so ist mir geholfen. Jeremia 17, 14
*Psalm 32, 1-5.10-11
*I.     Markus 2, 1-12 
*II.    Epheser 4, 22-32 
*III.   Markus 1, 32-39 
*IV.    Jakobus 5, 13-16 
*V. Johannes 5, 1-16 
*VI.    2. Mose 34, 4-10

'''20. Sonntag nach Trinitatis'''
*Wochenspruch/Votum: Es ist dir gesagt, Mensch, was gut ist und was der Herr von dir fordert, nämlich Gottes Wort halten und Liebe üben und demütig sein vor deinem Gott. Micha 6, 8
*Psalm 119, 101-108
*I.     Markus 10, 2-9 (10-16) 
*II.    1. Thessalonicher 4, 1-8 
*III.   1. Mose 8, 18-22 
*IV.    1. Korinther 7, 29-31 
*V. Markus 2, 23-28 
*VI.    2. Korinther 3, 3-9

'''21. Sonntag nach Trinitatis'''
*Wochenspruch/Votum: Lass dich nicht vom Bösen überwinden, sondern überwinde das Böse mit Gutem. Römer 12, 21
*Psalm 19, 10-15
*I.     Matthäus 5, 38-48 
*II.    Epheser 6, 10-17 
*III.   Matthäus 10, 34-39 
*IV.    Jeremia 29, 1.4-7.10-14
*V. Johannes 15, 9-12 (13-17) 
*VI.    1. Korinther 12, 12-14.26-27 

'''22. Sonntag nach Trinitatis'''
*Wochenspruch/Votum: Bei dir ist Vergebung, dass man dich fürchte. Psalm 130, 4
*Psalm 143, 1-10
*I.     Matthäus 18, 21-35 
*II.    Philipper 1, 3-11 
*III.   Matthäus 18, 15-20 
*IV.    Römer 7, 14-25a
*V. Micha 6, 6-8 
*VI.    1. Johannes 2, (7-11) 12-17 

'''23. Sonntag nach Trinitatis'''
*Wochenspruch/Votum: Dem König aller Könige und Herrn aller Herren, der allein Unsterblichkeit hat, dem sei Ehre und ewige Macht! 1. Timotheus 6, 15-16
*Psalm 33, 13-22
*I.     Matthäus 22, 15-22 
*II.    Philipper 3, 17. (18-19) 20-21 
*III.   Johannes 15, 18-21 
*IV.    Römer 13, 1-7 
*V. Matthäus 5, 33-37 
*VI.    1. Mose 18, 20-21. 22b-33 

'''24. Sonntag nach Trinitatis'''
*Wochenspruch/Votum: Mit Freuden sagt Dank dem Vater, der euch tüchtig gemacht hat zu dem Erbteil der Heiligen im Licht. Kolosser 1, 12
*Psalm 39, 5-8
*I.     Matthäus 9, 18-26 
*II.    Kolosser 1, (8-12) 13-20 
*III.   Prediger 3, 1-14 

==Ende des Kirchenjahres==

'''Drittletzter Sonntag des Kirchenjahres'''
*Wochenspruch/Votum: Siehe, jetzt ist die Zeit der Gnade, siehe, jetzt ist der Tag der Heils! 2. Korinther 6, 2
*Psalm 90, 1-14.(15-17)
*I.     Lukas 17, 20-24 (25-30) 
*II.    Römer 14, 7-9 
*III.   Lukas 11, 14-23
*IV.    Hiob 14, 1-6
*V. Lukas 18, 1-8 
*VI.    1. Thessalonicher 5, 1-6 (7-11) 

'''Volkstrauertag: Vorletzter Sonntag des Kirchenjahres'''
*Wochenspruch/Votum: Wir müssen alle offenbar werden vor dem Richterstuhl Christi. 2. Korinther 5, 10
*Psalm 50, 1.4-6.14-15.23
*I.     Matthäus 25, 31-46 
*II.    Römer 8, 18-23 (24-25) 
*III.   Lukas 16, 1-8 (9)
*IV.    Offenbarung 2, 8-11 
*V. Jeremia 8, 4-7 
*VI.    2. Korinther 5, 1-10 

'''Buß- und Bettag'''
*Wochenspruch/Votum: Gerechtigkeit erhöht ein Volk; aber die Sünde ist der Leute Verderben. Sprüche 14, 34
*Psalm 51, 3-14
*I.     Lukas 13, (1-5) 6-9 
*II.    Römer 2, 1-11 
*III.   Matthäus 12, 33-35 (36-37)
*IV.    Offenbarung 3, 14-22 
*V. Lukas 13, 22-27 (28-30) 
*VI.    Jesaja 1, 10-17 

'''Ewigkeitssonntag: / Letzter Sonntag des Kirchenjahres'''
*Wochenspruch/Votum: Lasst eure Lenden umgürtet sein und eure Lichter brennen. Lukas 12, 35
*Psalm 126
*I.     Matthäus 25, 1-13 / Johannes 5, 24-29 
*II.    Offenbarung 21, 1-7 / 1. Korinther 15, 35-38.42-44a 
*III.   Lukas 12, 42-48 / Daniel 12, 1b-3 
*IV.    Jesaja 65, 17-19 (20-22) 23-25 / Philipper 1, 21-26 
*V. Markus 13, 31-37 / Matthäus 22, 23-33 
*VI.    2. Petrus 3, (3-7) 8-13 / Hebräer 4, 9-11 


==Evangelische Feiertage außerhalb des Kirchenjahresschemas==

'''Erntedankfest'''
*Wochenspruch/Votum: Aller Augen warten auch dich, und du gibst ihnen Speise zur rechten Zeit. Psalm 145, 15
*Psalm 104, 10-15.27-30
*I.     Lukas 12, (13-14) 15-21 
*II.    2. Korinther 9, 6-15 
*III.   Jesaja 58, 7-12 
*IV.    1. Timotheus 4, 4-5 
*V. Matthäus 6, 19-23 
*VI.    Hebräer 13, 15-16 

'''Reformationstag: 31. Oktober'''
*Wochenspruch/Votum: Einen anderen Grund kann niemand legen als den, der gelegt ist, welcher ist Jesus Christus. 1. Korinther 3, 11
*Psalm 46, 2-8
*I.     Matthäus 5, 2-10 (11-12) 
*II.    Römer 3, 21-28 (29-30)
*III.   Matthäus 10, 26b-33 
*IV.    Galater 5, 1-6 
*V. Jesaja 62, 6-7.10-12 
*VI.    Philipper 2, 1-13

==Allgemein begangene Tage==

'''Konfirmation'''
*Psalm 67,2-8
*I.     Matthäus 7, 13-16a
*II.    1. Timotheus 6, 12-16
*III.   Johannes 6, 66-69
*IV.    1. Korinther 3, 21b-23
*V.     5. Mose 30, 11-20a
*VI.    Sprüche 3, 1-8*

'''Kirchweihe'''
*Psalm 84, 2-13
*I.     Lukas 19, 1-10
*II.    Offenbarung 21, 1-5a
*III.   Markus 4, 30-32
*IV.    Josua 24, 14-16
*V.     Jesaja 66, 1-2*
*VI.    Hebräer 8, 1-6

'''Bittgottesdienst um die Einheit der Kirche'''
*I.     Johannes 17, 1a.11b-23 oder Matthäus 13, 31.33.(34-35)
*II.    Epheser 4, 2b-7.11-16 oder 1. Korinther 1, 10-18

'''Bittgottesdienst um die Ausbreitung des Evangeliums'''
*I.     Matthäus 9, 35-38 oder Johannes 4, 32-42; Matthäus 5, 13-16; Matthäus 11, 25-30
*II.    Jesaja 42, 1-8 oder Jesaja 49, 8-13; Römer 11, 25-32; Epheser 4, 15-16; 1. Johannes 4, 7-12

'''Bittgottesdienst um Frieden'''
*I.     Matthäus 5, 2-10.(11-12) oder Matthäus 16, 1-4 oder Johannes 14, 27-31a
*II.    1. Timotheus 2, 1-4 oder Micha 4, 1-4; Philipper 4, 6-9

==Andere Gedenktage==

'''26. Dezember, Tag des Erzmärtyrers Stephanus'''
*Psalm 119, 81-82.84-86
*I.     Matthäus 10, 16-22
*II.    Apostelgeschichte (6, 8-15). 7, 55-60

'''28. Dezember, Tag der unschuldigen Kinder'''
*I.     Matthäus 2, 13-18
*II.    Offenbarung 12, 1-6.(13-17)

'''1. Januar, Tag der Beschneidung und Namensgebung Jesu'''
*Psalm 8
*I.     Lukas 2, 21
*II.    Galater 3, 26-29

'''2. Februar, Tag der Darstellung des Herrn (Lichtmess)'''
*Psalm 48, 2-3a.9-11 oder Psalm 8
*I.     Lukas 2, 22-24.(25-35)
*II.    Hebräer 2, 14-18

'''25. März, Tag der Ankündigung der Geburt des Herrn'''
*Psalm 45, 2a-3.(5.7).8.18 oder Psalm 98
*I.     Lukas 1, 26-38
*II.    Galater 4, 4-7

'''24. Juni, Tag der Geburt Johannes des Täufers'''
*Psalm 92, 2-11
*I.     Lukas 1, 57-67.(68-75).76-80
*II.    Apostelgeschichte 19, 1-7

'''29. Juni, Tag der Apostel Petrus und Paulus'''
*Psalm 89, 6-8.(16-17) oder Psalm 22, 11
*I.     Matthäus 16, 13-19
*II.    Epheser 2, 19-22

'''2. Juli, Tag der Heimsuchung Mariä'''
*Psalm 45, 2a.3.(5.7).8.18 oder Psalm 98
*I.     Lukas 1, 39-47.(48-55).56
*II.    1. Timotheus 3, 16

'''29. September, Tag des Erzengels Michael und aller Engel'''
*Psalm 103, 19-22 oder Psalm 148
*I.     Lukas 10, 17-20
*II.    Offenbarung 12, 7-12a.(12b)

'''1. November, Gedenktag der Heiligen'''
*Psalm 89, 2.6-8.(16-17) oder Psalm 22, 11
*I.     Matthäus 5, 2-19.(11-12)
*II.    Offenbarung 7, 9-12.(13-17)

==Siehe auch==
[[Leseordnung]] für den katholischen Bereich

[[Kategorie:Liturgie]]

[[en:Revised Common Lectionary]]
