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
# vbconj.pl - generate verb forms for relevant persons and times
# @(#) $Id: vbconj.pl 36 2008-09-08 06:05:06Z gfis $
# 2006-06-09: Conj. I of "sein" a.o.
# 2006-05-27: in UTF-8 äöüß; no separator "=" between output fields
# 2003-11-13:   no "|" in continued forms of a verb
# 2003-11-03:   du loesst -> du loest
# 16-May-2001: .es 13, 18, 26
# 13-May-2001: .es frequent variations
# 18-Apr-2001: regular .es
# 16-Apr-2001: restructured, use strict, for de|en, conjugation only
# 28-Aug-1999: conjunctive, output to "devbir.grm"
# 18-Aug-1999: repair "...sen", renamed from 'dproc.pl'
# 04-Mar-1999: regular, weak verbs
# 19-Feb-1999, Georg Fischer
#
# ??? imperative sein, haben u.a. Hilfsverben
#
# activation:
#    perl vbconj.pl es irverb.es.lst 
# input file contains lines with forms:
# de: infinitiv, infradix, praes.sing.2, imperfekt.sing.1, particip perf., conjunct II [!special]
# en: infinitive, infradix, imperfect, participe, gerundium
# "![0-9]+" action routines can be placed at the end of the reocrd
# accented characters are stored in UTF-8
#-------------------------------------------------------------------------
use strict;
no strict 'refs';

my @person = (0, "11", "12", "13", "91", "92", "93");
#  $fi=       0    1     2     3     4     5     6
my $debug = 0; # whether to print all forms
my $lang = shift (@ARGV);
my $conjugate   = "conjugate_" . $lang;
my $initiate    = "initiate_"   . $lang;
my $inrad;  # root of infinitive
my $glob_infin; # for &emit_form
my %hend;   # hash for .es endings
my %hform;  # forms of all persons, numeri and times

my @tim_es =    ("In", "Pr", "Ip", "Ps", "Ft", "S1", "Im", "Cd", "Ge", "Pc");
my @mod_es_pr = ( "Pr,1", "Pr,2", "Pr,3", "Pr,6"
                , "S1,1", "S1,2", "S1,3", "S1,6"
                , "Im,2", "Im,3", "Im,6"); # forms with accentuated root vowel

my $special; # number of special action routine
my $evowel; # ending vowel, determines regular conjugation pattern
my $vrecord; # definition of the verb's conjugation forms
my $fsep = "\n"; # separator for verb forms, was "\n|"

# main program   
    & $initiate;
    while (<>) { # process input lines
        if (! m/^#/ && ! m/^\s*\</ && ! m/^ *\Z/) { # line is non-comment, non-HTML, non-empty
            # preprocess the entire line
            s/\s*$//; # chomp;
            $vrecord = $_;
            & preprocess_record; # extract $special, no HTML conversion
            & $conjugate;
        } # non-comment
    } # while <>
# main

#----------------------------------------------------------------
sub preprocess_record { # global: $vrecord
        $special = "";
        if ($vrecord =~ m/([\!\/])([a-z0-9\>]+)/) { # extract number of special processing routine
            $special = $2; # save it
            $vrecord =~ s/([\!\/])$special//; # remove it from entry
        }
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

sub postprocess_record { # global: $vrecord
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


sub init_form { # start output of forms for 1 verb
        ($glob_infin) = @_;
        $vrecord =  "$glob_infin\t=VbSIn0,$glob_infin";
    } # init_form

sub emit_form { # write to output file
        my ($tempus, @form) = @_;
        my $fi;
        if (scalar @form > 1) { 
            # list of all persons and numeri in a time
            for ($fi = 1; $fi < scalar @form; $fi ++) {
                if ($form[$fi] ne "") {
                    $vrecord .= $fsep . $form[$fi] . "\t=VbS${tempus}" . $person[$fi] . ",$glob_infin";
                }
            }
        } # list of all persons
        else { 
            # only 1 form for this time
                    $vrecord .= $fsep . $form[0  ] . "\t=VbS${tempus}0"               . ",$glob_infin";
        } # only 1 form
    } # emit_form

sub term_form { # end output of forms for 1 verb
        & postprocess_record;
        $vrecord =~ s/\+//g; # remove root/ending separators
        print "$vrecord\n";
    } # term_form

#------------------------------------------------------------------------
sub initiate_de {
    } # initiate_en

sub conjugate_de {
        print "# ", $vrecord, "\n" if $debug >= 2;
        my ($infin, $praes2, $imperf, $particip, $conjunct) = split (/\,/, $vrecord);
        $inrad = $infin; # keep these parallel with 'vbexpand.pl'!
        $inrad =~ s/e([lr])n\Z/e$1/;
        $inrad =~ s/en\Z//;
        $inrad =~ s/([^s])(d|t)\Z/${1}${2}e/; # caution: "bersten"
        #--------------------------
        # Praesens
        my @pres = ($infin, # [0]
            $inrad . "e", $praes2,          $praes2,
            $infin,          $inrad . "t", $infin
            );
        if    ($special eq "1") { # sein, totally irregular
            @pres = ("sein", "bin", "bist", "ist", "sind", "seid", "sind");
        }
        elsif ($special eq "2") { 
            # singular special: mo"gen, du"rfen, ko"nnen, mu"ssen, wollen, wissen
            $pres[3] = $pres[2]; # was changed by s//
            $pres[3] =~ s/[s]?t\Z//;
            $pres[1] = $pres[3];
        }
        elsif ($special eq "3") { # singular special: tun
            @pres = ("tun", "tue", "tust", "tut", "tun", "tut", "tun");
            $inrad = "tu";
        }
        else {
            # polish some endings
            if    ($inrad =~ m/ss\Z/)   { # lassen
            }
            elsif ($inrad =~ m/sS\Z/) { # giesSen
            }
            elsif ($inrad =~ m/s\Z/) { # wachsen, genesen etc.
                $pres[2] =~ s/ssst\Z/sst/;
                $pres[2] =~ s/sst\Z/st/ if $infin !~ m [ss]i; # du loest 2003-11-03
                $pres[3] = $pres[2];
            }
            elsif ($inrad !~ m/st\Z/) { # without "s"
                $pres[3] =~ s/st\Z/t/;
            }
        }
        $pres[1] =~ s/ee\Z/e/; # findee
        $pres[3] =~ s/irt\Z/ird/; # special: werden
        $pres[3] =~ s/tt\Z/t/; # special: halten
        $pres[5] =~ s/([dt])t\Z/${1}et/; # ihr werdet, reitet
        #--------------------------
        # Imperfekt
        my $improot = $imperf;
        $improot =~ s/(e)\Z//;
        my @impf = ($imperf, # [0]
            $imperf,                $imperf . "st",  $imperf,
            $improot . "en", $improot . "t",    $improot . "en"
            );
        $impf[2] =~ s/(s|sS)st\Z/${1}t/; # du asSt, wuchst
        $impf[2] =~ s/stst\Z/stest/; # du barstest
        $impf[5] =~ s/([dt])t\Z/${1}et/; # ihr wurdet, rittet, hattet
        #--------------------------
        # Imperativ
        my @impr = ($infin, "", $pres[2], "", $pres[4], $pres[5], "");
        if    ($special eq "1") { # sein, totally irregular
            @impr = ("sein", "", "sei", "", "sein", "seid", "");
        }
        elsif ($special eq "2") { 
            # singular special: mo"gen, du"rfen, ko"nnen, mu"ssen, wollen, wissen
        }
        elsif ($special eq "3") { # singular special: tun
            @impr = ("tun", "", "tu", "", "tun", "tut", "");
        }
        # polish some endings
        if    ($inrad !~ m/\"/) {
            $impr[2] =~ s/\"//; # remove umlaut
        }
        if    ($inrad =~ m/(z|s|sS)\Z/) {
            $impr[2] =~ s/[st]\Z//;
        }
        elsif ($inrad eq "hab") { # exception, otherwise "ha" below
            $impr[2] = $inrad;
        }
        elsif (($inrad !~ m/st\Z/)) {
            $impr[2] =~ s/st\Z//;
        }
        #--------------------------
        # Conjunctive I - praeSens
        my $csroot = $inrad;
        my @conjs = map { s/ee/e/; $_ } ($infin, # [0]
            $csroot . "e", $csroot . (($csroot =~ m/(s|t|S)\Z/) ? "est" : "st"), $csroot . "e",
            $csroot . "en", $csroot . "t",  $csroot . "en"
            );
        if    ($special eq "1") { # sein, totally irregular
            @conjs = ("sein", "sei", "seist", "sei", "seien", "seid", "seien");
        }
        $conjs[2] =~ s/(s|sS)st\Z/${1}t/; # du äßt, wüchst
        $conjs[2] =~ s/stst\Z/stest/; # du bärstest
        $conjs[5] =~ s/([dt])t\Z/${1}et/; # ihr würdet, rittet, hättet
        #--------------------------
        # Conjunctive II - praeTeritum
        my $ctroot = $conjunct;
        $ctroot =~ s/(e)\Z//;
        my @conjt = ($conjunct, # [0]
            $conjunct,  $ctroot . (($ctroot =~ m/(s|t|S)\Z/) ? "est" : "st"),    $conjunct,
            $ctroot . "en", $ctroot . "t",  $ctroot . "en"
            );
        $conjt[2] =~ s/(s|sS)st\Z/${1}t/; # du äßt, wüchst
        $conjt[2] =~ s/stst\Z/stest/; # du bärstest
        $conjt[5] =~ s/([dt])t\Z/${1}et/; # ihr würdet, rittet, hättet
        #--------------------------
        # Gerundium
        my $gerund = $infin . "d";
        if ($gerund !~ m/(e|l|r)nd\Z/) {
            $gerund =~ s/nd\Z/end/;
        }
        #--------------------------
        & init_form ($infin);
        & emit_form ("Pr", @pres);
        & emit_form ("Ip", @impf);
        & emit_form ("Im", @impr);
        & emit_form ("Pa", $particip);
        & emit_form ("Ge", $gerund);
        & emit_form ("Cs", @conjs);
        & emit_form ("Ct", @conjt);
        & term_form;
    } # conjugate_de

#-----------------------------------------------------------------------------
sub initiate_en {
    } # initiate_en

sub conjugate_en {
        print "# ", $vrecord, "\n" if $debug >= 2;
        my ($infin, $imperf, $particip, $gerund) = split(/\,/, $vrecord);
        #--------------------------
        # Present
        my @pres = ($infin, $infin, $infin, $infin . "s", $infin,   $infin, $infin);
        if      ($special eq "1")
        { # to be, totally irregular
            @pres = ($infin, "am",   "are", "is",   "are",  "are",  "are");
        }
        elsif ($special eq "2")
        { # to have, totally irregular
            @pres = ($infin, "have", "have", "has", "have", "have", "have");
        }
        # polish some endings
        if      ($infin =~ m/(o|ch|sh|s)\Z/)
        { # insert an "e" before 3rd pers. "s"
            $pres[3] =~ s/s\Z/es/;
        }
        elsif ($infin =~ m/([^aeiou])y\Z/)
        { # 3rd pers. ys -> ies 
            my $cons = $1;
            $pres[3] =~ s/${cons}ys\Z/${cons}ies/;
        }
        #--------------------------
        # Imperfect
        my @impf = ($infin, $imperf);
        if      ($special eq "1")
        { # to be, totally irregular
            @impf = ($infin, "was", "were", "was", "were", "were", "were");
        }
        #--------------------------
        & init_form ($infin);
        & emit_form ("Pr", @pres);

        & emit_form ("Ip", @impf);
        & emit_form ("Pf", $particip);
        & emit_form ("Im", $infin);
        & emit_form ("Ge", $gerund);
        & term_form;
    } # conjugate_en

#-----------------------------------------------------------------------------
sub initiate_es {
        $hend{"In,a"} = "ar";
        $hend{"Pr,a"} = join (",", ("ar", "o", "as", "a", "amos", "a\´is", "an"));
        $hend{"Ip,a"} = join (",", ("ar", "aba", "abas", "aba", "a\´bamos", "abais", "aban"));
        $hend{"Ps,a"} = join (",", ("ar", "e\´", "aste", "o\´", "amos", "asteis", "aron"));
        $hend{"Ft,a"} = join (",", ("ar", "are\´", "ara\´s", "ara\´", "aremos", "are\´is", "ara\´n"));
        $hend{"S1,a"} = join (",", ("ar", "e", "es", "e", "emos", "e\´is", "en"));
        $hend{"Im,a"} = join (",", ("ar", "", "a", "e", "emos", "ad", "en"));
        $hend{"Cd,a"} = join (",", ("ar", "ari\´a", "ari\´as", "ari\´a", "ari\´amos", "ari\´ais", "ari\´an"));
        $hend{"Ge,a"} = "ando";
        $hend{"Pc,a"} = "ado";

        $hend{"In,e"} = "er";
        $hend{"Pr,e"} = join (",", ("er", "o", "es", "e", "emos", "e\´is", "en"));
        $hend{"Ip,e"} = join (",", ("er", "i\´a", "i\´as", "i\´a", "i\´amos", "i\´ais", "i\´an"));
        $hend{"Ps,e"} = join (",", ("er", "i\´", "iste", "io\´", "imos", "isteis", "ieron"));
        $hend{"Ft,e"} = join (",", ("er", "ere\´", "era\´s", "era\´", "eremos", "ere\´is", "era\´n"));
        $hend{"S1,e"} = join (",", ("er", "a", "as", "a", "amos", "a\´is", "an"));
        $hend{"Im,e"} = join (",", ("er", "", "e", "a", "amos", "ed", "an"));
        $hend{"Cd,e"} = join (",", ("er", "eri\´a", "eri\´as", "eri\´a", "eri\´amos", "eri\´ais", "eri\´an"));
        $hend{"Ge,e"} = "iendo";
        $hend{"Pc,e"} = "ido";

        $hend{"In,i"} = "ir";
        $hend{"Pr,i"} = join (",", ("ir", "o", "es", "e", "imos", "i\´s", "en"));
        $hend{"Ip,i"} = join (",", ("ir", "i\´a", "i\´as", "i\´a", "i\´amos", "i\´ais", "i\´an"));
        $hend{"Ps,i"} = join (",", ("ir", "i\´", "iste", "io\´", "imos", "isteis", "ieron"));
        $hend{"Ft,i"} = join (",", ("ir", "ire\´", "ira\´s", "ira\´", "iremos", "ire\´is", "ira\´n"));
        $hend{"S1,i"} = join (",", ("ir", "a", "as", "a", "amos", "a\´is", "an"));
        $hend{"Im,i"} = join (",", ("ir", "", "e", "a", "amos", "id", "an"));
        $hend{"Cd,i"} = join (",", ("ir", "iri\´a", "iri\´as", "iri\´a", "iri\´amos", "iri\´ais", "iri\´an"));
        $hend{"Ge,i"} = "iendo";
        $hend{"Pc,i"} = "ido";

        $hend{"S2,x"} = join (",", ("xx", "ra", "ras", "ra", "ramos", "rais", "ran"));
        $hend{"S3,x"} = join (",", ("xx", "se", "ses", "se", "semos", "seis", "sen"));
        $hend{"Sf,x"} = join (",", ("xx", "re", "res", "re", "remos", "reis", "ren"));
    } # initiate_es

sub modify_es { # called for every single form - phonetic changes
        my ($root, $vend) = @_;
        return "" if ($vend eq ""); # some forms are missing for imperative
        if      ($special =~ m/\A(1)\Z/)
        {
        }
        elsif ($special =~ m/\A(16|17)\Z/)
        { # averiguar
            $root =~ s/gu\Z/g&uuml;/ if ($vend =~ m/\A[e]/);
        }
        elsif ($special =~ m/\A(21|37|39|42)\Z/)
        { # cazar, empezar, enraizar (37 = 39), forzar
            $root =~ s/z\Z/c/ if ($vend =~ m/\A[e]/);
        }
        elsif ($special =~ m/\A(23|32)\Z/)
        { # coger, dirigir
            $root =~ s/g\Z/j/ if ($vend =~ m/\A[ao]/);
        }
        elsif ($special =~ m/\A(24|47|53|66)\Z/)
        { # pagar, jugar
            $root =~ s/g\Z/gu/ if ($vend =~ m/\A[e]/);
        }
        elsif ($special =~ m/\A(34)\Z/)
        { # distinguir
            $root =~ s/gu\Z/g/ if ($vend =~ m/\A[ao]/);
        }
        elsif ($special =~ m/\A(22|49|86)\Z/)
        { # cocer, mecer, zurcir (22 = 49 = 86)
            $root =~ s/c\Z/z/ if ($vend =~ m/\A[ao]/);
        }
        elsif ($special =~ m/\A(25|48|54)\Z/)
        { # conocer, parecer, lucir (25 = 48 = 54)
            $root =~ s/c\Z/zc/ if ($vend =~ m/\A[ao]/);
        }
        elsif ($special =~ m/\A(85)\Z/)
        { # yacer
            $root =~ s/c\Z/zg/ if ($vend =~ m/\A[ao]/);
        }
        elsif ($special =~ m/\A(11|72|80)\Z/)
        { # sacar, trocar
            $root =~ s/c\Z/qu/ if ($vend =~ m/\A[e]/);
        }
        elsif ($special =~ m/\A(30)\Z/)
        { # delinquir
            $root =~ s/qu\Z/c/ if ($vend =~ m/\A[ao]/);
        }
        $root . "+" . $vend
    } # modify_es

sub special_es { # called for all forms together - general irregularities
        return if (length ($special) == 0);
        if      ($special eq "1") {
        }
        elsif ($special =~ 
            m/\A(9|10|11|12|15|16|22|24|29|31|33|37|38|39|42|43|47|50|52|56|63|66|69|80|84)\Z/)
        { # modify accentuated forms
            for my $ip (@mod_es_pr)
            {
                if  ($special =~ m/\A(29|33|37|56|66)\Z/)
                {
                    $hform{$ip} =~ s/e(.*)\+/ie$1\+/g;
                }
                elsif ($special =~ m/\A(10)\Z/)
                {
                    $hform{$ip} =~ s/i(.*)\+/ie$1\+/g;
                }
                elsif ($special =~ m/\A(11|12|39|43|63)\Z/)
                {
                    $hform{$ip} =~ s/i(.*)\+/i´$1\+/g;
                }
                elsif ($special =~ m/\A(16|22|24|38|42|50|80|84)\Z/)
                {
                    $hform{$ip} =~ s/o(.*)\+/ue$1\+/g;
                }
                elsif ($special =~ m/\A(31|52)\Z/)
                {
                    $hform{$ip} =~ s/o(.*)\+/hue$1\+/g;
                }
                elsif ($special =~ m/\A(9|15|69)\Z/)
                {
                    $hform{$ip} =~ s/u(.*)\+/u´$1\+/g;
                }
                elsif ($special =~ m/\A(47)\Z/)
                {
                    $hform{$ip} =~ s/u(.*)\+/ue$1\+/g;
                }
            } # for $ip
        } # accentuated

        elsif ($special =~ m/\A(13)\Z/) { # andar: Ps irregular
            my $ip = 0;
            map { $ip ++; $hform{"Ps" . "," . $ip} = "anduv" . "+" . $_ 
                        if ($_ ne "") 
                    } ("e", "iste", "o", "imos", "isteis", "ieron");
        } 
        elsif ($special =~ m/\A(18)\Z/) { # creer: Ps irregular
            my $ip = 0;
            map { $ip ++; $hform{"Ps" . "," . $ip} = $inrad . "+" . $_ 
                        if ($_ ne "") 
                    } ("", "", "o´", "", "", "eron");
            $hform{"Ge,0"} = $inrad . "+" . "endo"; 
        } 
        elsif ($special =~ m/\A(26)\Z/) { # bru&ntilde;ir: Ps irregular
            my $ip = 0;
            map { $ip ++; $hform{"Ps" . "," . $ip} = $inrad . "+" . $_ 
                        if ($_ ne "") 
                    } ("", "iste", "yo´", "i´mos", "isteis", "yeron");
            $hform{"Ge,0"} = $inrad . "+" . "yendo"; 
            $hform{"Pc,0"} = $inrad . "+" . "i´do"; 
        } 

        if ($special =~ m/\A(84)\Z/) { # volver
            $hform{"Pc,0"} =~ s/olv\+ido\Z/uel\+to/; # olvido -> uelto
        }
    } # special_es

sub conjugate_es {
        print "# ", $vrecord, "\n" if $debug >= 2;
        my ($infin, @rest) = split(/\,/, $vrecord);
        $infin =~ m/([aei])r\Z/; # extract root vowel
        $inrad  = $`; # before the match
        $evowel = $1;
        my @pers;

        for (my $it = 0; $it < scalar @tim_es; $it ++) { 
            # store all verb forms for later special modification
            @pers = map (& modify_es ($inrad, $_), 
                split (/\,/, $hend{$tim_es[$it] . "," . $evowel}));
            for (my $ip = 0; $ip < scalar @pers; $ip ++)
            { # $hform stores raw conjugated forms: $inrad+$hend for this $evowel
                $hform{$tim_es[$it] . "," . $ip} = $pers[$ip];
            } # for $ip
        } # for $it

        & special_es; # apply special modification rules

        & init_form ($infin);
        my $ps6; # 3rd person of Passe simple
        for (my $it = 1; $it < scalar @tim_es; $it ++) {
            # output all verb forms
            @pers = 
                split (/\,/, $hend{$tim_es[$it] . "," . $evowel});
            for (my $ip = 0; $ip < scalar @pers; $ip ++) {
                # $hform stores raw conjugated forms: $inrad+$hend for this $evowel
                $pers[$ip] = $hform{$tim_es[$it] . "," . $ip};
            } # for $ip
            # print join (",", @pers) . "\n";
            & emit_form ($tim_es[$it], @pers);
            if      ($tim_es[$it] eq "Ps") { 
                $ps6 = $pers[6]; # derive subj. pret + fut. from that
                $ps6 =~ s/\+//; 
                $ps6 =~ s/ron\Z//; # root for subj. derived forms
            }
            elsif ($tim_es[$it] eq "S1") { 
                # derived forms
                @pers = map { $ps6 . "+" . $_ } split (/\,/, $hend{"S2,x"}); 
                & emit_form ("S2", @pers);
                @pers = map { $ps6 . "+" . $_ } split (/\,/, $hend{"S3,x"}); 
                & emit_form ("S3", @pers);
                @pers = map { $ps6 . "+" . $_ } split (/\,/, $hend{"Sf,x"}); 
                & emit_form ("Sf", @pers);
            }
        } # foreach $tim
        & term_form;
    } # conjugate_es
