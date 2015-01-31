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
# insert quadruples from *.man in temp table, 
# and merge them into forge table
# *.man entries already have trailing COLONs instead of umlauts
# @(#) $Id: load_man.pl 36 2008-09-08 06:05:06Z gfis $
# 2007-01-04: Dbat
# 2006-07-19: Georg Fischer
#-------------------------------------------------------------------------
use strict;

    my $JAVA = "java -classpath ../dist/gramword.jar;../lib/mysql.jar;../lib/dbat.jar";
    my $DBAT = "$JAVA org.teherba.dbat.Dbat -e UTF-8";

    my $manfile = shift (@ARGV);
    print "manfile\n";
    
    print `$DBAT -f temp_create.sql`;
    print `cat $manfile | $DBAT -r temp`;
    print `$DBAT \"DELETE FROM forge WHERE (entry, morph) in (SELECT entry, morph FROM temp)\"`;
    print `$DBAT \"INSERT INTO forge (SELECT * FROM temp)\"`;
