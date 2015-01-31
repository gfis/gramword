# "primary" (simple) German adjectives, 
# (mostly) not derived from other word classes
# @(#) $Id: aj_rootgen.pl 36 2008-09-08 06:05:06Z gfis $
# 2006-08-08: "nett"; Fritz F. => 99
# 2006-06-23, Georg Fischer
# caution, must be stored in UTF-8 encoding: äöüÄÖÜß!
# output in UTF-8

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
# use utf8;
    
    # binmode(STDOUT, ":encoding(iso-8859-1)");
    while (<DATA>) {
        next if m/^\#/;
        next if m/^\s*$/;
        foreach my $aj (split) {
            print "$aj\t=AjRoot\n";
        };
    }
    
    # now declination roots with "e" ommitted from "-el"
    print <<"GFis";
edl     =AjRtRoot,edel,AjRoot
eitl    =AjRtRoot,eitel,AjRoot
dunkl   =AjRtRoot,dunkel,AjRoot
heikl   =AjRtRoot,heikel,AjRoot
simpl   =AjRtRoot,simpel,AjRoot
übl     =AjRtRoot,übel,AjRoot
GFis

__DATA__
dick dünn platt dürr schlank fett mager karg hager 
groß klein
kurz lang
tief seicht nieder 
schmal breit
schwer leicht 
schwierig
eng weit knapp offen
alt jung neu flügge greis
fern nah dicht leck
arm reich
laut leise schrill still stumm taub dumpf blind
kalt heiß warm lau kühl schwül lind
nass trocken feucht dröge klamm welk frisch
wund gesund lahm krank heil wohl weh tot elend lebendig siech matt
viel wenig 
rein sauber pur
fein zart grob derb krude kross
schlau dumm klug weise wirr blöd doof jeck tumb eitel 
munter müde wach schlapp  
schön hübsch fesch krass prall feist drall doll toll rank rege schick schmuck
bar gar
fest los locker morsch schlaff  
bitter süß sauer herb lasch mild schal
blank 
kahl kraus schütter nackt bloß
dunkel blass hell grell düster finster licht fahl bunt
klar trüb fad flau
eigen fremd welsch deutsch
froh lieb heiter nett ernst zufrieden stet frei
fies gemein forsch frech dreist kess scheel schnöde schroff schüchtern
fromm keusch streng geil
mies schlecht gut böse schlimm arg übel rüde mau
bieder treu edel gerecht lauter hehr hold brav kühn keck bang lax plump stolz stur vornehm wacker
simpel
tapfer feig
barsch harsch sacht sanft
# 
faul fleißig
schnell fix jäh flott
langsam 
rasch flink träge
früh spät
geheim
selten gering häufig genau schier rar
schwach stark
schwanger
schwul
spitz stumpf scharf 
krumm gerade 
rund schief schräg
glatt rau rauh roh eben flach steil
wahr falsch echt richtig
wild zahm
öde wüst
heikel 
heiser
hohl voll leer 
übrig
ganz halb
gleich verschieden selb gesamt
hart weich spröd mürb steif starr zäh kross
teuer billig wert
satt 
sicher gewiss

# don't occur undeclined:
link recht
ober unter vorder hinter äußer inner
hoh
# only undeclined:
hoch
# only with un-
unwirsch
unnütz

# well-known foreign words
fidel 
cool
fair
direkt
modern
strikt
