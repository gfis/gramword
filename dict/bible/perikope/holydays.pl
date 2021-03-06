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
#------------------------------------------------------------
# caution, this file uses UTF-8 encoding: äöüÄÖÜ
# still to check: augsb = 06-25 or 06-26?
#
# German holy day names and abbreviations 
# from de.wikipedia.org ... Perikopen
# @(#) $Id: holydays.pl 976 2013-02-02 16:44:18Z gfis $
# 2008-04-07: BaseCalendar -> EasterCalendar
# 2008-02-13: Java 1.5 typing
# 2007-03-08, Dr. Georg Fischer 
#
# Activation:
#   perl holydays.pl [-abbr|-list|-dict|-java] > holydays.dic
#
# For each input line, the following rows for table INFOS
# (with dict columns ENTRY, MORPH, ENREL, MOREL) are generated:
# $holyd#ccal.nas.$lang#$name_short#$attr
# $holyd#ccal.nal.$lang#$name_long#$attr
# $holyd#ccal.exp#$expr#
#
# For -java, the class churchcal/DayMap.java is generated.
#------------------------------------------------------------
use strict;
use utf8;
    binmode(STDOUT, ":utf8");

# evaluate arguments
    my $action = shift(@ARGV);
    
    if ($action eq "-java") {
        print <<'GFis';
/*
 * Copyright 2006 Dr. Georg Fischer <punctum at punctum dot kom>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
/*  Maps from names of days to <em>Day</em>s (with their formulas).
    @(#) $Id: holydays.pl 976 2013-02-02 16:44:18Z gfis $
    
    Caution, this file is generated by ../org/teherba/gramword/dict/bible/perikope/holydays.pl
    DO NOT EDIT HERE!
*/

package org.teherba.churchcal;
import  org.teherba.churchcal.EasterCalendar;
import  org.teherba.churchcal.Day;
import  java.io.BufferedReader;
import  java.io.FileInputStream;
import  java.io.InputStreamReader;
import  java.nio.channels.Channels;
import  java.util.HashMap;
import  java.util.Iterator;
import  java.util.TreeMap;
import  java.util.regex.Matcher;
import  java.util.regex.Pattern;
import  org.apache.log4j.Logger;

/** Maps from names of days to {@link Day}s (with their formulas),
 *  and provides some testing methods.
 *  @author Dr. Georg Fischer
 */
public class DayMap extends HashMap/*<1.5*/<String, Day>/*1.5>*/ {
    public final static String CVSID = "@(#) $Id: holydays.pl 976 2013-02-02 16:44:18Z gfis $";
    /** log4j logger (category) */
    private Logger log;

    /** No-args Constructor - stores the properties of all holy days.
     *  The holy day codes are mapped to <em>Day</em>s which
     *  have their <em>name</em> and <em>formula</em> properties set.
     *  The formulas take the following forms:
     *  <ul>
     *  <li><em><strong>anc</strong>i+-dist</em> - day distance to anchor day i</li>
     *  <li><em><strong>fix=</strong>mm-dd</em> - fixed date: month and day in month</li>
     *  <li><em><strong>var</strong></em> - the date is locally defined 
     *      and cannot be determined from the year</li>
     *  <li><em><strong>wrm</strong>w.mm</em> - first weekday w in month mm, where January = 01,
     *      and Sunday = 1 (as in Java), 8 = 2nd Sunday in month, 16 = 3rd Monday etc.</li>
     *  </ul>
     */
    public DayMap() {
        super(128);
        log = Logger.getLogger(DayMap.class.getName());
GFis
    } # if -java
# read DATA
    while (<DATA>) {
        s/\r?\n//; # chompr
        my ($lang, $attr, $holyd, $name_short, $name_long, $formula) = split(/\#/);
        if ($formula =~ m/\Atrin\+(\d+)\Z/) {
            $formula = "east0+" . (56 + $1);
        }
        if (0) {
        } elsif ($formula =~ m/\Aeast0([\+\-])(\d+)\Z/) {
            $formula = "anc1$1$2";
        } elsif ($formula =~ m/\Aepi1([\+\-])(\d+)\Z/) {
            $formula = "anc0$1$2";
        } elsif ($formula =~ m/\Aadv1([\+\-])(\d+)\Z/) {
            $formula = "anc2$1$2";
        } elsif ($formula =~ m/\Afix=(\d+)\-(\d+)\Z/) {
            $formula = "$formula";
        } elsif ($formula =~ m/\Awrm(\d+)\.(\d+)\Z/) {
            $formula = "$formula";
        } elsif ($formula =~ m/\Avar\Z/) {
            $formula = "$formula";
        } else {
            print "\t\t/* invalid formula \"$formula\" */\n";
        }
        if (0) {
        } elsif ($action eq "-abbr") {
            print "$holyd\n";
        } elsif ($action eq "-list") {
            print "$holyd\n";
        } elsif ($action eq "-dict") {
            print <<"GFis";
$holyd#ccal.nas.$lang#$name_short#$attr
$holyd#ccal.nal.$lang#$name_long#$attr
$holyd#ccal.forml#$formula#
GFis
        } elsif ($action eq "-java") {
            print "\t\tthis.put(\"" . sprintf("%-10s", "$holyd\"") 
                    . ", new Day(\"" . sprintf("%-10s", "$holyd\"") . ", \"$formula\"));\n";
        } else {
            print "\t\t/* invalid action code $action*/\n";
        }
    } # while DATA          
    
    if ($action eq "-java") {
        print <<'GFis';
    }

    /** Pattern for (ISO date, separator, name) */
    private static Pattern ISO_NAME_PATTERN 
            = Pattern.compile("\\A(\\d{4})\\-(\\d\\d)\\-(\\d\\d)\\W+(\\w+)");
            /*                      1         2          3          4   */

    /** Parses a text file, and tries to recognize
     *  number words in the lines.
     *  Print
     *  @param fileName name of the file to be parsed,
     *  or read from STDIN if null or empty
     */
    public void parseFile(String fileName) {
        int year = 0;
        EasterCalendar calendar = new EasterCalendar(year);
        try {
            BufferedReader reader = new BufferedReader
                    ((fileName != null && fileName.length() <= 0)
                    ? new InputStreamReader(System.in, "UTF-8")
                    : Channels.newReader((new FileInputStream (fileName)).getChannel(), "UTF-8"));
            String line = null; // current line from text file
            while ((line = reader.readLine()) != null) { 
                System.out.print(line);
                Matcher matcher = ISO_NAME_PATTERN.matcher(line);
                if (matcher.lookingAt()) {
                    int myear = Integer.parseInt(matcher.group(1));
                    int mmon  = Integer.parseInt(matcher.group(2));
                    int mday  = Integer.parseInt(matcher.group(3));
                    String mname = (matcher.group(4));
                    if (myear != year) {
                        calendar = new EasterCalendar(myear);
                        year = myear;
                    }
                    Day day = calendar.computeHolyDay(mname);
                    if (day != null) {
                        String isoDate = day.getYear()
                                + "-" + Integer.toString(day.getMonth() + 100).substring(1)
                                + "-" + Integer.toString(day.getDay  () + 100).substring(1)
                                ;
                        if (myear == day.getYear() && mmon == day.getMonth() && mday == day.getDay()) {
                            System.out.print(" -> ok");
                        } else {
                            System.out.print(" <> " + isoDate);
                        }   
                    } else if (! mname.equals("profan")) {
                        System.out.print(" ?? no formula or not recognized");
                    }
                } else { // doesn't match
                    // System.out.print(" ?? no proper input format: ISO_DATE SEP NAME");               
                }
                System.out.println();
            } // while ! eof
        } catch (Exception exc) {
            log.error(exc.getMessage(), exc);
            exc.printStackTrace();
        } 
    } // parseFile

    /** Prints all Sundays and holy days in a year
     *  @param year list holy days for this year 
     *  (or for the current year if = 0)
     */
    public void printDays(int year) {
        try {
            EasterCalendar calendar = new EasterCalendar(year);
            TreeMap/*1.5*/<String, String>/*1.5*/ sortedDays = new TreeMap/*1.5*/<String, String>/*1.5*/();
            Iterator iter = this.keySet().iterator();
            while (iter.hasNext()) {
                String name = (String) iter.next();
                Object obj = this.get(name);
                if (obj != null) {
                    Day day = (Day) obj;
                    String formula = day.getFormula();
                    Day holyDay = calendar.computeHolyDay(day.getName());
                    if (holyDay != null) {
                        String isoDate = holyDay.getYear()
                                + "-" + Integer.toString(holyDay.getMonth() + 100).substring(1)
                                + "-" + Integer.toString(holyDay.getDay  () + 100).substring(1)
                                ;
                        sortedDays.put(isoDate, name + "\t" + formula);
                    }
                }
            } // while hasNext
            
            // now print sorted dates and names 
            iter = sortedDays.keySet().iterator();
            while (iter.hasNext()) {
                String isoDate = (String) iter.next();
                String name    = (String) sortedDays.get(isoDate);
                System.out.println(isoDate +  "\t" + name);
            } // while printing
        } catch (Exception exc) {
            log.error(exc.getMessage(), exc);
            exc.printStackTrace();
        } 
    } // parseFile

    /** Main program:
     *  <ul>
     *  <li>prints all Sundays and holy days in a specified year
     *  (current year if missing), or<li>
     *  <li>checks a file (or System.in if missing) 
     *  with dates and named holy days.</li>
     *  </ul>
     *  @param args commandline arguments; if missing, print the following:
     *  <pre>
     *  usage:\tjava org.teherba.churchcal.DayMap [-year [nnnn] | -parse [filename]]
     *  </pre>
     */
    public static void main(String args[]) {
        int iarg = 0;
        if (iarg >= args.length) {
            System.err.println("usage:\tjava org.teherba.churchcal.DayMap"
                    + " [-year nnnn | -parse [filename]]\n"
                    );
        } else {
            String action = args[iarg ++];
            DayMap holyDayMap = new DayMap();
            if (false) {
            } else if (action.startsWith("-p")) {
                String fileName = null;
                if (iarg < args.length) {
                    fileName = args[iarg ++];
                }
                holyDayMap.parseFile(fileName);
            } else if (action.startsWith("-y")) {
                int year = 0;
                if (iarg < args.length) {
                    year = Integer.parseInt(args[iarg ++]);
                }
                holyDayMap.printDays(year);
            } else {
                System.err.println("invalid action \"" + action + "\"");
            }
        }
    } // main
    
} // DayMap (generated)
GFis
    } # if -java
# unclear: hfriday II, Leidensgesch. = Mt 27,1-52?
__DATA__
deu#ev,ka    #adv1#1. Advent#1. Sonntag im Advent#adv1+0
deu#ev,ka    #adv2#2. Advent#2. Sonntag im Advent#adv1+7
deu#ev,ka    #adv3#3. Advent#3. Sonntag im Advent#adv1+14
deu#ev,ka    #adv4#4. Advent#4. Sonntag im Advent#adv1+21
deu#ev,ka    #xmas0#Heiliger Abend#Heiliger Abend#fix=12-24
deu#ev       #xmas0Z18#Christvesper#Heiliger Abend - Christvesper#fix=12-24
deu#ev       #xmas0Z22#Christnacht#Heiliger Abend - Christnacht#fix=12-24
deu#ev,ka    #xmasP1#1. Weihnachstag#Christfest - 1. Feiertag#fix=12-25
deu#ev,ka    #xmasP2#2. Weihnachtstag#Christfest - 2. Feiertag#fix=12-26
deu#ev,ka    #xmasP3#3. Weihnachtstag#Christfest - 3. Feiertag#fix=12-27
deu#ev,ka    #xmasS1#1. So.n.Weihn.#1. Sonntag nach dem Christfest#adv1+28
deu#ev,ka    #silv#Sivester#Altjahrsabend: Silvester#fix=12-31
deu#ev,ka    #circ#Jesu Darst.#1. Januar, Tag der Beschneidung und Namensgebung Jesu#fix=01-01
deu#ev,ka    #circP1#2. Neujahrstag#Tag nach dem Fest der Beschneidung Christi#fix=01-02
deu#ev,ka    #xmasS2#2. So.n.Weihn.#2. Sonntag nach dem Christfest#epi1-7
deu#ev       #epi#Epiph.#Epiphanias#fix=01-06
deu#   ka    #3koen#Hl. 3 Kön.#Heilige 3 Könige#fix=01-06
deu#ev,ka    #epi1#1. So.n.Epiph.#1. Sonntag nach Epiphanias#epi1+0
deu#ev,ka    #epi2#2. So.n.Epiph.#2. Sonntag nach Epiphanias#epi1+7
deu#ev,ka    #epi3#3. So.n.Epiph.#3. Sonntag nach Epiphanias#epi1+14
deu#ev,ka    #epi4#4. So.n.Epiph.#4. Sonntag nach Epiphanias#epi1+21
deu#ev,ka    #epi5#5. So.n.Epiph.#5. Sonntag nach Epiphanias#epi1+28
deu#ev,ka    #epi9#Letzter So.n.Epiph.#Letzter Sonntag nach Epiphanias#east0-70
deu#ev,ka    #septu#Septuagesimä#Septuagesimä: 3. Sonntag vor der Passionszeit#east0-63
deu#ev,ka    #sexag#Sexagesimä#Sexagesimä: 2. Sonntag vor der Passionszeit#east0-56
deu#ev,ka    #estom#Estomihi#Estomihi: Sonntag vor der Passionszeit#east0-49
deu#ev,ka    #fast0#Rosenmontag#Rosenmontag#east0-48
deu#ev,ka    #fast1#Fastnacht#Fastnachtsdienstag#east0-47
deu#ev,ka    #fast2#Aschermittw.#Aschermittwoch#east0-46
deu#ev,ka    #invoc#Invokavit#Invokavit: 1. Sonntag der Passionszeit#east0-42
deu#ev,ka    #remin#Reminiszere#Reminiszere: 2. Sonntag der Passionszeit#east0-35
deu#ev,ka    #oculi#Okuli#Okuli: 3. Sonntag der Passionszeit#east0-28
deu#ev,ka    #laeta#Lätare#Lätare: 4. Sonntag der Passionszeit#east0-21
deu#ev,ka    #judic#Judika#Judika: 5. Sonntag der Passionszeit#east0-14
deu#ev,ka    #palma#Palmsonntag#Palmsonntag: 6. Sonntag der Passionszeit#east0-7
deu#ev,ka    #eastM3#Gründonnerstag#Gründonnerstag: Tag der Einsetzung des Abendmahls#east0-3
deu#ev,ka    #eastM2#Karfreitag#Karfreitag: Tag der Kreuzigung des Herrn#east0-2
deu#ev,ka    #eastM1#Karsonnabend#Karsonnabend#east0-1
deu#ev,ka    #east0#Ostersonntag#Ostersonntag: Tag der Auferstehung des Herrn#east0+0
deu#ev,ka    #eastP1#Ostermontag#Ostermontag#east0+1
deu#ev,ka    #eastP2#Osterdienstag#Osterdienstag#east0+2
deu#ev       #quasi#Quasimodogeniti#Quasimodogeniti: 1. Sonntag nach Ostern#east0+7
deu#   ka    #quasi#Weißer Sonntag#Weißer Sonntag#east0+7
deu#ev,ka    #miser#Miserikordias Dom.#Miserikordias Domini: 2. Sonntag nach Ostern#east0+14
deu#ev,ka    #jubil#Jubilate#Jubilate: 3. Sonntag nach Ostern#east0+21
deu#ev,ka    #canta#Kantate#Kantate: 4. Sonntag nach Ostern#east0+28
deu#ev,ka    #rogat#Rogate#Rogate: 5. Sonntag nach Ostern#east0+35
deu#ev,ka    #chrasc#Christi Himmelf.#Christi Himmelfahrt#east0+39
deu#ev,ka    #exaud#Exaudi#Exaudi: 6. Sonntag nach Ostern#east0+42
deu#ev,ka    #pent0#Pfingsten#Pfingstsonntag: Tag der Ausgießung des Heiligen Geistes#east0+49
deu#ev,ka    #pentP1#Pfingstmontag#Pfingstmontag#east0+50
deu#ev       #pentP2#Pfingstdienst.#2. Pfingstfeiertag#east0+51
deu#ev,ka    #trin0#Trinitatis#Trinitatis: Tag der Dreieinigkeit#east0+56
deu#ev,ka    #trin1#1. So.n.Trin.#1. Sonntag nach Trinitatis#trin+7
deu#   ka    #fronl#Fronleichnam#Fronleichnam#east0+60
deu#   ka    #marasc#Mariä Himmelf.#Mariä Himmelfahrt#fix=08-15
deu#ev,ka    #trin2#2. So.n.Trin.#2. Sonntag nach Trinitatis#trin+14
deu#ev,ka    #trin3#3. So.n.Trin.#3. Sonntag nach Trinitatis#trin+21
deu#ev,ka    #trin4#4. So.n.Trin.#4. Sonntag nach Trinitatis#trin+28
deu#ev,ka    #trin5#5. So.n.Trin.#5. Sonntag nach Trinitatis#trin+35
deu#ev,ka    #trin6#6. So.n.Trin.#6. Sonntag nach Trinitatis#trin+42
deu#ev,ka    #trin7#7. So.n.Trin.#7. Sonntag nach Trinitatis#trin+49
deu#ev,ka    #trin8#8. So.n.Trin.#8. Sonntag nach Trinitatis#trin+56
deu#ev,ka    #trin9#9. So.n.Trin.#9. Sonntag nach Trinitatis#trin+63
deu#ev,ka    #trin10#10. So.n.Trin.#10. Sonntag nach Trinitatis#trin+70
deu#ev,ka    #trin11#11. So.n.Trin.#11. Sonntag nach Trinitatis#trin+77
deu#ev,ka    #trin12#12. So.n.Trin.#12. Sonntag nach Trinitatis#trin+84
deu#ev,ka    #trin13#13. So.n.Trin.#13. Sonntag nach Trinitatis#trin+91
deu#ev,ka    #trin14#14. So.n.Trin.#14. Sonntag nach Trinitatis#trin+98
deu#ev,ka    #trin15#15. So.n.Trin.#15. Sonntag nach Trinitatis#trin+105
deu#ev,ka    #trin16#16. So.n.Trin.#16. Sonntag nach Trinitatis#trin+112
deu#ev,ka    #trin17#17. So.n.Trin.#17. Sonntag nach Trinitatis#trin+119
deu#ev,ka    #trin18#18. So.n.Trin.#18. Sonntag nach Trinitatis#trin+126
deu#ev,ka    #trin19#19. So.n.Trin.#19. Sonntag nach Trinitatis#trin+133
deu#ev,ka    #trin20#20. So.n.Trin.#20. Sonntag nach Trinitatis#trin+140
deu#ev,ka    #trin21#21. So.n.Trin.#21. Sonntag nach Trinitatis#trin+147
deu#ev,ka    #trin22#22. So.n.Trin.#22. Sonntag nach Trinitatis#trin+154
deu#ev,ka    #trin23#23. So.n.Trin.#23. Sonntag nach Trinitatis#trin+161
deu#ev,ka    #trin24#24. So.n.Trin.#24. Sonntag nach Trinitatis#trin+168
deu#ev,ka    #trin25#25. So.n.Trin.#25. Sonntag nach Trinitatis#trin+175
deu#ev,ka    #trin26#26. So.n.Trin.#26. Sonntag nach Trinitatis#trin+182
deu#ev,ka    #trin27#27. So.n.Trin.#27. Sonntag nach Trinitatis#trin+189
deu#   ka    #martin#Martini#Martinstag#fix=11-11
deu#   ka    #nikol#Nikolaus#Nikolaustag#fix=12-06
deu#ev,ka    #trin97#3.letzter So.im Kj.#Drittletzter Sonntag des Kirchenjahres#adv1-21
deu#ev,ka    #trin98#Volkstrauertag#Volkstrauertag: Vorletzter Sonntag des Kirchenjahres#adv1-14
deu#ev       #busbet#Buß- und Bettag#Buß- und Bettag#adv1-11
deu#ev       #trin99#Ewigkeitssonntag#Ewigkeitssonntag: Letzter Sonntag des Kirchenjahres#adv1-7
deu#   ka    #trin99#Totensonntag#Totensonntag: Letzter Sonntag des Kirchenjahres#adv1-7
deu#ev,ka    #erndank#Erntedankfest#Erntedankfest#wrm1.10
deu#ev       #reform#Reformationstag#Reformationstag: 31. Oktober#fix=10-31
deu#ev       #augsb#Augsburger K.#Feiertag der Augsburger Konfession: 26. Juni#fix=06-26
deu#ev       #konfir#Konfirmation#Konfirmation#var
deu#ev       #kirchw#Kirchweihe#Kirchweihe#var
deu#ev       #keinht#f.d.Einheit d.K.#Bittgottesdienst um die Einheit der Kirche#var
deu#ev       #evangm#f.d.Ausbr. d.Ev.#Bittgottesdienst um die Ausbreitung des Evangeliums#var
deu#ev       #friede#f.d.Frieden#Bittgottesdienst um Frieden#var
deu#ev,ka    #steph#Stephanus#26. Dezember, Tag des Erzmärtyrers Stephanus#fix=12-26
deu#ev,ka    #kinder#Unsch. Kinder#28. Dezember, Tag der unschuldigen Kinder#fix=12-28
deu#ev       #marpur#Lichtmess#2. Februar, Tag der Darstellung des Herrn (Lichtmess)#fix=02-02
deu#   ka    #marpur#Lichtmess#Mariä Reinigung#fix=02-02
deu#ev,ka    #marann#Mariä Ankünd.#25. März, Tag der Ankündigung der Geburt des Herrn#fix=03-25
deu#   ka    #marasc#Mariä Himmelf.#15. August, Mariä Himmelfahrt#fix=08-15
deu#ev,ka    #joabapt#Johannis#24. Juni, Tag der Geburt Johannes des Täufers#fix=06-24
deu#ev,ka    #pepaul#Peter+Paul#29. Juni, Tag der Apostel Petrus und Paulus#fix=06-29
deu#ev,ka    #marvis#Mariä Heims.#2. Juli, Tag der Heimsuchung Mariä#fix=07-02
deu#ev,ka    #michael#Michaelis#29. September, Tag des Erzengels Michael und aller Engel#fix=09-29
deu#ev,ka    #hallow#Allerheiligen#1. November, Gedenktag der Heiligen#fix=11-01
deu#   ka    #hallos#Allerseelen#Allerseelen#fix=11-02
deu#      pol#wverein#T.d.Wiedervereinig.#Tag der deutschen Wiedervereinigung#fix=10-03
deu#      pol#may1#Maifeiertag#Tag der Arbeit#fix=05-01
deu#      pol#nyear#Neujahr#Neujahrstag#fix=01-01
