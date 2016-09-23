# "primary" (simple) German prepositions
# and other short, undeclinable words
# and their combinations
# @(#) $Id: pr_rootgen.pl 36 2008-09-08 06:05:06Z gfis $
# 2016-09-23: -hier
# 2006-07-31, Georg Fischer
# caution, must be stored in UTF-8 encoding: äöüÄÖÜß!

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
        s/[\=\,]/ /g;
        s/\r?\n//; # chompr
        my @pr = split; # on whitespace
        print join("\t\t", @pr), "\n";
    }
__DATA__
ab              PrPrim
aber            Cj
allerdings      Cj
als             PrPrim
am              PrShor  an_dem  PrChan
an              PrPrim
ans             PrShor  an_das  PrChan
anstatt         Pr
auch            Un
auf             PrPrim
aufs            PrShor  auf_das PrChan
aufgrund        Cj
aus             PrPrim
außer          CjPrim
außerm         CjShor  außer_dem  CjChan
bald            CjPrim
bei             PrPrim
beim            PrShor  bei_dem PrChan
bevor           Pr
bis             CjPrim
da              CjPrim
dabei           Av
dadurch         Av
dafür          Av
daher           Av
dahin           Av
damit           Av
danach          Av
dann            CjPrim
dar             PrPrimComb
dass            CjPrim
daß                ExNrul      dass    Cj
davon           Av
davor           Av
dazu            Av
demnach         Pr
denn            CjPrim
dennoch         Cj
deshalb         Cj
desto           Un
doch            CjPrim
dort            PrPrim
dr              PrPrimComb
durch           Pr
ebensowohl      Cj
ehe             Pr
einher          Pr
ent             PrPrimComb
entgegen        Pr
entweder        Cj
etwa            Un
etwas           Av
falls           Cj
fast            Un
fort            PrPrim
für            PrPrim
fürs           PrShor      für_das    PrChan
gar             PrPrim
gegen           PrPrim
gegenüber       Pr
genug           CjPrim
her             PrPrim
heraus          Pr
herein          Pr
hierbei         Pr
hin             PrPrim
hinaus          Pr
hinein          Pr
hinter          PrPrim
hinterm         PrShor      hinter_dem  PrChan
im              PrShor      in_dem  PrChan
in              PrPrim
ins             PrShor      in_das  PrChan
indem           Cj
irgend          UnPrim
je              Un
jedoch          Cj
kraft           Un
mehr            Un
minus           Cj
mit             PrPrim
mitten          Un
nach            PrPrim
nachdem         Pr
nachher         Pr
neben           PrPrim
nicht           Un
nichtsdestoweniger      Cj
noch            Cj
nur             Un
ob              CjPrim
obschon         Pr
obwohl          Cj
oder            Cj
ohne            Un
per             Un
plus            Cj
pro             Un
samt            PrPrim
schon           PrPrim
sehr            Un
seit            PrPrim
so              PrPrim
sobald          Pr
sodann          Pr
sodass          Cj
sodaß          ExNrul  sodass  Cj
sogar           Un
somit           Pr
sondern         Cj
sowie           Cj
sowohl          Cj
statt           PrPrim
trotz           Pr
um              PrPrim
und             Cj
unter           PrPrim
unterm          PrShor  unter_dem   PrChan
vielleicht      Un
vom             PrShor  von_dem PrChan
von             PrPrim
vor             PrPrim
vors            PrShor  vor_das PrChan
vorm            PrShor  vor_dem PrChan
vorher          Pr
wann            Ir
warum           Ir
was             Ir
weder           CjPrim
weg             PrPrim
wegen           CjPrim
weil            CjPrim
weiter          PrPrim
wenn            Cj
wem             IrPrim
wen             IrPrim
wer             IrPrim
wes             IrPrim
wessen          Ir
weswegen        Ir
wider           PrPrim
wie             IrPrim
wiederum        Cj
wieso           Ir
wiewohl         Cj
wieviel         Ir
willen          Un
wo              IrPrim
wobei           Cj
wofür          Ir
wogegen         Ir
woher           Ir
wohin           Ir
womit           Ir
wonach          Ir
wor             IrPrimComb
woran           Ir
worauf          Ir
woraus          Ir
worum           Ir
wovon           Ir
wozu            Ir
während        Pr
zu              PrPrim
zudem           Pr
zum             PrShor      zu_dem  PrChan
zur             PrShor      zu_der  PrChan
zumal           Cj
zuvor           Pr
zwar            CjPrim
zwischen        PrPrim
über           PrPrim
überm          PrShor      über_dem   PrChan
