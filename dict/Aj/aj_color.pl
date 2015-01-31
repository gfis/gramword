# German adjectives related to quantities
# @(#) $Id: aj_color.pl 36 2008-09-08 06:05:06Z gfis $
# 2006-06-23, Georg Fischer
# caution, must be stored in UTF-8 encoding: äöüÄÖÜß, output in UTF-8

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
    
    # binmode(STDOUT, ":utf8");
    while (<DATA>) {
        next if m/^\#/;
        next if m/^\s*$/;
        my ($aj,$rgb) = split;
        print "$aj\t=AjColr.$rgb\n";
    }

__DATA__
rot         FF0000
blau        0000FF
grün       008000
gelb        FFFF00
schwarz     000000
weiß       FFFFFF
grau        C0C0C0
violett     EE82EE
lila        FF00FF
rosa        FA8072
# salmon    FA8072
blond       F5DEB3
# wheat     F5DEB3
brünett        800000
# maroon    800000
beige       F5F5DC
orange      FFA500
braun       A52A2A
# seldom:
magenta     FF00FF
türkis     40E0D0
ocker       F0E68C
# khaki     F0E68C
sienna      A0522D
oliv        808000
pink        FFC0CB
purpur      800080
aquamarin   7FFFD4
