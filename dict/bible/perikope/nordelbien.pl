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
# extract perikope data from nordelbien.de/glaube
# 2007-02-04, Dr. Georg Fischer <punctum@punctum.com>

use strict;
my $perikope = 0;
my %bookmap = (0, 0
        , '1 Mose'  , '01.1-mose'
        , '2 Mo'    , '02.2-mose'
        , '2 Mose'  , '02.2-mose'
        , '2. Mose' , '02.2-mose'
        , '4 Mose'  , '04.4-mose'
        , '5 Mose'  , '05.5-mose'
        , '1 Sam'   , '09.1-samuel' # ????
        , '2 Sam'   , '10.2-samuel' # ????
        , '1 Kˆn'   , '11.1-koenige' # ????
        , '2 Kˆn'   , '12.2-koenige' # ????
        , 'Jes'     , '23.jesaja'
        , 'Jer'     , '24.jeremia'
        , 'Klgl'    , '25.klage'
        , 'Hes'     , '26.hesekiel'
        , 'Mt'      , '40.matthaeus'
        , 'Mk'      , '41.markus'
        , 'Lk'      , '42.lukas'
        , 'Joh'     , '43.johannes'
        , 'Apg'     , '44.apostel'
        , 'Rˆm'     , '45.roemer'
        , '1 Kor'   , '46.1-korinther'
        , '2 Kor'   , '47.2-korinther'
        , 'Gal'     , '48.galater'
        , 'Eph'     , '49.epheser'
        , 'Phil'    , '50.philemon' # ????
        , '2 Tim'   , '55.2-timotheus'
        , 'Hebr'    , '58.hebraeer'
        , '1 Pet'   , '60.1-petrus'
        , '2 Pet'   , '61.2-petrus'
        , '2 Petr'  , '61.2-petrus'
        , '1 Joh'   , '62.1-johannes'
        , 'Jak'     , '59.jakobus'
        );
my $outfile = "nordelbien.tmp";
open (OUT, ">", $outfile) || die "cannot write \"$outfile\"";
foreach my $file (glob("nordelbien*.html")) {
    open (IN, "<", $file) || die "cannot read \"$file\"";
    while (<IN>) {
        if (0) {
        } elsif (m/\<td\>Perikope\s+(\d+)/) {
            $perikope = $1;
        } elsif (m/\A\<tr\>\<td\>/) {
            s/\r?\n//;
            m/date\=([\d\.]+)/;
            my $date = $1;
            s/ target\=\"bibel\"//;
            s/\<tr\>\<td\>\<a id\=\"\w+\"\s+href\=\"[^\"]+\"\s*\>[\d\.]+\<\/a\>/$perikope/g;
            s/\<\/tr\>/\<td\>$date/;
            s/\<td\s+bgcolor\=\"(\#\w+)\"\>/\<td\>$1\<\/td\>\<td\>/;
            s/ id\=\"\w+\"//g;
            s/\<\/td\>\<td\>/\t/g;
            my @field = split(/\t/);
            my $link = $field[4];
            if ($link !~ m/\<a/) {
                $link =~ m/((\d\.? )?[\w‰ˆ¸]+)\s*\(?(\d+)[\,\s]\(?([\d\*]+)/;
                my $book = $bookmap{$1};
                if ($book eq '') {
                    $book = '??book';
                }
                my $chapt = $3;
                my $verse = $4;
                if ($verse eq '*') {
                    $verse = '1';
                }
                $link = '<a href="http://bibel-online.net/buch/' 
                        . $book . '/' . $chapt . '.html#' . $chapt . ',' . $verse .'">' 
                        . $link . '</a>';
            }
            $field[4] = $link;
            my $temp = $field[0]; # exchange 1st 2 fields
            $field[0] = $field[1];
            $field[1] = $temp;
            pop(@field);
            print OUT join("\t", @field), "\n";
        }
    } # while IN
    close IN;
} # foreach glob    
close OUT;
__DATA__
...
<table>

<tbody><tr><td>2008/2009</td><td>Perikope 1</td></tr>
<tr><td><a id="AO46" href="http://nordelbien.de/glaube/gla.kalender/index.html?date=30.11.2008&amp;year=2008">30.11.2008</a></td><td>1. Advent</td><td bgcolor="#ff00aa">violett</td><td><a id="AO47" href="http://bibel-online.net/buch/40.matthaeus/21.html#21,1" target="bibel">Mt 21,1-9</a></td></tr>
<tr><td><a id="AO48" href="http://nordelbien.de/glaube/gla.kalender/index.html?date=07.12.2008&amp;year=2008">07.12.2008</a></td><td>2. Advent</td><td bgcolor="#ff00aa">violett</td><td><a id="AO49" href="http://bibel-online.net/buch/42.lukas/21.html#21,25" target="bibel">Lk 21,25-33</a></td></tr>
<tr><td><a id="AO50" href="http://nordelbien.de/glaube/gla.kalender/index.html?date=14.12.2008&amp;year=2008">14.12.2008</a></td><td>3. Advent</td><td bgcolor="#ff00aa">violett</td><td><a id="AO51" href="http://bibel-online.net/buch/40.matthaeus/11.html#11,2" target="bibel">Mt 11,2-6(11)</a></td></tr>
<tr><td><a id="AO52" href="http://nordelbien.de/glaube/gla.kalender/index.html?date=21.12.2008&amp;year=2008">21.12.2008</a></td><td>4. Advent</td><td bgcolor="#ff00aa">violett</td><td>Lk 1,(39)46-55(56)</td></tr>
<tr><td><a id="AO53" href="http://nordelbien.de/glaube/gla.kalender/index.html?date=24.12.2008&amp;year=2008">24.12.2008</a></td><td>Christvesper</td><td bgcolor="#ffffff">weiﬂ</td><td><a id="AO54" href="http://bibel-online.net/buch/42.lukas/2.html#2,1" target="bibel">Lk 2,1-14(20)</a></td></tr>
<tr><td><a id="AO55" href="http://nordelbien.de/glaube/gla.kalender/index.html?date=24.12.2008&amp;year=2008">24.12.2008</a></td><td>Christnacht</td><td bgcolor="#ffffff">weiﬂ</td><td>Mt 1,(1)18-25</td></tr>
<tr><td><a id="AO56" href="http://nordelbien.de/glaube/gla.kalender/index.html?date=25.12.2008&amp;year=2008">25.12.2008</a></td><td>Christfest I</td><td bgcolor="#ffffff">weiﬂ</td><td>Lk 2,(1)15-20</td></tr>
<tr><td><a id="AO57" href="http://nordelbien.de/glaube/gla.kalender/index.html?date=26.12.2008&amp;year=2008">26.12.2008</a></td><td>Christfest II</td><td bgcolor="#ffffff">weiﬂ</td><td>Joh 1,1-5(6-8)9-14</td></tr>
<tr><td><a id="AO58" href="http://nordelbien.de/glaube/gla.kalender/index.html?date=28.12.2008&amp;year=2008">28.12.2008</a></td><td>1. So. n. Christfest</td><td bgcolor="#ffffff">weiﬂ</td><td>Lk 2,(11)25-38(40)</td></tr>
<tr><td><a id="AO59" href="http://nordelbien.de/glaube/gla.kalender/index.html?date=31.12.2008&amp;year=2008">31.12.2008</a></td><td>Silvester</td><td bgcolor="#ffffff">weiﬂ</td><td><a id="AO60" href="http://bibel-online.net/buch/42.lukas/12.html#12,35" target="bibel">Lk 12,35-40</a></td></tr>
<tr><td><a id="AO61" href="http://nordelbien.de/glaube/gla.kalender/index.html?date=01.01.2009&amp;year=2008">01.01.2009</a></td><td>Neujahr</td><td bgcolor="#ffffff">weiﬂ</td><td><a id="AO62" href="http://bibel-online.net/buch/42.lukas/4.html#4,16" target="bibel">Lk 4,16-21</a></td></tr>
<tr><td><a id="AO63" href="http://nordelbien.de/glaube/gla.kalender/index.html?date=04.01.2009&amp;year=2008">04.01.2009</a></td><td>2. So. nach Christfest</td><td bgcolor="#ffffff">weiﬂ</td><td><a id="AO64" href="http://bibel-online.net/buch/42.lukas/2.html#2,41" target="bibel">Lk 2,41-52</a></td></tr>
<tr><td><a id="AO65" href="http://nordelbien.de/glaube/gla.kalender/index.html?date=06.01.2009&amp;year=2008">06.01.2009</a></td><td>Epiphanias (Hl. Drei Kˆnige)</td><td bgcolor="#ffffff">weiﬂ</td><td><a id="AO66" href="http://bibel-online.net/buch/40.matthaeus/2.html#2,1" target="bibel">Mt 2,1-12</a></td></tr>
<tr><td