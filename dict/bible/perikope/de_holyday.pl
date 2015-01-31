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
# German holy day names and abbreviations
# from de.wikipedia.org
# @(#) $Id: de_holyday.pl 36 2008-09-08 06:05:06Z gfis $
# 2007-03-05, Dr. Georg Fischer <punctum@punctum.com>
# activation:
#   perl de_holyday.pl [abbr|html|xml]
#
# caution, this file uses UTF-8 encoding: äöüÄÖÜ
#------------------------------------------------------------
use strict;
use utf8;
    binmode(STDOUT, ":utf8");

# evaluate arguments
    my $action = shift(@ARGV);
    
# read DATA
    while (<DATA>) {
        s/\r?\n//; # chompr
        my ($lang, $attr, $holyd, $name_short, $name_long, $expr) = split(/\#/);
        if (0) {
        } elsif ($action eq "abbr") {
            print "$holyd\n";
        } elsif ($action eq "dict") {
            print <<"GFis";
$holyd#nams.$lang#$name_short#$attr
$holyd#naml.$lang#$name_long#$attr
$holyd#expr#$expr#
GFis
        } else {
            print STDERR "invalid action code $action\n";
        }
    } # while DATA          
    
# unclear: hfriday II, Leidensgesch. = Mt 27,1-52?
__DATA__
de#ev,ka,pol#adv1#1. Advent#1. Sonntag im Advent#adv1+0
de#ev,ka,pol#adv2#2. Advent#2. Sonntag im Advent#adv1+7
de#ev,ka,pol#adv3#3. Advent#3. Sonntag im Advent#adv1+14
de#ev,ka,pol#adv4#4. Advent#4. Sonntag im Advent#adv1+21
de#ev,ka,pol#xmas0#Heiliger Abend#Heiliger Abend#fix=12-24
de#ev,  ,pol#xmas0#Christvesper#Heiliger Abend - Christvesper#fix=12-24:18
de#ev,  ,pol#xmas0#Christnacht#Heiliger Abend - Christnacht#fix=12-24:22
de#ev,ka,pol#xmasP1#1. Weihnachstag#Christfest - 1. Feiertag#fix=12-25
de#ev,ka,pol#xmasP2#2. Weihnachtstag#Christfest - 2. Feiertag#fix=12-26
de#ev,ka,pol#xmasD1#1. So.n.Weihn.#1. Sonntag nach dem Christfest#epi1-14
de#ev,ka,pol#silv#Sivester#Altjahrsabend: Silvester#fix=12-31
de#ev,ka,pol#nyear#Neujahrstag#Neujahrstag#fix=01-01
de#ev,ka,pol#xmasD9#2. So.n.Weihn.#2. Sonntag nach dem Christfest#epi1-7
de#ev,  ,   #epi#Epiph.#Epiphanias#fix=01-06
de#  ,ka,pol#3koen#Hl. 3 Kön.#Heilige 3 Könige#fix=01-06
de#ev,ka,pol#epi1#1. So.n.Epiph.#1. Sonntag nach Epiphanias#epi1+0
de#ev,ka,pol#epi2#2. So.n.Epiph.#2. Sonntag nach Epiphanias#epi1+7
de#ev,ka,pol#epi3#3. So.n.Epiph.#3. Sonntag nach Epiphanias#epi1+14
de#ev,ka,pol#epi4#4. So.n.Epiph.#4. Sonntag nach Epiphanias#epi1+21
de#ev,ka,pol#epi5#5. So.n.Epiph.#5. Sonntag nach Epiphanias#epi1+28
de#ev,ka,pol#epi9#Letzter So.n.Epiph.#Letzter Sonntag nach Epiphanias#east-70
de#ev,ka,pol#septu#Septuagesimä#Septuagesimä: 3. Sonntag vor der Passionszeit#east-63
de#ev,ka,pol#sexag#Sexagesimä#Sexagesimä: 2. Sonntag vor der Passionszeit#east-56
de#ev,ka,pol#estom#Estomihi#Estomihi: Sonntag vor der Passionszeit#east-49
de#ev,ka,pol#fast0#Rosenmontag#Rosenmontag#east-48
de#ev,ka,pol#fast1#Fastnacht#Fastnachtsdienstag#east-47
de#ev,ka,pol#fast2#Aschermittw.#Aschermittwoch#east-46
de#ev,ka,pol#invoc#Invokavit#Invokavit: 1. Sonntag der Passionszeit#east-42
de#ev,ka,pol#remin#Reminiszere#Reminiszere: 2. Sonntag der Passionszeit#east-35
de#ev,ka,pol#oculi#Okuli#Okuli: 3. Sonntag der Passionszeit#east-28
de#ev,ka,pol#laeta#Lätare#Lätare: 4. Sonntag der Passionszeit#east-21
de#ev,ka,pol#judic#Judika#Judika: 5. Sonntag der Passionszeit#east-14
de#ev,ka,pol#palma#Palmsonntag#Palmsonntag: 6. Sonntag der Passionszeit#east-7
de#ev,ka,pol#eastM3#Gründonnerstag#Gründonnerstag: Tag der Einsetzung des Abendmahls#east-3
de#ev,ka,pol#eastM2#Karfreitag#Karfreitag: Tag der Kreuzigung des Herrn#east-2
de#ev,ka,pol#eastM1#Karsonnabend#Karsonnabend#east-1
de#ev,ka,pol#east0#Ostersonntag#Ostersonntag: Tag der Auferstehung des Herrn#east+0
de#ev,ka,pol#eastP1#Ostermontag#Ostermontag#east+1
de#ev,ka    #eastP2#Osterdienstag#Osterdienstag#east+2
de#ev,  ,pol#quasi#Quasimodogeniti#Quasimodogeniti: 1. Sonntag nach Ostern#east+7
de#  ,ka,pol#quasi#Weißer Sonntag#Weißer Sonntag#east+7
de#ev,ka,pol#miser#Miserikordias Dom.#Miserikordias Domini: 2. Sonntag nach Ostern#east+14
de#ev,ka,pol#jubil#Jubilate#Jubilate: 3. Sonntag nach Ostern#east+21
de#ev,ka,pol#canta#Kantate#Kantate: 4. Sonntag nach Ostern#east+28
de#ev,ka,pol#rogat#Rogate#Rogate: 5. Sonntag nach Ostern#east+35
de#ev,ka,pol#chrasc#Christi Himmelf.#Christi Himmelfahrt#east+39
de#ev,ka,pol#exaud#Exaudi#Exaudi: 6. Sonntag nach Ostern#east+42
de#ev,ka,pol#pent0#Pfingsten#Pfingstsonntag: Tag der Ausgießung des Heiligen Geistes#east+49
de#ev,ka,pol#pentP1#Pfingstmontag#Pfingstmontag#east+50
de#ev,ka,pol#trin#Trinitatis#Trinitatis: Tag der Dreieinigkeit#east+56
de#ev,ka,pol#trin1#1. So.n.Trin.#1. Sonntag nach Trinitatis#trin+7
de#  ,ka,pol#fronl#Fronleichnam#Fronleichnam#
de#ev,ka,pol#marasc#Mariä Himmelf.#Mariä Himmelfahrt#fix=08-15
de#ev,ka,pol#trin2#2. So.n.Trin.#2. Sonntag nach Trinitatis#trin+14
de#ev,ka,pol#trin3#3. So.n.Trin.#3. Sonntag nach Trinitatis#trin+21
de#ev,ka,pol#trin4#4. So.n.Trin.#4. Sonntag nach Trinitatis#trin+28
de#ev,ka,pol#trin5#5. So.n.Trin.#5. Sonntag nach Trinitatis#trin+35
de#ev,ka,pol#trin6#6. So.n.Trin.#6. Sonntag nach Trinitatis#trin+42
de#ev,ka,pol#trin7#7. So.n.Trin.#7. Sonntag nach Trinitatis#trin+49
de#ev,ka,pol#trin8#8. So.n.Trin.#8. Sonntag nach Trinitatis#trin+56
de#ev,ka,pol#trin9#9. So.n.Trin.#9. Sonntag nach Trinitatis#trin+63
de#ev,ka,pol#trin10#10. So.n.Trin.#10. Sonntag nach Trinitatis#trin+70
de#ev,ka,pol#trin11#11. So.n.Trin.#11. Sonntag nach Trinitatis#trin+77
de#ev,ka,pol#trin12#12. So.n.Trin.#12. Sonntag nach Trinitatis#trin+84
de#ev,ka,pol#trin13#13. So.n.Trin.#13. Sonntag nach Trinitatis#trin+91
de#ev,ka,pol#trin14#14. So.n.Trin.#14. Sonntag nach Trinitatis#trin+98
de#ev,ka,pol#trin15#15. So.n.Trin.#15. Sonntag nach Trinitatis#trin+105
de#ev,ka,pol#trin16#16. So.n.Trin.#16. Sonntag nach Trinitatis#trin+112
de#ev,ka,pol#trin17#17. So.n.Trin.#17. Sonntag nach Trinitatis#trin+119
de#ev,ka,pol#trin18#18. So.n.Trin.#18. Sonntag nach Trinitatis#trin+126
de#ev,ka,pol#trin19#19. So.n.Trin.#19. Sonntag nach Trinitatis#trin+133
de#  ,  ,pol#wverein#T.d.Wiedervereinig.#Tag der deutschen Wiedervereinigung#fix=10-03
de#ev,ka,pol#trin20#20. So.n.Trin.#20. Sonntag nach Trinitatis#trin+140
de#ev,ka,pol#trin21#21. So.n.Trin.#21. Sonntag nach Trinitatis#trin+147
de#ev,ka,pol#trin22#22. So.n.Trin.#22. Sonntag nach Trinitatis#trin+154
de#ev,ka,pol#trin23#23. So.n.Trin.#23. Sonntag nach Trinitatis#trin+161
de#ev,ka,pol#trin24#24. So.n.Trin.#24. Sonntag nach Trinitatis#trin+168
de#ev,ka,pol#martin#Martini#Martinstag#fix=11-11
de#ev,ka,pol#trin97#3.letzter So.im Kj.#Drittletzter Sonntag des Kirchenjahres#adv1-21
de#ev,ka,pol#trin98#Volkstrauertag#Volkstrauertag: Vorletzter Sonntag des Kirchenjahres#adv1-14
de#ev,  ,pol#busbet#Buß- und Bettag#Buß- und Bettag#adv1-11
de#ev,  ,   #trin99#Ewigkeitssonntag#Ewigkeitssonntag: Letzter Sonntag des Kirchenjahres#adv1-7
de#  ,ka,pol#trin99#Totensonntag#Totensonntag: Letzter Sonntag des Kirchenjahres#adv1-7
de#ev,ka,pol#erndank#Erntedankfest#Erntedankfest#
de#ev,  ,pol#reform#Reformationstag#Reformationstag: 31. Oktober#fix=10-31
de#ev,  ,   #konfir#Konfirmation#Konfirmation#
de#ev,  ,   #kirchw#Kirchweihe#Kirchweihe#
de#ev,  ,   #keinht#f.d.Einheit d.K.#Bittgottesdienst um die Einheit der Kirche#
de#ev,  ,   #evangm#f.d.Ausbr. d.Ev.#Bittgottesdienst um die Ausbreitung des Evangeliums#
de#ev,  ,   #friede#f.d.Frieden#Bittgottesdienst um Frieden#
de#ev,ka,   #steph#Stephanus#26. Dezember, Tag des Erzmärtyrers Stephanus#fix=12-26
de#ev,ka,   #kinder#Unsch. Kinder#28. Dezember, Tag der unschuldigen Kinder#fix=12-28
de#ev,ka,pol#circ#Jesu Darst.#1. Januar, Tag der Beschneidung und Namensgebung Jesu#fix=01-01
de#ev,ka,pol#marpur#Lichtmess#2. Februar, Tag der Darstellung des Herrn (Lichtmess)#fix=02-02
de#ev,ka,   #marann#Mariä Ankünd.#25. März, Tag der Ankündigung der Geburt des Herrn#fix=03-25
de#ev,ka,pol#joabapt#Johannis#24. Juni, Tag der Geburt Johannes des Täufers#fix=06-24
de#ev,ka,pol#pepaul#Peter+Paul#29. Juni, Tag der Apostel Petrus und Paulus#fix=06-29
de#ev,ka,   #marvis#Mariä Heims.#2. Juli, Tag der Heimsuchung Mariä#fix=07-02
de#ev,ka,pol#michael#Michaelis#29. September, Tag des Erzengels Michael und aller Engel#fix=09-29
de#ev,ka,pol#hallow#Allerheiligen#1. November, Gedenktag der Heiligen#fix=11-01
de#  ,ka,pol#hallos#Allerseelen#Allerseelen#fix=11-02
