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
# list of German mountain regions
# from http://de.wikipedia.org/wiki/Liste_der_Gebirge_Deutschlands
# take single words only
# @(#) $Id: de_mountain.pl 36 2008-09-08 06:05:06Z gfis $
# 2006-08-13, Georg Fischer

use strict;
    binmode(STDOUT, ":utf8");

    while (<DATA>) {
        next if ! m/\[\[/;
        m/\[\[([^\(\|\]]+)/;
        my $mountain = $1;
        $mountain =~ s/ $//;
        my $genus = "";
        $genus = "Ms" if $mountain =~ m/wald$/;
        $genus = "Nt" if $mountain =~ m/gebirge$/;
        $genus = "Ms" if $mountain =~ m/berg$/;
        $genus = "Nt" if $mountain =~ m/land$/;
        next if ($mountain =~ m/[ \-]/);
        print "$mountain    =Nm${genus}GeogRegnMont.De\n";
    }
__DATA__
|| [[Adelegg]] || [[Schwarzer Grat]] ||align="right"| 1.118 m || [[Baden-W�rttemberg]] 
|-
|| [[Ahrgebirge]] || [[Aremberg (Berg)|Aremberg]] ||align="right"| 623 m || [[Rheinland-Pfalz]] 
|-
|| [[Alpen]] || [[Zugspitze]] ||align="right"| 2.962 m || [[Bayern]] 
|-
|| [[Allg�uer Alpen]] || [[Hochfrottspitze]] ||align="right"| 2.649 m || [[Bayern]]
|-
|| [[Ankumer H�he]] || Trillenberg ||align="right"| 140 m || [[Niedersachsen]]
|-
|| [[Arnsberger Wald]] || Namenlose Bergkuppe ||align="right"| 580,9 m || [[Nordrhein-Westfalen]]
|-
|| [[Baumberge]] || [[Westerberg (Baumberge)|Westerberg]] ||align="right"| 187 m || [[Nordrhein-Westfalen]]
|-
|| [[Bayerische Alpen]] || [[Zugspitze]] ||align="right"| 2.962 m || [[Bayern]] 
|-
|| [[Bayerischer Wald]] || [[Gro�er Arber]] ||align="right"| 1.456 m || [[Bayern]] 
|-
|| [[Bergstra�e]] || [[Melibokus]] ||align="right"| 517 m || [[Hessen]]
|-
|| [[Binger Wald]] || [[Kandrich]] ||align="right"| 637 m || [[Rheinland-Pfalz]]
|-
|| [[Brohmer Berge]] || Ein Berg bei Matzdorf ||align="right"| 153 m || [[Mecklenburg-Vorpommern]] 
|-
|| [[B�ckeberg]] || [[B�ckeberg]] ||align="right"| 367 m || [[Niedersachsen]] 
|-
|| [[Burgwald (Mittelgebirge)|Burgwald]] || [[Knebelsrod]] ||align="right"| 443 m || [[Hessen]] 
|-
|| [[Chiemgauer Alpen]] || [[Sonntagshorn]] ||align="right"| 1.961 m || [[Bayern]] 
|-
|| [[Dammer Berge]] || [[Signalberg]] ||align="right"| 146 m || [[Niedersachsen]]
|-
|| [[Deister]] || [[Br�hn]] ||align="right"| 405 m || [[Niedersachsen]] 
|-
|| [[Dransfelder Stadtwald]] || [[Hoher Hagen (Dransfeld)|Hoher Hagen]] ||align="right"| 508 m || [[Niedersachsen]]
|-
|| [[D�n]] || Rondel ||align="right"| 522 m || [[Th�ringen]] 
|-
|| [[Ebbegebirge]] || [[Nordhelle (Ebbegebirge)|Nordhelle]] ||align="right"| 663 m || [[Nordrhein-Westfalen]] 
|-
|| [[Eggegebirge]] || [[Preu�ischer Velmerstot]] ||align="right"| 468 m || [[Nordrhein-Westfalen]] 
|-
|| [[Eifel]] || [[Hohe Acht]] ||align="right"| 747 m || [[Rheinland-Pfalz]]
|-
|| [[Elbsandsteingebirge]] || [[Gro�er Zschirnstein]] ||align="right"| 561 m || [[Sachsen]] 
|-
|| [[Elstergebirge]] || [[Hoher Brand]] ||align="right"| 805 m || [[Sachsen]] 
|-
|| [[Erzgebirge]] || [[Fichtelberg (Erzgebirge)|Fichtelberg]] ||align="right"| 1.215 m || [[Sachsen]] 
|-
|| [[Fahner H�he]] || Abtsberg ||align="right"| 413 m || [[Th�ringen]] 
|-
|| [[Fichtelgebirge]] || [[Schneeberg (Fichtelgebirge)|Schneeberg]] ||align="right"| 1.053 m || [[Bayern]] 
|-
|| [[Finne (H�henzug)|Finne]] || K�nzelsberg ||align="right"| 380 m || [[Th�ringen]] 
|-
|| [[Frankenwald]] || [[D�braberg]] ||align="right"| 794 m || [[Bayern]]
|-
|| [[Fl�ming]] || [[Hagelberg]] ||align="right"| 200,2 m || [[Brandenburg]]
|-
|| [[Gr�dener Berge]] || [[Heideh�he]] ||align="right"| 201,4 m || [[Brandenburg]]
|-
|| [[Habichtswald (Mittelgebirge)|Habichtswald]] || [[Hohes Gras]] ||align="right"| 614,7 m || [[Hessen]] 
|-
|| [[Hainich]] || Alter Berg ||align="right"| 494 m || [[Th�ringen]] 
|-
|| [[Hainleite]] || ? ||align="right"| 464 m || [[Th�ringen]] 
|-
|| [[Harly-Wald]] || [[Harlyberg]] ||align="right"| 256 m || [[Niedersachsen]] 
|-
|| [[Harrl]] || [[Harrlberg]] ||align="right"| 211 m || [[Niedersachsen]] 
|-
|| [[Harz (Mittelgebirge)|Harz]] || [[Brocken]] ||align="right"| 1.141,1 m || [[Sachsen-Anhalt]] 
|-
|| [[Ha�berge (Mittelgebirge)|Ha�berge]] || [[Nassacher H�he]] ||align="right"| 506 m || [[Bayern]]
|-
|| [[Hellberge]] || [[Langer Berg (Altmark)]] ||align="right"| 159,90 m || [[Sachsen-Anhalt]]
|-
|| [[Hildesheimer Wald]] || [[Griesberg]] ||align="right"| 359 m || [[Niedersachsen]] 
|-
|| [[Hils]] || [[Blo�e Zelle]] ||align="right"| 480,4 m || [[Niedersachsen]]
|-
|| [[H�gl]] || [[H�gl]]        ||align="right"|827 m || [[Bayern]]  
|-
|| [[Hoher Mei�ner]] || [[Kasseler Kuppe]] ||align="right"| 753,6 m || [[Hessen]]
|-
|| [[Hohe Schrecke]] || Schulzenberg ||align="right"| 320 m || [[Th�ringen]] 
|-
|| [[Holsteinische Schweiz]] || [[Bungsberg]] ||align="right"|168 m|| [[Schleswig-Holstein]]
|-
|| [[Hunsr�ck]] || [[Erbeskopf]] ||align="right"| 816 m || [[Rheinland-Pfalz]] 
|-
|| [[Huy (H�henzug)|Huy]] || [[Buchenberg (Huy)|Buchenberg]] ||align="right"| 314 m || [[Sachsen-Anhalt]] 
|-
|| [[Ith]] || [[Lauensteiner Kopf]] ||align="right"| 439 m || [[Niedersachsen]] 
|-
|| [[Kaiserstuhl (Baden)|Kaiserstuhl]] || [[Totenkopf (Kaiserstuhl)|Totenkopf]] ||align="right"| 557 m || [[Baden-W�rttemberg]] 
|-
|| [[Karwendel]] || [[�stliche Karwendelspitze]] ||align="right"| 2.537 m || [[Bayern]] 
|-
|| [[Kaufunger Wald]] || [[Hirschberg (Kaufunger Wald)|Hirschberg]] ||align="right"| 643 m || [[Hessen]] 
|-
|| [[Kellerwald (Mittelgebirge)|Kellerwald]] || [[W�stegarten]] ||align="right"| 675 m || [[Hessen]] 
|-
|| [[Kleiner Deister]] || Wolfsk�pfe ||align="right"| 345 m || [[Niedersachsen]] 
|-
|| [[Kn�llgebirge]] || [[Eisenberg (Kn�ll)|Eisenberg]] ||align="right"| 636 m || [[Hessen]] 
|-
|| [[K�hlung (H�henzug)|K�hlung]] || [[Diedrichshagener Berg]] ||align="right"| 129,7 m || [[Mecklenburg-Vorpommern]] 
|-
|| [[Kyffh�user]] || [[Kulpenberg]] ||align="right"| 477 m || [[Th�ringen]] 
|-
|| [[Lahnberge]] || Ortenberg ||align="right"| 380 m || [[Hessen]] 
|-
|| [[Landr�cken (Mittelgebirge)|Landr�cken]] || [[Frauenstein (Landr�cken)|Frauenstein]] ||align="right"| 596 m || [[Hessen]] 
|-
|| [[Lange Berge]] || [[Buchberg (Lange Berge)|Buchberg]] ||align="right"| 528 m || [[Bayern]] 
|-
|| [[Langenberg (Mittelgebirge)|Langenberg]] || [[Schwengeberg]] ||align="right"| 557 m || [[Hessen]] 
|-
|| [[Langer Wald]] || [[Weidelsburg|Weidelsberg]] ||align="right"| 492 m || [[Hessen]] 
|-
|| [[Leinebergland]] || [[Blo�e Zelle]] ||align="right"| 480,4 m || [[Niedersachsen]] 
|-
|| [[Lennegebirge]] || [[Homert (Lennegebirge)|Homert]] ||align="right"| 656 m || [[Nordrhein-Westfalen]]
|-
|| [[L�neburger-Heide]] || [[Wilseder Berg]] ||align="right"| 169,2 m || [[Niedersachsen]]
|-
|| [[Marburger R�cken]] || Vogelheerd  ||align="right"| 369,8 m || [[Hessen]] 
|-
|| [[M�ggelberge]] || Gro�er M�ggelberg ||align="right"| 115,4 m || [[Berlin]] 
|-
|| [[Nesselberg]] || Grasberg ||align="right"| 375 m || [[Niedersachsen]] 
|-
|| [[N�rdliche Kalkalpen]] || [[Zugspitze]] ||align="right"| 2.962 m || [[Bayern]] 
|-
|| [[Nordpf�lzer Bergland]] || [[Donnersberg]] ||align="right"| 687 m || [[Rheinland-Pfalz]] 
|-
|| [[Oberpf�lzer Wald]] || [[Gibacht]] ||align="right"| 938 m || [[Bayern]] 
|-
|| [[Odenwald]] || [[Katzenbuckel]] ||align="right"| 626 m || [[Baden-W�rttemberg]] 
|-
|| [[Ohmgebirge]] || Birkenberg ||align="right"| 533 m || [[Th�ringen]] 
|-
|| [[Osterwald]] || Fast ||align="right"| 419 m || [[Niedersachsen]] 
|-
|| [[Pf�lzer Wald]] || [[Donnersberg]] ||align="right"| 687 m || [[Rheinland-Pfalz]] 
|-
|| [[Reinhardswald]] || [[Gahrenberg]] ||align="right"| 472 m || [[Hessen]] 
|-
|| [[Reinsberge]] || Reinsburg ||align="right"| 604 m || [[Th�ringen]] 
|-
|| [[Richelsdorfer Gebirge]] || [[Herzberg (Richelsdorfer Gebirge)|Herzberg]] ||align="right"| 478 m || [[Hessen]] 
|-
|| [[Rh�n]] || [[Wasserkuppe]] ||align="right"| 950,2 m || [[Hessen]] 
|-
|| [[Rothaargebirge]] || [[Langenberg (Rothaargebirge)|Langenberg]] ||align="right"| 843,1 m || [[Hessen]] u. [[Nordrhein-Westfalen]]
|-
|| [[S�chsische Schweiz]] || [[Gro�er Zschirnstein]] ||align="right"| 561 m || [[Sachsen]] 
|-
|| [[Schelderwald]] || [[Angelburg (Berg)|Angelburg]] ||align="right"| 609 m || [[Hessen]] 
|-
|| [[Schlierbachswald]] || [[Rabenkuppe]] ||align="right"| 515 m || [[Hessen]] 
|-
|| [[Schm�cke (H�henzug)|Schm�cke]] || Scharfer Berg ||align="right"| 249 m || [[Th�ringen]] 
|-
|| [[Schurwald]] || [[Kernen (Berg)|Kernen]] ||align="right"| 513,2 m || [[Baden-W�rttemberg]] 
|-
|| [[Schw�bische Alb]] || [[Lemberg (Berg)|Lemberg]] ||align="right"| 1.015 m || [[Baden-W�rttemberg]] 
|-
|| [[Schwarzwald]] || [[Feldberg im Schwarzwald|Feldberg]] ||align="right"| 1.493 m || [[Baden-W�rttemberg]] 
|-
|| [[Seulingswald]] || [[Toter Mann (Seulingswald)|Toter Mann]] ||align="right"| 480 m || [[Hessen]] 
|-
|| [[Sieben Berge (H�henzug)|Sieben Berge]] || [[Hohe Tafel]] ||align="right"| 395 m || [[Niedersachsen]] 
|-
|| [[Siebengebirge]] || [[Gro�er �lberg]] ||align="right"| 460,1 m || [[Nordrhein-Westfalen]] 
|-
|| [[Solling]] || [[Gro�e Bl��e]] ||align="right"| 528 m || [[Niedersachsen]] 
|-
|| [[S�hre]] || [[Himmelsberg]] ||align="right"| 563,7 m || [[Hessen]] 
|-
|| [[Soonwald]] || [[Ellerspring]] ||align="right"| 657 m || [[Rheinland-Pfalz]]
|-
|| [[Spessart]] || [[Geiersberg (Spessart)|Geiersberg]] ||align="right"| 586 m || [[Bayern]] 
|-
|| [[St�lzinger Gebirge]] || [[Alheimer]] ||align="right"| 549 m || [[Hessen]] 
|-
|| [[Taunus]] || [[Gro�er Feldberg]] ||align="right"| 880 m || [[Hessen]] 
|-
|| [[Teutoburger Wald]] || [[Barnacken]] ||align="right"| 446 m || [[Nordrhein-Westfalen]] 
|-
|| [[Th�ringer Schiefergebirge]] || [[Gro�er Farmdenkopf]] ||align="right"| 869 m || [[Th�ringen]] 
|-
|| [[Th�ringer Wald]] || [[Gro�er Beerberg]] ||align="right"| 982,9 m || [[Th�ringen]] 
|-
|| [[Upland]] || [[Langenberg (Rothaargebirge)|Langenberg]] ||align="right"| 843,1 m || [[Hessen]] u. [[Nordrhein-Westfalen]]
|-
|| [[Vogelsberg]] || [[Taufstein (Vogelsberg)|Taufstein]] ||align="right"| 773 m || [[Hessen]] 
|-
|| [[Vogler]] || [[Ebersnacken]] ||align="right"| 460 m || [[Niedersachsen]] 
|-
|| [[Westerwald]] || [[Fuchskaute]] ||align="right"| 657 m || [[Rheinland-Pfalz]] 
|-
|| [[Weserbergland]] || [[Gro�e Bl��e]] ||align="right"| 528 m || [[Niedersachsen]] 
|-
|| [[Wettersteingebirge]] || [[Zugspitze]] ||align="right"| 2.962 m || [[Bayern]] 
|-
|| [[Wiehengebirge]] || [[Heidbrink]] ||align="right"| 320 m || [[Nordrhein-Westfalen]] 
|-
|| [[Windleite]] || Zimmerberg ||align="right"| 374 m || [[Th�ringen]] 
|-
|| [[Wingst (H�henzug)|Wingst]] || [[Silberberg (Wingst)|Silberberg]] ||align="right"| 74 m || [[Niedersachsen]]
|-
|| [[Zittauer Gebirge]] || [[Lausche]] ||align="right"| 793 m || [[Sachsen]] 
