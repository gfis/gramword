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
# take prefixes from first file, and suffixes from second,
# and build all word combinations from both
# 2006-07-26: use utf8
# 2006-07-24: don't generate an empty entry
# 2004-08-02, Georg Fischer <punctum@punctum.com>
#
# caution, this script must be stored in UTF-8 äöüÄÖÜß
#
# activation:
#   perl crossproduct.pl some.pre other.suf > combined.tmp
# 
# skip over empty lines, and comments starting with "#"
# convert "~" to empty string
#------------------------------------------------------------
use strict;
use locale;
binmode(STDIN, ":utf8"); # don't use utf8 !

# global variables
    my $debug = 0;
    
# evaluate arguments
    while (scalar @ARGV > 0 && ($ARGV[0] =~ m[\-])) {
        my $opt = shift (@ARGV);
        if (0) {}
        elsif ($opt =~ m[t(est)?]) {
            $debug = 1;
        }
    } # while options   

    my $infile1 = shift(@ARGV);
    open (PRE, "<$infile1") || die "cannot read $infile1\n";
    my $infile2 = shift(@ARGV);
    
# input loop 1 - read prefixes 
    while (<PRE>) {
        s[\s][]g; # chompr
        next if m[\A\Z];
        next if m[^\#]; # skip over comments
        s[\~][]; # indicates empty string
        s[\=.*][]; # remove morphology
        my $prefix = $_;
        open (SUF, "<$infile2") || die "cannot read $infile2\n";
        while (<SUF>) { # read suffixes
            s[\s][]g; # chompr
            next if m[\A\Z];
            next if m[^\#]; # skip over comments
            s[\~][]; # indicates empty string
            my $suffix = $_;
            if ("$prefix$suffix" !~ m[\A\=]) { # C3 9F = UTF-8 ("ß")
                my $e = (($prefix =~ m/[stß]\Z/) && ($suffix =~ m/\A(st)/)) ? "e" : "";
                print "$prefix$e$suffix\n";
            }
        } # while <suf>
        close (SUF);
    } # while <PRE>
    close (PRE);
    