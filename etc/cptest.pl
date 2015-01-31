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
# check jars in CLASSPATH for readability
# @(#) $Id: cptest.pl 36 2008-09-08 06:05:06Z gfis $
# Copyright (c) 2006 Dr. Georg Fischer <punctum@punctum.com>
# 2006-04-21: copied from client.pl
#
# Usage: 
#   set CLASSPATH=...
#   perl cptest.pl
#------------------------------------------------------------------ 

use strict;

    my @cp = split (/[\;]/, $ENV{"CLASSPATH"});
    foreach my $jar (@cp) {
        $jar =~ s[\\][\/]g;
        if (! -r $jar) {
            print "cannot read $jar\n";
        }
        else {
            print "found $jar\n";
        }
    }
    