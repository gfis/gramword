# Substantives for irregular German verbs
# @(#) $Id: sb_irreg_vb.pl 36 2008-09-08 06:05:06Z gfis $
# 2006-05-27: UTF-8
# 2004-06-27, Georg Fischer
# caution, must be stored in UTF-8 encoding: äöüÄÖÜß!
# output in UTF-8; no real *.dic format because of $(SHIELD)

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
use strict;

    my %genus = 
        (   'f', 'Fm'
        ,   'm', 'Ms'
        ,   'n', 'Nt'
        );
print <<'GFis';
# German substantives derived from strong verbs
# @(#) $Id: sb_irreg_vb.pl 36 2008-09-08 06:05:06Z gfis $
# 2006-07-31, Georg Fischer
# caution, stored in UTF-8 encoding: äöüÄÖÜß

GFis
    while (<DATA>) {
        next if m/^\#/;
        next if m/^\s*$/;
        my ($vb, $sb, $art) = ("", "", "");
        ($vb, $sb, $art) = split;
        if ($sb ne "") {
            $art = $genus{$art};
            print "$sb\t=SbSg$art\t$vb\tVbInStrg\n";
        };
    }

__DATA__
backen      Gebäck f
bedingen
befehlen    Befehl  m
befleißen  Fleiß  m
beginnen    Beginn  m
behüten    Hut f
beißen Biss    m
bergen  
bersten 
besinnen        
bewegen
biegen  Bogen   m
bieten  Gebot   n
binden  Band    n
bitten  Bitte   f
blasen  Blase   f
bleiben Bleibe  f
bleichen    Bleiche f
braten  Braten  m
brechen Bruch   m
brennen Brand   m
bringen 
dünken 
dürfen 
denken  Gedanke m
dingen  
drängen    Drang   m
dreschen    Dresche f
dringen     Drang   m
empfangen   Empfang m
empfehlen   
empfinden   
entfernen   
erlösen    
erschallen  
erschrecken 
erwägen    
essen   Essen   n
färben Farbe   f
fahren  Fuhre   f
fallen  Fall    m
falten  Falte   f
fangen  Fang    m
fechten Gefecht n
finden  Fund    m
flechten    Flechte f
fließen    Fluss   m
fliegen Flug    m
fliehen Flucht  m
fressen Fraß   m
frieren 
gären
gebären    Geburt  f
geben   Gabe    f
gebieten    Gebot   n
gedeihen
gefallen    Gefallen    m
gehen   Gabe    f
gelingen    
gelten
genesen
genießen   Genuss  m
geschehen   
gewinnen    Gewinn  m
gießen Guss    m
gleichen    
gleiten 
glimmen 
graben  Graben  m
greifen Griff   m
hängen Hang    m
haben   Habe    f
halten  Halt    m
hauen   Hieb    m
heben   Hub m
heißen 
helfen  Hilfe   f
können
küren  Kür    f
küssen Kuss    m
kacheln Kachel  f
kennen  
kichern 
klimmen Klamm   f
klingen Klang   m
kneifen Kniff   m
kommen  
kriechen    
kuschen
lächeln    
lügen  Lug m
laden   Lade    f
landen  Land    n
lassen  
laufen  Lauf    m
leiden  Leid    n
leihen  Leihe   f
lesen   
liegen  Lage    f
loten   Lot n
mögen  
müssen Muss    n
mahlen  Mühle  f
meiden  
melken  Molke   f
messen  Maß    n
misslingen  
missverstehen
nehmen  
nennen
pfeifen Pfiff   m
pflegen Pflege  f
preisen Preis   m
quellen Quelle  f
raten   Rat m
reißen Riss    m
reiben  Reibe   f
reiten  Ritt    m
rennen  
riechen Geruch  m
ringen  Ring    m
rinnen  Rinne   f
rufen   Ruf m
salzen  Salz    n
saufen  Suff    m
saugen  Sog m
schaffen    
schallen    Schall  m
scheißen   Schiss  m
scheiden    Scheide f
scheinen    Schein  m
schelten    Schelte f
scheren Schur   f
schießen   Schuss  m
schieben    Schub   m
schinden    Schund  m
schlafen    Schlaf  m
schlagen    Schlag  m
schleißen  Schliss m
schleichen  Schlich m
schleifen   Schliff m
schließen  Schluss m
schlingen   Schlinge    f
schmeißen  Schmiss m
schmelzen   Schmelze    f
schnauben   
schneiden   Schnitt m
schrecken   Schecken    m
schreiben   Schrieb m
schreien    Schrei  m
schreiten   Schritt m
schwören   Schwur  m
schweigen   
schwellen   Schwelle    f
schwimmen   Schwamm m
schwinden   Schwund m
schwingen   Schwung m
sehen   Gesicht f   
sein    
senden  
sieden  Sud m
singen  Sang    m
sinken  
sinnen  Sinn    m
sitzen  Sitz    m
sollen  Soll    n
spalten Spalt   m
speien  
spinnen Spinne  f
spleißen
sprechen    Spruch  m
sprießen   Spross  m
springen    Sprung  m
stechen Stich   m
stecken Stecken m
stehen  Stand   m
stehlen 
steigen Steige  f
sterben 
stieben 
stinken Gestank m
stoßen Stoß   m
streichen   Strich  m
streiten    Streit  m
trügen Trug    m
tragen  Trage   f
treffen Treff   m
treiben Trieb   m
treten  Tritt   m
triefen Traufe  f
trinken Trank   m
tun Tat f
verderben   Verderben   n   
verdrießen Verdruss    m
vergessen   Vergessen   n
verlöschen
verlieren   Verlust m
vermaßen
verschleißen   Verschliss  m
verstehen   Verstand    m
verzeihen
verzweifeln Zweifel m
wägen  Waage   f
wachsen Wuchs   m
warten  Warte   f
waschen Wäsche f
weichen 
weisen  Weise   f
wenden  Wende   f
werben  Gewerbe n
werden
werfen  Wurf    m
wiegen  Waage   f
winden  Winde   f
winken  Wink    m
wissen  
wollen  Wille   m
wringen
zeihen
ziehen  Zug m
zwingen Zwang   m
