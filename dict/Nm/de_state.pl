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
# list of 205 German names for UNO member states
# from http://de.wikipedia.org/wiki/Mitgliedstaaten_der_Vereinten_Nationen_%28alphabetisch%29
# take single words only
# @(#) $Id: de_state.pl 36 2008-09-08 06:05:06Z gfis $
# 2006-08-13, Georg Fischer

use strict;
    binmode(STDOUT, ":utf8");

    while (<DATA>) {
        next if ! m/^\#\[\[/;
        m/\[\[([^ \-\(\|\]]+)/;
        my $state = $1;
        # $state =~ s/ $//;
        my $genus = "";
        $genus = "Fm" if $state =~ m/ei$/;
        print "$state   =Nm${genus}GeogCtry\n";
    }
__DATA__
#[[Afghanistan]]    19. November 1946
#[[Ägypten]]    24. Oktober 1945
#[[Albanien]]   14. Dezember 1955
#[[Algerien]]   8. Oktober 1962
#[[Andorra]]    28. Juli 1993
#[[Angola]]     1. Dezember 1976
#[[Antigua und Barbuda]]    11. November 1990
#[[Barbuda]]    11. November 1990
#[[Äquatorialguinea]]   12. November 1968
#[[Argentinien]]    24. Oktober 1945
#[[Armenien]]   2. März 1992
#[[Aserbaidschan]]  2. März 1992
#[[Äthiopien]]  13. November 1945
#[[Australien]]     1. November 1945
#[[Bahamas]]    18. September 1973
#[[Bahrain]]    21. September 1971
#[[Bangladesch]]    17. September 1974
#[[Barbados]]   9. Dezember 1966
#[[Weißrussland]] (Belarus) 24. Oktober 1945
#[[Belgien]]    27. Dezember 1945
#[[Belize]]     25. September 1981
#[[Benin]]  20. September 1960
#[[Bhutan]]     21. September 1971
#[[Bolivien]]   14. November 1945
#[[Bosnien und Herzegowina]]    22. Mai 1992
#[[Herzegowina]]    22. Mai 1992
#[[Botswana]]   17. Oktober 1966
#[[Brasilien]]  24. Oktober 1945
#[[Brunei]]     21. September 1984
#[[Bulgarien]]  14. Dezember 1955
#[[Burkina Faso]]   20. September 1960
#[[Faso]]   20. September 1960
#[[Burundi]]    18. September 1962
#[[Chile]]  24. Oktober 1945
#[[China]] 1971 (anstelle der 1971 ausgetretenen [[Republik China (Taiwan)]], Mitglied seit 24. Oktober 1945)
#[[Costa Rica]]     2. November 1945
#[[Dänemark]]   24. Oktober 1945
#[[Deutschland]]    18. September 1973 ([[Deutsche Demokratische Republik|DDR]] 18. September 1973 - 02. Oktober 1990)
#[[Dominica]]   18. Dezember 1978
#[[Dominikanische Republik]]    24. Oktober 1945
#[[Dschibuti]]  20. September 1977
#[[Ecuador]]    21. Dezember 1945
#[[Elfenbeinküste]]     20. September 1960
#El Salvador]]  24. Oktober 1945
#[[Salvador]]   24. Oktober 1945
#[[Eritrea]]    28. Mai 1993
#[[Estland]]    17. September 1991
#[[Fidschi]]    13. Oktober 1970
#[[Finnland]]   14. Dezember 1955
#[[Frankreich]]     24. Oktober 1945
#[[Gabun]]  20. September 1960
#[[Gambia]]     21. September 1965
#[[Georgien]]   31. Juli 1992
#[[Ghana]]  8. März 1957
#[[Grenada]]    17. September 1974
#[[Griechenland]]   25. Oktober 1945
#[[Guatemala]]  21. November 1945
#[[Guinea]]     12. Dezember 1958
#[[Guinea-Bissau]]  17. September 1974
#[[Bissau]]     17. September 1974
#[[Guyana]]     20. September 1966
#[[Haiti]]  24. Oktober 1945
#[[Honduras]]   17. Dezember 1945
#[[Indien]]     30. Oktober 1945
#[[Indonesien]]     28. September 1950
#[[Irak]]   21. Dezember 1945
#[[Iran|Iran, Islamische Republik]]     24. Oktober 1945
#[[Irland|Irland]]  14. Dezember 1955
#[[Island]]     19. November 1946
#[[Israel]]     11. Mai 1949
#[[Italien]]    14. Dezember 1955
#[[Jamaika]]    18. September 1962
#[[Japan]]  18. Dezember 1956
#[[Jemen]]  30. September 1947
#[[Jordanien]]  14. Dezember 1955
#[[Kambodscha]] 14. Dezember 1955
#[[Kamerun]]    20. September 1960
#[[Kanada]]     9. November 1945
#[[Kap Verde]]  16. September 1975
#[[Kasachstan]] 2. März 1992
#[[Katar]]  21. September 1971
#[[Kenia]]  16. Dezember 1963
#[[Kirgisistan]] 2. März 1992
#[[Kiribati]]   14. September 1999
#[[Kolumbien]]  5. November 1945
#[[Komoren]]    12. November 1975
#[[Kongo|Kongo, Republik]]  20. September 1960
#[[Kongo|Kongo, Demokratische Republik]] 20. September 1960
#[[Korea|Korea, Nord-]]     17. September 1991
#[[Korea|Korea, Süd-]]  17. September 1991
#[[Kroatien]]   22. Mai 1992
#[[Kuba]]   24. Oktober 1945
#[[Kuwait]]     14. Mai 1963
#[[Laos]] 14. Dezember 1955
#[[Lesotho]]    17. Oktober 1966
#[[Lettland]]   17. September 1991
#[[Libanon]]    24. Oktober 1945
#[[Liberia]]    2. November 1945
#[[Libyen]]     14. Dezember 1955
#[[Liechtenstein]]  18. September 1990
#[[Litauen]]    17. September 1991
#[[Luxemburg]]  24. Oktober 1945
#[[Madagaskar]]     20. September 1960
#[[Malawi]]     1. Dezember 1964
#[[Malaysia]]   17. September 1957
#[[Malediven]]  21. September 1965
#[[Mali]]   28. September 1960
#[[Malta]]  1. Dezember 1964
#[[Marokko]]    12. November 1956
#[[Marshallinseln]]     17. September 1991
#[[Mauretanien]]    27. Oktober 1961
#[[Mauritius]]  24. April 1968
#[[Mazedonien]]     8. April 1993
#[[Mexiko]]     7. November 1945
#[[Mikronesien]]    17. September 1991
#[[Moldawien]]  2. März 1992
#[[Monaco]]     28. Mai 1993
#[[Mongolei]]   27. Oktober 1961
#[[Montenegro]] 28. Juni 2006
#[[Mosambik]]   16. September 1975
#[[Myanmar]]    19. April 1948
#[[Namibia]]    23. April 1990
#[[Nauru]]  14. September 1999
#[[Nepal]]  14. Dezember 1955
#[[Neuseeland]]     24. Oktober 1945
#[[Nicaragua]]  24. Oktober 1945
#[[Niederlande]]    10. Dezember 1945
#[[Niger]]  20. September 1960
#[[Nigeria]]    7. Oktober 1960
#[[Norwegen]]   27. November 1945
#[[Oman]]   7. Oktober 1971
#Ost-Timor]]    27. September 2002
#[[Timor]]  27. September 2002
#[[Österreich]]     14. Dezember 1955
#[[Pakistan]]   30. September 1947
#[[Palau]]  15. Dezember 1994
#[[Panama]]     13. November 1945
#[[Papua-Neuguinea]]    10. Oktober 1975
#[[Neuguinea]]  10. Oktober 1975
#[[Paraguay]]   24. Oktober 1945
#[[Peru]]   31. Oktober 1945
#[[Philippinen]]    24. Oktober 1945
#[[Polen]]  24. Oktober 1945
#[[Portugal]]   14. Dezember 1955
#[[Ruanda]]     18. September 1962
#[[Rumänien]]   14. Dezember 1955
#[[Russland]]   24. Oktober 1945
#[[Salomonen]]  19. September 1978
#[[Sambia]]     1. Dezember 1964
#[[Samoa]]  15. Dezember 1976
#San Marino]]   2. März 1992
#[[Marino]]     2. März 1992
#[[São Tomé und Príncipe]]  16. September 1975
#[[Tomé und Príncipe]]  16. September 1975
#[[Príncipe]]   16. September 1975
#[[Saudi-Arabien]]  24. Oktober 1945
#[[Arabien]]    24. Oktober 1945
#[[Schweden]]   19. November 1946
#[[Schweiz]]    10. September 2002
#[[Senegal]]    28. September 1960
#[[Serbien]]    1. November 2000
#[[Seychellen]]     21. September 1976
#[[Sierra Leone]]   27. September 1961
#[[Leone]]  27. September 1961
#[[Simbabwe]]   25. August 1980
#[[Singapur]]   21. September 1965
#[[Slowakei]]   19. Januar 1993
#[[Slowenien]]  22. Mai 1992
#[[Somalia]]    20. September 1960
#[[Spanien]]    14. Dezember 1955
#[[Sri Lanka]]  14. Dezember 1955
#[[Lanka]]  14. Dezember 1955
#[[Kitts und Nevis]]    23. September 1983
#[[Nevis]]  23. September 1983
#[[Lucia]]  18. September 1979
#[[Vincent und die Grenadinen]]     16. September 1980
#[[Grenadinen]]     16. September 1980
#[[Südafrika]]  7. November 1945
#[[Sudan]]  12. November 1956
#[[Suriname]]   4. Dezember 1975
#[[Swasiland]]  24. September 1968
#[[Syrien]]     24. Oktober 1945
#[[Tadschikistan]]  2. März 1992
#[[Tansania]] 14. Dezember 1961
#[[Thailand]]   16. Dezember 1946
#[[Togo]]   20. September 1960
#[[Tonga]]  14. September 1999
#[[Trinidad und Tobago]]    18. September 1962
#[[Tschad]]     20. September 1960
#[[Tschechien]]     19. Januar 1993
#[[Tunesien]]   12. November 1956
#[[Türkei]]     24. Oktober 1945
#[[Turkmenistan]]   2. März 1992
#[[Tuvalu]]     5. September 2000
#[[Uganda]]     25. Oktober 1962
#[[Ukraine]]    24. Oktober 1945
#[[Ungarn]]     14. Dezember 1955
#[[Uruguay]]    18. Dezember 1945
#[[Usbekistan]]     2. März 1992
#[[Vanuatu]]    15. September 1981
#[[Venezuela]]  15. November 1945
#[[Vereinigte Arabische Emirate]]   9. Dezember 1971
#[[USA|Vereinigte Staaten]] (von Amerika)   24. Oktober 1945
#[[Großbritannien und Nordirland|Vereinigtes Königreich]]   24. Oktober 1945
#[[Nordirland|Vereinigtes Königreich]]  24. Oktober 1945
#[[Vietnam]]    20. September 1977
#[[Zentralafrikanische Republik]]   20. September 1960
#[[Zypern]]     20. September 1960
