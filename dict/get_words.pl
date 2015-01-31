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
# get words and their grammatical type from dictionary file
# @(#) $Id: get_words.pl 36 2008-09-08 06:05:06Z gfis $
# 2006-06-02: with reference if German umlaut/sz; uses UTF-8 äöüß
# 2006-05-27, Georg Fischer
#-------------------------------------------------------------------------
use strict;
use utf8;
    
    binmode(STDIN , ":utf8");
    # binmode(STDOUT, ":utf8");
    while (<>) {
        next if m/^\s*$/ || m/^\#/; # skip comments and empty lines
        s/\s*\=\s*/\t/; # eq+whitespace to tab
        s/\,/\t/; # comma to tab
        my ($part, $morph, $descr) = split (/\t/);
        if (($part =~ m/[äöüßÄÖÜ]/) && ($morph !~ m/^Ex/)) {
            my $orig = $part;
            $part =~ s/ä/ae/g;
            $part =~ s/ö/oe/g;
            $part =~ s/ü/ue/g;
            $part =~ s/Ä/Ae/g;
            $part =~ s/Ö/Oe/g;
            $part =~ s/Ü/Ue/g;
            $part =~ s/ß/ss/g;
            print "$part\tExUE\t$orig\n"; # append exchange reference to original
        }
        print;
    }

__DATA__
