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
# evaluate words in TEMP table
# find pairs of correlated words
# manually edit the extracted list
# store their grammatical meaning
# @(#) $Id: forge_eval.pl 36 2008-09-08 06:05:06Z gfis $
# 2007-02-01: no org.punctum
# 2007-01-04: Dbat
# 2006-06-05: Georg Fischer
#-------------------------------------------------------------------------
use strict;

    $/ = "\n\n"; # paragraph mode
    my $JAVA  = "java -classpath ../dist/gramword.jar;../lib/mysql.jar;../lib/dbat.jar";
    my $DBAT  = "$JAVA org.teherba.dbat.Dbat -e UTF-8";
    my $REENC = "$JAVA org.teherba.gramword.ReEncode";
    my $lowera = 0; # whether to lower a.entry; is always reset in eval_table
    my $tableb = "forge"; # is always reset in eval_table
    my $editor = 1; # whether to call an editor
    
    my $busy = 1;
    & load_temp("select enrel, morel,'', '' from forge where length(enrel) > 0 and length(morel) > 0");
    & insert_temp();
    $busy = 0;

    print `make forge_verb2` if $busy;
    & insert_temp ();
    
    print `make forge_verb1` if $busy;
    $tableb = "temp";
    & eval_cross  ("Sel-Veln"           , "el"      , "SbSgMs"      , "eln"     , "VbIn"); 

    print `make forge_verb1` if $busy;
    $tableb = "temp";
    & eval_cross  ("Ser-Ven"            , "er"      , "SbSgMs"      , "en"      , "VbIn"); 
    
    & sel_other   ("words"              , "en"      , "VbSIn"                   , 1         ); # invalid chars
    & eval_cross  ("VbStrg"             , ""        , "SbSgNt"      , ""        , "VbInStrg"); # invalid chars

    # for de dictionary
    & eval_simple ("Xel"                , "el"      , "SbSgMs"                              );
    & eval_simple ("Xler"               , "ler"     , "SbSgMs"                              );
    & eval_cross  ("Xler-Xel"           , "ler"     , "SbSgMs"      , "el"      , "SbSgMs"  );
    & eval_simple ("Xlein"              , "lein"    , "SbSgNtDimt"                          );
    & eval_simple ("Xle"                , "le"      , "SbSgFm"                              );

    & sel_other   ("words"              , "en"      , "VbSIn"                   , 1         ); # invalid chars
    & eval_cross  ("VbStrg"             , ""        , "SbSgNt"      , ""        , "VbInStrg"); 
    & sel_other   ("words               ", ""       , "Nm"                      , 0         ); # invalid chars
    & eval_cross  ("nameX"              , ""        , "Sb"          , ""        , "Nm"      ); 
    
    & eval_cross  ("Xen.um-Xe"          , "en:"     , "SbPlAc"      , "e"       , "SbSg"    ); 
    & eval_cross  ("Xen-Xe"             , "en"      , "SbPlAc"      , "e"       , "SbSg"    ); 
    & eval_cross  ("Xe-X"               , "e"       , "SbPl"        , ""        , "SbSg"    ); 
    & eval_cross  ("Xen-X"              , "en"      , "SbPlAc"      , ""        , "SbSg"    ); 
    & eval_cross  ("Xe.um-X"            , "e:"      , "SbPl"        , ""        , "SbSg"    ); 
    & eval_cross  ("Xen.um-X"           , "en:"     , "SbPlAc"      , ""        , "SbSg"    ); 
    & eval_cross  ("Xern-Xer"           , "ern"     , "SbPlAc"      , "er"      , "SbSg"    );
    & eval_cross  ("Xeln-Xel"           , "eln"     , "SbPlAc"      , "el"      , "SbSg"    );
    & eval_cross  ("X.um-X"             , ":"       , "SbPl"        , ""        , "SbSg"    ); 
    & eval_cross  ("Xer.um-X"           , "er:"     , "SbPl"        , ""        , "SbSg"    );
    & eval_cross  ("Xchen-Xe"           , "chen"    , "SbSgNtDimt"  , "e"       , "SbSgFm"  );
    & eval_cross  ("Xchen.um-X"         , "chen:"   , "SbSgNtDimt"  , ""        , "SbSg"    );
    & eval_cross  ("Xchens-X"           , "chens"   , "SbSgNtGeDimt"    , ""        , "SbSgNtDimt"  );
    & eval_cross  ("Xchens.um-X"        , "chens:"  , "SbNtGeDimt"  , ""        , "SbNtSgDimt");
    & eval_cross  ("Xschen-X"           , "schen"   , "AjPlName"    , ""        , "NmSurn"  );
    & eval_cross  ("Xchen-X"            , "chen"    , "SbNtDimt"    , ""        , "SbSg"    );
    & eval_cross  ("Xchen.um-Xen"       , "chen:"   , "SbNtDimt"    , "en"      , "SbMsSg"  );
    & eval_cross  ("Xchen.um-Xe"        , "chen:"   , "SbNtDimt"    , "e"       , "SbFmSg"  );
    & eval_cross  ("Xes.um-X.um"        , "es:"     , "SbGe"        , ":"       , "SbSg"    ); 
    & eval_cross  ("Xes-X"              , "es"      , "SbGe"        , ""        , "SbSg"    );
    & eval_cross  ("Xs.um-X.um"         , "s:"      , "SbGe"        , ":"       , "SbSg"    ); 
    & eval_cross  ("Xs-X"               , "s"       , "SbGe"        , ""        , "SbSg"    );
    & eval_cross  ("Xer-Xe"             , "er"      , "SbSgMs"      , "e"       , "SbSgFm"  ); 
    & eval_cross  ("Xer-X"              , "er"      , "SbSgMs"      , ""        , "SbSg"    ); 
    & eval_simple ("Xin"                , "in"      , "SbSgMs"                              );
    & eval_cross  ("Xei"                , "ei"      , "SbSgFm"      , "",       , "Sb"      );
    $busy = 0;
    
sub sel_other {
    return if ! $busy;
    my ($table, $suffixb, $morphb, $lowa) = @_;
    $lowera = $lowa;
    $tableb = "temp";
    print `$DBAT -f temp_create.sql`;
    my $sql = << "GFis"
            SELECT entry, morph, entry, enrel 
            FROM $table b
            WHERE 
GFis
    ;
    if ($suffixb ne "") {
        $sql .= " b.entry LIKE \'\%$suffixb\' AND"
    }
    $sql .= " b.morph LIKE \'$morphb\%\'";
    & load_temp($sql);
}

sub load_temp {
    return if ! $busy;
    my ($sql) = @_;
    $sql =~ s[\s+][ ]g;
    print STDERR "sel_other: $sql\n";
    print `$DBAT -x \"$sql\" > x1.tmp`;
    print `$REENC -e UTF-8 -s x1.tmp > x2.tmp`;
    print `cat x2.tmp | $DBAT -r temp`;
} # load_other 

sub eval_simple {
    return if ! $busy;
    my ($name, $suffixa, $morpha) = @_;
    my $suflena = length ($suffixa);
    my $sql = << "GFis"
        SELECT a.entry, ''
          FROM forge a
          WHERE
GFis
    ;
    if ($suffixa ne "") {
        $sql .= " a.entry LIKE \'\%$suffixa\'"
    }
    $sql .= " AND a.morph = \'xx\' ORDER BY 1";
    $sql =~ s[\s+][ ]g;
    print STDERR "$name: $sql\n";
    my $outfile = "$name.man";
    my $pstmt = "print OUT \"\$cols[0]\t$morpha\t\$cols[1]\t\n\";";
    & eval_table ($outfile, $sql, $pstmt);
} # eval_simple

sub eval_cross {
    return if ! $busy;
    my ($name, $suffixa, $morpha, $suffixb, $morphb) = @_;
    my $suflena = length ($suffixa);
    my $suflenb = length ($suffixb);
    my $sql = << "GFis"
        SELECT a.entry, b.entry 
          FROM forge a, $tableb b 
          WHERE
GFis
    ;
    if ($suffixa ne "") {
        $sql .= " a.entry LIKE \'\%$suffixa\' AND"
    }
    if ($suffixb ne "") {
        $sql .= " b.entry LIKE \'\%$suffixb\' AND"
    }
    $sql .= ($lowera) ? " lower(" : "(";
    if ($suffixa ne "") {
        $sql .= " substring(a.entry, 1, length(a.entry) - $suflena)"
    }
    else {
        $sql .= " a.entry"
    }
    $sql .= ") =";
    if ($suffixb ne "") {
        $sql .= " substring(b.entry, 1, length(b.entry) - $suflenb)"
    }
    else {
        $sql .= " b.entry"
    }
    $sql .= " AND a.morph = \'xx\' ORDER BY 1";
    $sql =~ s[\s+][ ]g;
    print STDERR "$name: $sql\n";
    my $outfile = "$name.man";
    my $pstmt = "print OUT \"\$cols[0]\t$morpha\t\$cols[1]\t$morphb\n\";";
    & eval_table ($outfile, $sql, $pstmt);
} # eval_cross 

sub eval_table {
    $lowera = 0;
    $tableb = "forge";
    return if ! $busy;
    my ($outfile, $sql, $pstmt) = @_;
    my $cmd;
    if (-r $outfile) { 
        # outfile exists (was probably already edited)
    }
    else { # create new outfile
        $cmd = "$DBAT -x \"$sql\"";
        open (OUT, ">", $outfile) || die "$0: cannot create \"$outfile\"\n";
        foreach my $line (split (/\r?\n/, `$cmd`)) {
            my @cols = split (/\t/, $line);
            eval ($pstmt);
        } # foreach
        close (OUT);
        if ($editor) {
            # print `notepad $outfile`; # problem: terminal for vim not visible
            print `uedit32 $outfile`; # problem: terminal for vim not visible
            print `cmd /c pause`;
        }
    }
    print `$DBAT -f temp_create.sql`;
    print `cat $outfile | $DBAT -r temp`;
    & insert_temp ();
} # sub eval_table

sub insert_temp {
    return if ! $busy;
    print `$DBAT \"DELETE FROM forge WHERE (entry, morph) in (SELECT entry, morph FROM temp)\"`;
    print `$DBAT \"INSERT INTO forge (SELECT * FROM temp)\"`;
} # sub insert_temp

__DATA__
# e-n;
SELECT a.entry, b.entry FROM forge a, forge b 
WHERE a.entry = concat(b.entry, 'n')
  AND b.entry like '%e';
print OUT "$cols[0]\tSbF9N,$cols[1]=SbF1N\n";

# e.um;
SELECT a.entry, b.entry FROM forge a, forge b 
WHERE a.entry = concat(b.entry, 'e', ':');
print OUT "$cols[0]\tSbM9N,$cols[1]=SbM1N\n";

# en.um;
SELECT a.entry, b.entry FROM forge a, forge b 
WHERE a.entry = concat(substring(b.entry, 1, length(b.entry) - 2), 'en', ':');
print OUT "$cols[0]\tSbM9A,$cols[1]=SbM1N\n";

en-um;
SELECT a.entry, b.entry FROM forge a, forge b 
WHERE a.entry = concat(b.entry, ':')
  AND b.entry like '%en';
print OUT "$cols[0]\tSbM9N,$cols[1]=SbM1N\n";

er-um;
SELECT a.entry, b.entry FROM forge a, forge b 
WHERE a.entry = concat(b.entry, ':')
  AND b.entry like '%er';
print OUT "$cols[0]\tSbM9N,$cols[1]=SbM1N\n";
