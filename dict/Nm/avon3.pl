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
# "big" German cities (with telephone number prefixes of 2 or 3 digits)
# @(#) $Id: avon3.pl 36 2008-09-08 06:05:06Z gfis $
# 2006-07-18, Georg Fischer
# output in UTF-8

use strict;
use locale;
    
    binmode(STDOUT, ":utf8");
    while (<>) {
        next if m/^\#/;
        next if m/^\s*$/;
        s/^\s+//;
        my ($prefix, $name, @rest) = split (/\,/);
        next if length($prefix) > 4;
        $prefix =~ s[\A0][]; # remove leading zero
        $name =~ s[Bad\s+][]; # Bad Kissingen
        $name =~ s[Neu\-][]; # Neu-Ulm
        print "$name\t=NmGeogCityDe\.$prefix\n";
    }
