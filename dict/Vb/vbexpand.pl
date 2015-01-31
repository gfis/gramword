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

# vbexpand.pl - complete verb form definitions
# @(#) $Id: vbexpand.pl 36 2008-09-08 06:05:06Z gfis $
# 2006-05-27: in UTF-8 äöüß
# 2003-11-03: erlösst -> erlöst; bitten - gebeten
# 2001-04-16, Georg Fischer: separated from 'vbconj.pl'
#
# accents are placed behind the vowel, umlauts are replaced by a", o", u"
# sz is replaced by sS
# line order matters, since for a "->" mapping line, the target verb must be defined before
# the target verb of a mapping may not have a prefix "em-, ge-, ver-,.."
# the target verb's infinitive must end in "-en"
# temporary replacements:
#    qu -> qU
#    endings en, est, e -> En, Est, E
#
# input lines are incomplete:
#    single infinitive: regular (weak) verb
#    srcinf->tarinf: mapping, same conjugation as target verb
#    infradix is missing
#    de: conjunct.ii may be missing
#    en: gerundium is missing
# output file contains lines with forms:
#    de: infinitiv, infradix, praes.sing.2, imperfekt.sing.1, particip perf., conjunct.ii [!special]
#    en: infinitive, imperfect, participe, gerundium
#
# de: default is a conjunctive from imperfect,
#    with umlaut, "t" removed, "e" appended
# de: default are combined forms with "haben"
# "![0-9]+" action routines can be placed at the end of the record
# "!0" designates regular (weak) verbs
#-------------------------------------------------------------------------
use strict;
no  strict 'refs';
my $debug = 0; # whether to print all forms

my $lang = shift (@ARGV);
my $prepare         = "prepare_"            . $lang;
my $complete         = "complete_"       . $lang;
my $shield_vowel = "shield_vowel_" . $lang;

my $vrecord; # definition of the verb's conjugation forms
my %mpatt; # hash for input mapping conjugation patterns
my %vhash; # hash for output verb    conjugation patterns
my $special; # number of special action routine
my @elem; # relevant conjugation forms of the verb
my @vbeg; # part of verb form left  of the root vowel
my @vmid; # the root vowel
my @vend; # part of verb form right of the root vowel

# main program

    # determine timestamp
    my $user = $ENV{"USERNAME"} || "unknown user";
    my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
    my $iso_date = sprintf ("%04d-%02d-%02dT%02d:%02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min, $sec);

    print <<GFis;
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Irregular Verbs - $lang</title>
<!-- language $lang, $iso_date, $user -->
</head>
<body>
<!-- 
GFis

    while (<>) { # process input lines
        if (! m/^#/ && ! m/^ *\</ && ! m/^ *\Z/) { # line is non-comment, non-HTML, non-empty
            # preprocess the entire line
            chomp;
            $vrecord = $_;
            & preprocess_record; # extract $special, replace HTML symbols
            print "# preprocessed: ", $vrecord, "\n" if $debug >= 2;

            if ($vrecord =~ m/\-\>/) {
                & map_verb;
            }
            my ($vr0, $vr1) = split (/\,/, $vrecord);
            $mpatt{$vr0} = $vrecord if $vr1 ne "";
            print "# mpatt: $vr0=$vrecord\n" if $debug >= 2;

            & $complete; # expands regular (weak) forms also
            & postprocess_record; 
            ($vr0) = split (/\,/, $vrecord);
            $vhash{$vr0} = $vrecord;
            print "# vhash: $vr0=$vrecord\n\n" if $debug >= 2;
        } # non-comment
    } # while <>

    print <<GFis;
< -->
<pre>
GFis

    # now output in lexicographical order
    foreach my $vr0 (sort keys %vhash) {
        $vrecord = $vhash{$vr0};
        print $vrecord, "\n";
    } # foreach

    print <<GFis;
</pre>
</body>
</html>
GFis
    # main

#----------------------------------------------------------------
sub preprocess_record { # global: $vrecord
        $special = "";
        if ($vrecord =~ m/\!([a-z0-9\>]+)/) { # extract number of special processing routine
            $special = $1; # save it
            $vrecord =~ s/\!$special//; # remove it from entry
        }

        # replace UTF-8 characters 
        # for German, French, Spanish
        $vrecord =~ s/ä/a"/g;
        $vrecord =~ s/ö/o"/g;
        $vrecord =~ s/ü/u"/g;
        $vrecord =~ s/á/a´/g;
        $vrecord =~ s/é/e´/g;
        $vrecord =~ s/í/i´/g;
        $vrecord =~ s/ó/o´/g;
        $vrecord =~ s/ú/u´/g;
        $vrecord =~ s/à/a`/g;
        $vrecord =~ s/è/e`/g;
        $vrecord =~ s/ì/i`/g;
        $vrecord =~ s/ò/o`/g;
        $vrecord =~ s/ù/u`/g;
        $vrecord =~ s/ß/sS/g; # German sharp s
        $vrecord =~ s/ñ/n~/g; 
    } # preprocess_record

sub postprocess_record
    { # global: $vrecord
        $vrecord .= "!" . $special if $special ne ""; # append special proc. routine

        # switch back to UTF-8 characters
        # for German, French, Spanish
        $vrecord =~ s/a"/ä/g;
        $vrecord =~ s/o"/ö/g;
        $vrecord =~ s/u"/ü/g;
        $vrecord =~ s/a´/á/g;
        $vrecord =~ s/e´/é/g;
        $vrecord =~ s/i´/í/g;
        $vrecord =~ s/o´/ó/g;
        $vrecord =~ s/u´/ú/g;
        $vrecord =~ s/a`/à/g;
        $vrecord =~ s/e`/è/g;
        $vrecord =~ s/i`/ì/g;
        $vrecord =~ s/o`/ò/g;
        $vrecord =~ s/u`/ù/g;
        $vrecord =~ s/sS/\ß/g; # German sharp s
        $vrecord =~ s/n~/ñ/g;
    } # postprocess_record

#-----------------------------------------------------------------------
# determine conjugation forms from a verb with analoguous conjugation
# temporarily shield "qu" and "e" vowels in endings, 
# transport the varying root vowel, and surrounding consonants

sub map_verb
    { # global: $vrecord
        my ($infin, $tarinf) = split (/\-\>/, $vrecord);
        if (! defined ($mpatt{$tarinf}))
        { # sequence of lines matters when mapping
            print           "#?? invalid sequence, \"$tarinf\" not yet defined\n";
            print STDERR    "#?? invalid sequence, \"$tarinf\" not yet defined\n";
        } # sequence matters
        $vrecord = $mpatt{$tarinf} . "," . $infin; # prefix target entry 
        print "# map: $infin->$vrecord\n" if $debug >= 2;

        @elem = split (/\,/, $vrecord);
        & $shield_vowel (1); 

        # now split all forms into: left "(" root vowel ")" rest
        my $si = scalar @elem - 1; # index of source infinitive
        my $ti = 0;                             # index of target infinitive
        & isolate_root_vowel;

        # replace only the substrings that differ 
        #    (not necessary for en)
        my $srcbeg = $vbeg[$si];
        my $tarbeg = $vbeg[$ti];
        while (1 && substr ($srcbeg,    1) eq substr ($tarbeg,  1) 
            &&   length ($srcbeg) > 1)
        { # shrink beginnings to be replaced
            $srcbeg =~ s/\A.//;
            $tarbeg =~ s/\A.//;
        } # while shrinking
        my $srcend = $vend[$si];
        my $tarend = $vend[$ti];
        while (1 && substr ($srcend, -1) eq substr ($tarend, -1) 
            &&   length ($srcend) > 1)
        { # shrink endings to be replaced
            $srcend =~ s/.\Z//;
            $tarend =~ s/.\Z//;
        } # while shrinking

        for (my $ri = $ti + 1; $ri < $si; $ri ++)
        { # process the target forms and replace the substrings
            $vbeg[$ri] =~ s/$tarbeg\Z/$srcbeg/; # replace trailing
            $vend[$ri] =~ s/\A$tarend/$srcend/; # replace leading
            $elem[$ri] = $vbeg[$ri] . $vmid[$ri] . $vend[$ri]; # recombine
        } # for $ri
        $elem[0] = pop @elem; # replace target infinitive by source inf.

        & $shield_vowel (0);
        $vrecord = join (",", @elem);
    } # map_verb

sub isolate_root_vowel
    { # split all elements of $vrecord around the root vowel
        for (my $ri = 0; $ri < scalar @elem; $ri ++)
        { # split all forms into left - root vowel - rest
            $elem[$ri] = reverse ($elem[$ri]);
                # can get the last vowel only by reversing?
            # now split around the first vowel
            $elem[$ri] =~ m/([^aeiou\"\´\`]*)([\"\´\`]?[aeiou]{1,2})(.*)\Z/;
                # originally the accent was behind the vowel
            $vbeg[$ri] = reverse ($3);
            $vmid[$ri] = reverse ($2);
            $vend[$ri] = reverse ($1);
            $elem[$ri] = reverse ($elem[$ri]); # back to original
            # now we have '$elem' elements like:
            # r(a)tEn schl(a)fEn schl(a")fst schl(ie)f geschl(a)fEn
            # gr(a)bEn f(a)hrEn f(a")hrst f(u)hr gef(a)hrEn
            print "# isolated: $vbeg[$ri]($vmid[$ri])" 
                . "$vend[$ri], $elem[$ri]\n" if $debug >= 2;
        } # for $ri
    } # sub isolate_root_vowel

#------------------------------------------------------------------
# language specific routines for 
# Deutsch

sub shield_vowel_de
    { # shield/unshield "e" vowel in 
        my ($dir) = @_; # 1 = on, 0 = off 
        for (my $ri = 0; $ri < scalar @elem; $ri ++)
        { 
            if ($dir == 1)
            { # shield
                $elem[$ri] =~ s/e(n|st|)\Z/E$1/;
                $elem[$ri] =~ s/qu/qU/g; # protect u vowel in "qu", restore below
                $elem[$ri] =~ s/\Age/gE/ if $ri == 3; # shield "gEessen"
            } # shield
            else
            { # unshield
                $elem[$ri] =~ s/qU/qu/g; # restore for "qu" trick above
                $elem[$ri] =~ s/E/e/g;
            } # unshield
        } # for $ri
    } # shield_vowel_de

sub prepare_de
    { 
        my ($infin, $praes2, $imperf, $particip, $conjunct) 
            = split (/\,/, $vrecord);
        $vrecord = join (",", 
             ($infin, $praes2, $imperf, $particip, $conjunct));
    } # prepare_de

sub complete_de
    { 
        my ($infin, $praes2, $imperf, $particip, $conjunct) 
            = split (/\,/, $vrecord);
        my $inrad = $infin; # keep these parallel with 'vbconj.pl'!
        $inrad =~ s/e([lr])n\Z/e$1/;
        $inrad =~ s/en\Z//;
        $inrad =~ s/(d|t)\Z/${1}e/;

        if ($praes2 eq "")
        { # regular (weak) conjugation
            $special = "0";
            $praes2 = $inrad . "st";
            $imperf = $inrad . "te";
            $particip = "ge" . $inrad . "t";
        } # regular

        # pres.sing.2: repair s/z endings
        $praes2 =~ s/sst\Z/st/ if $infin =~ /^[^s]*s\Z/;
        $praes2 =~ s/zst\Z/zt/; # du salzt
        $praes2 =~ s/ssst\Z/sst/;
        $praes2 =~ s/sst\Z/st/ if $infin !~ m [ss]i; # du loest 2003-11-03
        $praes2 =~ s/stst\Z/st/; # bersten, birst
        $praes2 =~ s/(i[e]?[n]?|u\")(d|t)st\Z/$1${2}est/; 
            # leidest, la"dst, ha"ltst, landest, behu"test, lotest, faltest
        $praes2 =~ s/([^e])ih/${1}ieh/; # sehen, stehlen, befehlen
        
        # imperf.sing.1: double consonant -> single
        $imperf =~ s/.(.)\Z/$1/ if $imperf =~ /(ie|a)(ll|ff)\Z/;
            # repair fiell, traff
        $imperf =~ s/(a|ie)ss\Z/${1}sS/; # repair liess, frass
        
        # participe - foreign "-ieren" without "ge-"
        if ($particip =~ /iert\Z/)
        { # geprogrammiert -> programmiert
            $particip =~ s/^ge//;
        }
        if ($infin !~ m/^(geben|bitten)$/) 
        { # these without "ge-", aber gegeben, gebeten
            $particip =~ s/^ge(be|em|ent|er|ge|miss|ver|zer)/$1/;
        }
            
        $particip =~ s/^gee/gege/; # essen
        $particip =~ s/ieen\Z/ien/; # schreien, speien
         
        # conjunct.ii
        if ($conjunct eq "")
        { # conjunct.ii is built from imperfect, with root vowel weakened
            @elem = split (/\,/, $vrecord . "," . $imperf);
            & $shield_vowel (1); 
            my $ci = scalar @elem - 1; # index of conjunct.ii
            & isolate_root_vowel;

            # now do the weakening of the root vowel
            if      ($vmid[$ci] =~ /^[aou]([^\"]|)\Z/ && $special !~ m/^0/) 
            { # weaken hard vowel, handle "au" -> "aeu" also, not for weak 
                $vmid[$ci] =~ s/^([aou])/$1\"/;
                if ($vmid[$ci] =~ m/a\"nn/ && $vmid[0] eq "e" && $vend[0] !~ m/^sS/)
                { # (k|n|r)a"nne -> (k|n|r)enne, but a"sSe, ma"sSe, na"hme
                    $vmid[$ci] = "e";
                }
            } # weaken
            elsif ($vmid[$ci] =~ /\"/)
            { # already with umlaut

            } # already with umlaut

            # now assemble new form
            $elem[$ci] = $vbeg[$ci] . $vmid[$ci] . $vend[$ci];

            & $shield_vowel (0);
            $conjunct = $elem[$ci];
        } # compose conjunct.ii
        # $conjunct =~ s/([^t])te\Z/${1}e/ if $vend[0] !~ /te/;
        # remove trailing "t"
        $conjunct =~ s/([^e])\Z/${1}e/; # append trailing "e"
        $conjunct =~ s/(a\"|ie)sse\Z/${1}sSe/; # repair liess, frass

        $vrecord = join (",", 
            ($infin, $praes2, $imperf, $particip, $conjunct));
    } # complete_de

#---------------------------------------------------------------
# language specific routines for 
# English

sub shield_vowel_en
    { # shield/unshield "e" vowel in endings
        my ($dir) = @_; # 1 = on, 0 = off 
        for (my $ri = 0; $ri < scalar @elem; $ri ++)
        { 
            if ($dir == 1)
            { # shield
                $elem[$ri] =~ s/e(n?)\Z/E$1/;
                $elem[$ri] =~ s/qu/qU/g; # protect u vowel in "qu", restore below
            } # shield
            else
            { # unshield
                $elem[$ri] =~ s/qU/qu/g; # restore for "qu" trick above
                $elem[$ri] =~ s/E/e/g;
            } # unshield
        } # for $ri
    } # shield_vowel_en

sub prepare_en
    { 
        my ($infin, $imperf, $particip) 
            = split(/\,/, $vrecord);
        $vrecord = join (",", 
             ($infin, $imperf, $particip));
        print "# prepared: $vrecord\n" if $debug >= 2;
    } # prepare_en

sub complete_en
    {
        my ($infin, $imperf, $particip) = split(/\,/, $vrecord);
        my $inrad = $infin;
        $inrad =~ s/e\Z// if $special ne "1"; # keep "be"

        if (     ($infin !~ m/e\Z/) # not for "come"
                && ($inrad !~ m/([bdfglmnprt])\1[aeiouy][^aeiouy]\Z/) # doubled cons
                            # not for "utter", "buffer", "hammer"
             )
        { # preconditions for duplicating met
            if ($inrad =~ m/(qu|[^aeiouy])[aeiouy]([bdfglmnprt])\Z/)
            { # duplicate trailing consonant
                my $cons = $2;
                # print "# matched: $cons\n";
                $inrad =~ s/$cons\Z/$cons$cons/;
            } # duplicate
        } # preconditions for duplicating

        my $gerund = ($infin =~ m/ee\Z/) ? $infin : $inrad; # seeing, coming
        $gerund .= "ing"; 
        $inrad =~ s/([^aeiou])y\Z/${1}i/;

        if ($imperf eq "")
        { # regular (weak) conjugation
            $special = "0";
            $imperf = $inrad . "ed";
            $particip = $imperf;
        } # regular

        $gerund =~ s/([^e])eing\Z/${1}ing/ # also "E" ???q
            if $special ne "1"; # keep "being" instead of "bing"
        $gerund =~ s/iing\Z/ying/; # "lying"
        $vrecord = join (",", 
            ($infin, $imperf, $particip, $gerund));
        # print "# completed: $vrecord\n" if $debug >= 2;
    } # complete_en

#---------------------------------------------------------------
# language specific routines for 
# Espa&ntilde;ol

sub shield_vowel_es
    { # shield/unshield "e" vowel in endings
        my ($dir) = @_; # 1 = on, 0 = off 
        for (my $ri = 0; $ri < scalar @elem; $ri ++)
        { 
            if ($dir == 1)
            { # shield
                $elem[$ri] =~ s/qu/qU/g; # protect u vowel in "qu", restore below
            } # shield
            else
            { # unshield
                $elem[$ri] =~ s/qU/qu/g; # restore for "qu" trick above
                $elem[$ri] =~ tr/AEIOUY/aeiouy/;
            } # unshield
        } # for $ri
    } # shield_vowel_es

sub prepare_es
    { 
        my ($infin, $imperf, $perfect) 
            = split(/\,/, $vrecord);
        $vrecord = join (",", 
             ($infin, $imperf, $perfect));
        print "# prepared: $vrecord\n" if $debug >= 2;
    } # prepare_es

sub complete_es
    {
        my ($infin, $imperf, $perfect) = split(/\,/, $vrecord);
        my $inrad = $infin;

        $vrecord = join (",", 
            ($infin));
        # print "# completed: $vrecord\n" if $debug >= 2;
    } # complete_es
