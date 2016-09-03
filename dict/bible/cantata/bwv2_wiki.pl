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
# @(#) $Id: bwv2_wiki.pl 564 2010-10-19 16:29:18Z gfis $
# Evaluate en.wikipedia.org/...Bach Cantata
# and convert the entries to morphem dictionary format 
# (entry, morph, enrel, morel)
# 2007-03-07, Dr. Georg Fischer <punctum@punctum.com>
# generate raw INSERT values for 'infos' table 
# activation:
#   perl bwv2_wiki.pl > bwv2_wiki.dic
#
# For each input line, the following rows for table INFOS
# (with dict columns ENTRY, MORPH, ENREL, MOREL) are generated:
# $entry#title#$title#bwv2
# $entry#holyd#$holyd#bwv2
#--------------------------------------------------------------------------
use strict;
use utf8;
    binmode(STDOUT, ":utf8");
    my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
    my $timestamp = sprintf ("%04d-%02d-%02dT%02d:%02d:%02d"
            , $year + 1900, $mon + 1, $mday, $hour, $min, $sec);
    # print "# generated by books.pl at $timestamp - do not edit here\n";

# evaluate arguments
    
# read DATA
    my $bwv_no  = "";
    my $title   = ""; 
    my $holyd   = ""; # code for Sunday/Holyday
    while (<DATA>) {
        s/\r?\n//; # chompr
        if (m/BWV\s*([0-9a-z]+) *\t *(.+)/) {
            $bwv_no = $1;
            $title  = $2;
            $title  =~ s/\[\[([^\]]+)\]\].*/$1/;
            if ($title =~ s/\'\'secular\'\'// > 0) {
                $holyd = "profan"
            } else {
                $holyd = "";
            }
            my $entry = "bwv.$bwv_no";
            print <<"GFis";
$entry#title#$title#bwv2
$entry#holyd#$holyd#bwv2
GFis
        }
    } # while DATA
__DATA__
* BWV 1 	 [[Wie schön leuchtet der Morgenstern]]
* BWV 2 	 [[Ach Gott, vom Himmel sieh darein]]
* BWV 3 	 [[Ach Gott, wie manches Herzeleid]]
* BWV 4 	 [[Christ lag in Todesbanden]]
* BWV 5 	 [[Wo soll ich fliehen hin]]
* BWV 6 	 [[Bleib bei uns, denn es will Abend werden]]
* BWV 7 	 [[Christ unser Herr zum Jordan kam]]
* BWV 8 	 [[Liebster Gott, wenn werd ich sterben?]]
* BWV 9 	 [[Es ist das Heil uns kommen her]]
* BWV 10 	 [[Meine Seel erhebt den Herren]]
* BWV 11 	 [[Lobet Gott in seinen Reichen]] (Himmelfahrts-Oratorium (Ascension Oratorio))
* BWV 12 	 [[Weinen, Klagen, Sorgen, Zagen]]
* BWV 13 	 [[Meine Seufzer, meine Tränen]]
* BWV 14 	 [[Wär Gott nicht mit uns diese Zeit]]
* BWV 15 	 [[Denn du wirst meine Seele nicht in der Hölle lassen]] (spurious: believed to be by [[Johann Ludwig Bach]])
* BWV 16 	 [[Herr Gott, dich loben wir]]
* BWV 17 	 [[Wer Dank opfert, der preiset mich]]
* BWV 18 	 [[Gleichwie der Regen und Schnee vom Himmel fällt]]
* BWV 19 	 [[Es erhub sich ein Streit]]
* BWV 20 	 [[O Ewigkeit, du Donnerwort]]
* BWV 21 	 [[Ich hatte viel Bekümmernis]]
* BWV 22 	 [[Jesus nahm zu sich die Zwölfe]]
* BWV 23 	 [[Du wahrer Gott und Davids Sohn]]
* BWV 24 	 [[Ein ungefärbt Gemüte]]
* BWV 25 	 [[Es ist nichts Gesundes an meinem Leibe]]
* BWV 26 	 [[Ach wie flüchtig, ach wie nichtig]]
* BWV 27 	 [[Wer weiß, wie nahe mir mein Ende]]
* BWV 28 	 [[Gottlob! nun geht das Jahr zu Ende]]
* BWV 29 	 [[Wir danken dir, Gott, wir danken dir]]
* BWV 30 	 [[Freue dich, erlöste Schar]]
* BWV 30a 	 [[Angenehmes Wiederau]] ''secular''
* BWV 31 	 [[Der Himmel lacht! Die Erde jubilieret]]
* BWV 32 	 [[Liebster Jesu, mein Verlangen]]
* BWV 33 	 [[Allein zu dir, Herr Jesu Christ]]
* BWV 34 	 [[O ewiges Feuer, o Ursprung der Liebe]]
* BWV 34a 	 O ewiges Feuer, o Ursprung der Liebe
* BWV 35 	 [[Geist und Seele wird verwirret]]
* BWV 36 	 [[Schwingt freudig euch empor]]
* BWV 36a 	 Steigt freudig in die Luft (lost)
* BWV 36b 	 Die Freude reget sich ''secular''
* BWV 36c 	 Schwingt freudig euch empor ''secular''
* BWV 37 	 [[Wer da gläubet und getauft wird]]
* BWV 38 	 [[Aus tiefer Not schrei ich zu dir]]
* BWV 39 	 [[Brich dem Hungrigen dein Brot]]
* BWV 40 	 [[Darzu ist erschienen der Sohn Gottes]]
* BWV 41 	 [[Jesu, nun sei gepreiset]]
* BWV 42 	 [[Am Abend aber desselbigen Sabbats]]
* BWV 43 	 [[Gott fähret auf mit Jauchzen]]
* BWV 44 	 [[Sie werden euch in den Bann tun]]
* BWV 45 	 [[Es ist dir gesagt, Mensch, was gut ist]]
* BWV 46 	 [[Schauet doch und sehet, ob irgend ein Schmerz sei]]
* BWV 47 	 [[Wer sich selbst erhöhet, der soll erniedriget werden]]
* BWV 48 	 [[Ich elender Mensch, wer wird mich erlösen]]
* BWV 49 	 [[Ich geh und suche mit Verlangen]]
* BWV 50 	 [[Nun ist das Heil und die Kraft]]
* BWV 51 	 [[Jauchzet Gott in allen Landen]]
* BWV 52 	 [[Falsche Welt, dir trau ich nicht]]
* BWV 53 	 [[Schlage doch, gewünschte Stunde]] (spurious: possibly by [[Georg Melchior Hoffmann]])
* BWV 54 	 [[Widerstehe doch der Sünde]]
* BWV 55 	 [[Ich armer Mensch, ich Sündenknecht]]
* BWV 56 	 [[Ich will den Kreuzstab gerne tragen]]
* BWV 57 	 [[Selig ist der Mann]] (Lehms)
* BWV 58 	 [[Ach Gott, wie manches Herzeleid (BWV 58)|Ach Gott, wie manches Herzeleid]]
* BWV 59 	 [[Wer mich liebet, der wird mein Wort halten]]
* BWV 60 	 [[O Ewigkeit, du Donnerwort]]
* BWV 61 	 [[Nun komm, der Heiden Heiland]]
* BWV 62 	 [[Nun komm, der Heiden Heiland]]
* BWV 63 	 [[Christen, ätzet diesen Tag]]
* BWV 64 	 [[Sehet, welch eine Liebe hat uns der Vater erzeiget]]
* BWV 65 	 [[Sie werden aus Saba alle kommen]]
* BWV 66 	 [[Erfreut euch, ihr Herzen]]
* BWV 66a 	 Der Himmel dacht auf Anhalts Ruhm und Glück (lost)
* BWV 67 	 [[Halt im Gedächtnis Jesum Christ]]
* BWV 68 	 [[Also hat Gott die Welt geliebt]]
* BWV 69 	 [[Lobe den Herrn, meine Seele]]
* BWV 69a 	 Lobe den Herrn, meine Seele
* BWV 70 	 [[Wachet! betet! betet! wachet!]]
* BWV 70a 	 Wachet! betet! betet! wachet!
* BWV 71 	 [[Gott ist mein König]]
* BWV 72 	 [[Alles nur nach Gottes Willen]]
* BWV 73 	 [[Herr, wie du willt, so schicks mit mir]]
* BWV 74 	 [[Wer mich liebet, der wird mein Wort halten]]
* BWV 75 	 [[Die Elenden sollen essen]]
* BWV 76 	 [[Die Himmel erzählen die Ehre Gottes]]
* BWV 77 	 [[Du sollt Gott, deinen Herren, lieben]]
* BWV 78 	 [[Jesu, der du meine Seele]]
* BWV 79 	 [[Gott der Herr ist Sonn und Schild]]
* BWV 80 	 [[Ein feste Burg ist unser Gott]]
* BWV 80a 	 [[Alles, was von Gott geboren]]
* BWV 80b 	 Ein feste Burg ist unser Gott
* BWV 81 	 [[Jesus schläft, was soll ich hoffen]]
* BWV 82 	 [[Ich habe genug]]
* BWV 83 	 [[Erfreute Zeit im neuen Bunde]]
* BWV 84 	 [[Ich bin vergnügt mit meinem Glücke]]
* BWV 85 	 [[Ich bin ein guter Hirt]]
* BWV 86 	 [[Wahrlich, wahrlich, ich sage euch]]
* BWV 87 	 [[Bisher habt ihr nichts gebeten in meinem Namen]]
* BWV 88 	 [[Siehe, ich will viel Fischer aussenden]]
* BWV 89 	 [[Was soll ich aus dir machen, Ephraim]]
* BWV 90 	 [[Es reißet euch ein schrecklich Ende]]
* BWV 91 	 [[Gelobet seist du, Jesu Christ]]
* BWV 92 	 [[Ich hab in Gottes Herz und Sinn]]
* BWV 93 	 [[Wer nur den lieben Gott läßt walten]]
* BWV 94 	 [[Was frag ich nach der Welt]]
* BWV 95 	 [[Christus, der ist mein Leben]]
* BWV 96 	 [[Herr Christ, der einge Gottessohn]]
* BWV 97 	 [[In allen meinen Taten]]
* BWV 98 	 [[Was Gott tut, das ist wohlgetan]]
* BWV 99 	 [[Was Gott tut, das ist wohlgetan]]
* BWV 100 	 [[Was Gott tut, das ist wohlgetan]]
* BWV 101 	 [[Nimm von uns, Herr, du treuer Gott]]
* BWV 102 	 [[Herr, deine Augen sehen nach dem Glauben]]
* BWV 103 	 [[Ihr werdet weinen und heulen]]
* BWV 104 	 [[Du Hirte Israel, höre]]
* BWV 105 	 [[Herr, gehe nicht ins Gericht mit deinem Knecht]] 
* BWV 106 	 [[Gottes Zeit ist die allerbeste Zeit]] (Actus Tragicus)
* BWV 107 	 [[Was willst du dich betrüben]]
* BWV 108 	 [[Es ist euch gut, daß ich hingehe]]
* BWV 109 	 [[Ich glaube, lieber Herr, hilf meinem Unglauben]]
* BWV 110 	 [[Unser Mund sei voll Lachens]]
* BWV 111 	 [[Was mein Gott will, das g'scheh allzeit]]
* BWV 112 	 [[Der Herr ist mein getreuer Hirt]]
* BWV 113 	 [[Herr Jesu Christ, du höchstes Gut]]
* BWV 114 	 [[Ach, lieben Christen, seid getrost]]
* BWV 115 	 [[Mache dich, mein Geist, bereit]]
* BWV 116 	 [[Du Friedenfürst, Herr Jesu Christ]]
* BWV 117 	 [[Sei Lob und Ehr dem höchsten Gut]]
* BWV 118 	 [[O Jesu Christ, meins Lebens Licht]]
* BWV 118b 	 O Jesu Christ, meins Lebens Licht (2nd version) 
* BWV 119 	 [[Preise, Jerusalem, den Herrn]]
* BWV 120 	 [[Gott, man lobet dich in der Stille]]
* BWV 120a 	 [[Herr Gott, Beherrscher aller Dinge]]
* BWV 120b 	 Gott, man lobet dich in der Stille 
* BWV 121 	 [[Christum wir sollen loben schon]]
* BWV 122 	 [[Das neugeborne Kindelein]]
* BWV 123 	 [[Liebster Immanuel, Herzog der Frommen]]
* BWV 124 	 [[Meinen Jesum laß ich nicht]]
* BWV 125 	 [[Mit Fried und Freud ich fahr dahin]]
* BWV 126 	 [[Erhalt uns, Herr, bei deinem Wort]]
* BWV 127 	 [[Herr Jesu Christ, wahr' Mensch und Gott]]
* BWV 128 	 [[Auf Christi Himmelfahrt allein]]
* BWV 129 	 [[Gelobet sei der Herr, mein Gott]]
* BWV 130 	 [[Herr Gott, dich loben alle wir]]
* BWV 131 	 [[Aus der Tiefen rufe ich, Herr, zu dir]]
* BWV 131a 	 Aus der Tiefen rufe ich, Herr, zu dir 
* BWV 132 	 [[Bereitet die Wege, bereitet die Bahn]]
* BWV 133 	 [[Ich freue mich in dir]]
* BWV 134 	 [[Ein Herz, das seinen Jesum lebend weiß]]
* BWV 134a 	 Die Zeit, die Tag und Jahre macht ''secular''
* BWV 135 	 [[Ach Herr, mich armen Sünder]]
* BWV 136 	 [[Erforsche mich, Gott, und erfahre mein Herz]]
* BWV 137 	 [[Lobe den Herren, den mächtigen König der Ehren]]
* BWV 138 	 [[Warum betrübst du dich, mein Herz]]
* BWV 139 	 [[Wohl dem, der sich auf seinen Gott]]
* BWV 140 	 [[Wachet auf, ruft uns die Stimme]]
* BWV 141 	 Das ist je gewißlich wahr (spurious: actually by [[Georg Philipp Telemann]])
* BWV 142 	 Uns ist ein Kind geboren (spurious: possibly by [[Johann Kuhnau]])
* BWV 143 	 Lobe den Herrn, meine Seele (doubtful: possibly not by J. S. Bach)
* BWV 144 	 [[Nimm, was dein ist, und gehe hin]]
* BWV 145 	 [[Ich lebe, mein Herze, zu deinem Ergötzen]] 
* BWV 146 	 [[Wir müssen durch viel Trübsal]]
* BWV 147 	 [[Herz und Mund und Tat und Leben]]
* BWV 147a 	 Herz und Mund und Tat und Leben
* BWV 148 	 [[Bringet dem Herrn Ehre seines Namens]]
* BWV 149 	 [[Man singet mit Freuden vom Sieg]]
* BWV 150 	 [[Nach dir, Herr, verlanget mich]]
* BWV 151 	 [[Süßer Trost, mein Jesus kömmt]]
* BWV 152 	 [[Tritt auf die Glaubensbahn]]
* BWV 153 	 [[Schau, lieber Gott, wie meine Feind]]
* BWV 154 	 [[Mein liebster Jesus ist verloren]]
* BWV 155 	 [[Mein Gott, wie lang, ach lange]]
* BWV 156 	 [[Ich steh mit einem Fuß im Grabe]]
* BWV 157 	 [[Ich lasse dich nicht, du segnest mich denn]]
* BWV 158 	 [[Der Friede sei mit dir]]
* BWV 159 	 [[Sehet, wir gehn hinauf gen Jerusalem]]
* BWV 160 	 Ich weiß, daß mein Erlöser lebt (spurious: actually by [[Georg Philipp Telemann]])
* BWV 161 	 [[Komm, du süße Todesstunde]]
* BWV 162 	 [[Ach! ich sehe, itzt, da ich zur Hochzeit gehe]]
* BWV 163 	 [[Nur jedem das Seine]]
* BWV 164 	 [[Ihr, die ihr euch von Christo nennet]]
* BWV 165 	 [[O heilges Geist- und Wasserbad]]
* BWV 166 	 [[Wo gehest du hin?]]
* BWV 167 	 [[Ihr Menschen, rühmet Gottes Liebe]]
* BWV 168 	 [[Tue Rechnung! Donnerwort]]
* BWV 169 	 [[Gott soll allein mein Herze haben]]
* BWV 170 	 [[Vergnügte Ruh, beliebte Seelenlust]]
* BWV 171 	 [[Gott, wie dein Name, so ist auch dein Ruhm]]
* BWV 172 	 [[Erschallet, ihr Lieder, erklinget, ihr Saiten]]
* BWV 173 	 [[Erhöhtes Fleisch und Blut]]
* BWV 173a 	 Durchlauchtster Leopold ''secular''
* BWV 174 	 [[Ich liebe den Höchsten von ganzem Gemüte]]
* BWV 175 	 [[Er rufet seinen Schafen mit Namen]]
* BWV 176 	 [[Es ist ein trotzig und verzagt Ding]]
* BWV 177 	 [[Ich ruf zu dir, Herr Jesu Christ]]
* BWV 178 	 [[Wo Gott der Herr nicht bei uns hält]]
* BWV 179 	 [[Siehe zu, daß deine Gottesfurcht nicht Heuchelei sei]]
* BWV 180 	 [[Schmücke dich, o liebe Seele]]
* BWV 181 	 [[Leichtgesinnte Flattergeister]]
* BWV 182 	 [[Himmelskönig, sei willkommen]]
* BWV 183 	 [[Sie werden euch in den Bann tun]]
* BWV 184 	 [[Erwünschtes Freudenlicht]]
* BWV 185 	 [[Barmherziges Herze der ewigen Liebe]]
* BWV 186 	 [[Ärgre dich, o Seele, nicht]]
* BWV 187 	 [[Es wartet alles auf dich]]
* BWV 188 	 [[Ich habe meine Zuversicht]]
* BWV 189 	 Meine Seele rühmt und preist (spurious: probably by [[Georg Melchior Hoffmann]])
* BWV 190 	 [[Singet dem Herrn ein neues Lied]]
* BWV 190a 	 Singet dem Herrn ein neues Lied (lost)
* BWV 191 	 [[Gloria in excelsis Deo]]
* BWV 192 	 [[Nun danket alle Gott]]
* BWV 193 	 [[Ihr Tore zu Zion]]
* BWV 193a 	 Ihr Häuser des Himmels (lost)
* BWV 194 	 [[Höchsterwünschtes Freudenfest]]
* BWV 195 	 [[Dem Gerechten muß das Licht]]
* BWV 196 	 [[Der Herr denket an uns]]
* BWV 197 	 [[Gott ist unsre Zuversicht]]
* BWV 197a 	 [[Ehre sei Gott in der Höhe]]
* BWV 198 	 [[Laß, Fürstin, laß noch einen Strahl]] (Trauerode) ''secular''
* BWV 199 	 [[Mein Herze schwimmt im Blut]]
* BWV 200 	 [[Bekennen will ich seinen Namen]]
* BWV 201 	 [[Geschwinde, ihr wirbelnden Winde]] (The Contest Between Phoebus and Pan) ''secular''
* BWV 202 	 [[Weichet nur, betrübte Schatten]] ''secular''
* BWV 203 	 [[Amore traditore]] ''secular''
* BWV 204 	 [[Ich bin in mir vergnügt]] ''secular''
* BWV 205 	 [[Zerreißet, zersprenget, zertrümmert die Gruft]] ''secular''
* BWV 205a 	 Blast Lärmen, ihr Feinde ''secular''
* BWV 206 	 [[Schleicht, spielende Wellen]] ''secular''
* BWV 207 	 [[Vereinigte Zwietracht der wechselnden Saiten]] ''secular''
* BWV 207a 	 Auf, schmetternde Töne ''secular''
* BWV 208 	 [[Was mir behagt, ist nur die muntre Jagd]] (Hunting Cantata) ''secular''
* BWV 208a 	 Was mir behagt, ist nur die muntre Jagd ''secular''
* BWV 209 	 [[Non sa che sia dolore]] ''secular''
* BWV 210 	 [[O holder Tag, erwünschte Zeit]] ''secular''
* BWV 210a 	 O angenehme Melodei ''secular''
* BWV 211 	 [[Coffee Cantata|Schweigt stille, plaudert nicht]] (Coffee Cantata) ''secular''
* BWV 212 	 [[Mer hahn en neue Oberkeet]] (Peasant Cantata) ''secular''
* BWV 213 	 [[Laßt uns sorgen, laßt uns wachen]] (Hercules auf dem Scheidewege) ''secular''
* BWV 214 	 [[Tönet, ihr Pauken! Erschallet, Trompeten!]] ''secular''
* BWV 215 	 [[Preise dein Glücke, gesegnetes Sachsen]] ''secular''
* BWV 216 	 [[Vergnügte Pleißenstadt]] (incomplete) ''secular''
* BWV 216a 	 Erwählte Pleißenstadt (lost) ''secular''
* BWV 217 	 [[Gedenke, Herr, wie es uns gehet]] (spurious)
* BWV 218 	 [[Gott der Hoffnung erfülle euch]] (spurious: by [[Georg Philipp Telemann]])
* BWV 219 	 [[Siehe, es hat überwunden der Löwe]] (spurious: by [[Georg Philipp Telemann]])
* BWV 220 	 [[Lobt ihn mit Herz und Munde]] (spurious)
* BWV 221 	 [[Wer sucht die Pracht, wer wünscht den Glanz]] (spurious)
* BWV 222 	 [[Mein Odem ist schwach]] (spurious: actually by [[Johann Ernst Bach]])
* BWV 223 	 [[Meine Seele soll Gott loben]] (spurious)
* BWV 224 	 [[Reißt euch los, bedrängte Sinnen]] (small fragment) (spurious)
* BWV 244a 	 [[Klagt, Kinder, klagt es aller Welt]]
* BWV 248a 	 (text unknown)
* BWV 1083 	 Tilge, Höchster, meine Sünden (arrangement of [[Giovanni Battista Pergolesi]]'s [[Stabat mater]])
* BWV Anh. 3 	 [[Gott, gib dein Gerichte dem Könige]]
* BWV Anh. 5 	 [[Lobet den Herrn, alle seine Heerscharen]]