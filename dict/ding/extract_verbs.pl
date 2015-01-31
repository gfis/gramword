#!/usr/bin/perl

# get verbs from de-en dictionary for ding
# @(#) $Id$
# 2013-02-06: copied from pt/natlan/morph/ding/get_vb.pl
# 2004-09-16, Georg Fischer <punctum@punctum.com>
use strict;
use locale;

while (<>) {
	next if ! m[\{v];
	next if m{\A\s*\[\-#]}; # starting with # or -
	s[\r?\n][]; # chompr
	s[\:\:.*][]; # remove english part
	s[\|.*][]; # remove anything behind first bar
	s/\[[^\]]+\]//g; # remove topics
	s/\([^\)]+\)//g; # remove optional prepositions
	s[  +][ ]g; # collapse spaces
	s/^\s+//; # leading whitespace
	s/\s?\;\s*/\;/g;
	next if ! m[\{v];
	my @phrases = split(/\;/, $_);
	foreach my $phrase (@phrases) {
		my @words = split(/\s+/, $phrase);
		my $word = $words[-1];
		$word =~ s/\{[^\}]+\}//; # remove {...}
		$word =~ s/\s+\Z//; # trailing whitespace
		$word =~ s/\A\s+//; # leading whitespace
		if (($word !~ m{[\<\>\.\"]}) and length($word) > 0 and ($word =~ m{(en|eln|ern)\Z})) {
			print "$word\n";
		}
	} # foreach
} # while <>
__DATA__
Abschiedsrede {f} | Abschiedsreden {pl} :: farewell speech | farewell speeches
Abschiedsrede {f} | Abschiedsreden {pl} :: valedictory | valedictories
Anrede {f}; Gruß {m}; Grußformel {f}; Grußzeile {f} | Anreden {pl}; Grüße {pl}; Grußformeln {pl}; Grußzeilen {pl} :: salutation | salutations
Antrittsrede {f} | Antrittsreden {pl} :: inaugural; inaugural address | inaugural addresses
Aufsehen erregen; von sich reden machen :: to make a noise in the world
Ausrede {f}; Ausflucht {f}; Entschuldigung {f}; Vorwand {m} | Ausreden {pl}; Ausflüchte {f}; Entschuldigungen {pl} | Ausflüchte machen | faule Ausrede | eine Ausrede erfinden | schnell Entschuldigungen bei der Hand haben :: excuse | excuses | to make excuses | lame excuse; blind excuse | to think up an excuse | to be glib in finding excuses
Bauchreden {n} :: ventriloquism
Beglaubigungsschreiben {n} :: credentials
Berechtigungsnachweis {m} | Berechtigungsnachweise {pl} :: credential | credentials
hinterm Berg halten; nicht zur Sache kommen; um den heißen Brei herumreden [übtr.] :: to pussyfoot around
Bescheinigung {f}; Zeugnis {n} :: credentials
Bestandteil {m}; Ingredienz {f}; Ingredens {n} | Bestandteile {pl}; Ingredienzen {pl}; Ingredienzien {pl} :: ingredient | ingredients
Bewerbungsunterlagen {pl} :: application papers; application credentials
Brei {m} [cook.] | um den heißen Brei herumreden [ugs.] :: mash | to beat about the bush [fig.]
ständiges Dreinreden {n} [pej.] :: backseat driving [fig.]
Empfehlungsschreiben {n} :: credentials
Eröffnungsrede {f} | Eröffnungsreden {pl} | die Eröffnungsrede halten :: opening speech | opening speeches | to make the opening speech; to give the opening speech
Flüsterton {m} | im gedämpften Flüsterton | im Flüsterton reden | sich im Flüsterton unterhalten :: whisper | in hushed whispers | to talk in a whisper | to talk in whispers
die Gabe, in fremden Zungen zu reden (biblisch) :: the gift of tongues
Gedenkrede {f} | Gedenkreden {pl} :: commemorative address | commemorative addresses
Geschwätz {n}; dummes Zeug | dummes Zeug reden :: twaddle | to talk twaddle
Glaube {m} :: credence
Grabrede {f}; Lobpreisung eines Verstorbenen | Grabreden {pl} :: eulogy [Am.] | eulogies
Grundsatzrede {f} | Grundsatzreden {pl} :: keynote address | keynote addresses
Hetzrede {f}; Schmährede {f} | Hetzreden {pl}; Schmähreden {pl} :: diatribe | diatribes
Irredentismus {m} [pol.] :: irredentism
Irredenta {m} [pol.] :: irredenta
Irredentist {m} [pol.] | Irredentisten {pl} :: irredentist | irredentists
Kauderwelsch reden; Kauderwelsch sprechen | Kauderwelsch redend | Kauderwelsch gesprochen | er/sie redet Kauderwelsch :: to gibber | gibbering | gibbered | he/she gibbers
Kommunikation {f} | Kommunikationen {pl} | Miteinander reden ist das A und O / das Um und Auf [Ös.] in einer guten Ehe. :: communication | communications | Communication is the lifeblood of a good marriage.
sich um Kopf und Kragen reden [übtr.] :: to risk one's neck with careless talk
Kredenz {f} :: credence; credenza
Legitimation {f}; Ausweis {m}; Bescheinigung {f}; Berechtigungsnachweis {m} :: credentials
Leichenrede {f} | Leichenreden {pl} :: funeral sermon; funeral oration; funeral address | funeral sermons; funeral orations; funeral addresses
eine Rede halten; reden {vi} | eine Rede haltend; redend | eine Rede gehalten; geredet | hält eine Rede; redet | hielt eine Rede; redete :: to discourse | discoursing | discoursed | discourses | discoursed
Referenzierung {f} [fin.] :: credentiality
Rendezvous {n}; Verabredung {f}; Stelldichein {n}; Date {n} | sich verabreden :: rendezvous; date | to go on a date
Seele {f} | Seelen {pl} | mit ganzer Seele | jdm. aus der Seele sprechen | sich etw. von der Seele reden | sich aus voller Seele für etw. einsetzen | Du sprichst mir aus der Seele! :: soul | souls | with all one's soul | to express exactly what sb. feels | to get sth. off one's chest; to unburden oneself of sth. | to put one's heart and soul into sth. | My thoughts exactly!
Spottrede {f} | Spottreden {pl} :: roast [Am.] [coll.] | roasts
aus dem Stegreif (unvorbereitet) reden (darbieten; spielen); improvisieren :: to extemporize [eAm.]; to extemporise [Br.]
Thronrede {f} | Thronreden {pl} :: speech from the throne | speeches from the throne
Tischrede {f}; Toast {m}; Trinkspruch {m} | Tischreden {pl}; Toasts {pl}; Trinksprüche {pl} | einen Toast auf jdn. ausbringen | einen Toast erwidern :: toast; after-dinner speech | toasts; after-dinner speeches | to propose a toast to sb. | to respond to a toast
Trauerrede {f} | Trauerreden {pl} :: funeral speech | funeral speeches
Unsinn {m}; Blödsinn {m}; Nonsens {m}; Stuss {m} [ugs.]; Flausen {pl}; Fisimatenten {pl} [ugs.] | glatter Unsinn; blanker Unsinn | Unsinn reden | Unsinn! | So ein Unsinn!; Was für ein Unsinn! | Hör auf mit dem Unsinn! | Lass den Unsinn! | etw. als Unsinn bezeichnen / abtun / zurückweisen :: nonsense; rubbish | sheer nonsense | to talk nonsense / rubbish / trash [Am.] | Rubbish!; Nonsense! | What nonsense!; What rubbish! | Stop the nonsense!; Cut the crap! [Am.] [slang] | Stop fooling/messing around/about! | to rubbish sth. [coll.]
Unsinn {m}; Quatsch {m}; Blödsinn {m} | Unsinn reden :: rot [coll.] | to talk rot
Wahlrede {f} | Wahlreden {pl} :: election speech | election speeches
(in der Provinz) eine Wahlrede halten | hielt Wahlreden :: to barnstorm | barnstormed
Wind {m} | Winde {pl} | mit dem Wind; vor dem Wind | gleichmäßige Winde | starker Wind | günstiger Wind | Wind bekommen von | Bedenken in den Wind schlagen [übtr.] | Wind wird rückdrehend | in den Wind reden [übtr.] | in den Wind schlagen [übtr.] | am Wind [naut.] | hart am Wind [naut.] | gegen den Wind [aviat.] :: wind | winds | downwind; before the wind | steady winds | strong wind | fair wind; fairwind | to get wind of | to throw caution to the winds [fig.] | wind will back | to talk in vain | to set at nought | by the wind; close reach | close hauled | into the wind
Wort {n} | Worte {pl}; Wörter {pl} | freundliche Worte | tröstende Worte | abgeleitetes Wort | eins von mehreren Wörtern | ein offenes Wort mit jdm. reden | sich zu Wort melden | das Wort führen (in einer Diskussion) | das Wort weiter geben an | sich zu Wort melden; das Wort ergreifen | das letzte Wort haben | in einfachen Worten | etw. in Worte fassen | unanständiges Wort | vager Begriff; unscharfer Begriff | klare Worte; deutliche Worte | doppelsinnige Worte; zweideutige Worte; unscharfe Ausdrucksweise | sein Wort brechen | sein Wort halten | mit einem Wort | mit anderen Worten; anders ausgedrückt; anders gesagt | mit eindringlichen Worten | im wahrsten Sinn des Wortes | in der vollen Bedeutung des Wortes | im herkömmlichen Sinne des Wortes | große Worte machen | zusammengesetztes Wort | mit einem Wort :: word | words | bland words | words of consolation | derivative | one of many words | to have a frank talk with sb. | to catch the speaker's eye | to be the main speaker (in a discussion) | to hand over to sb.; to pass sb. over to; to give the floor to | to start speaking; to take the floor (in a meeting) | to have the final say | in simple terms | to put sth. into words | dirty word | weasel word | plain speaking | weasel words | to break one's word | to keep one's word | in a word | in other words | in vivid words; with insistence; insistently | in the full sense of the word | in every sense of the word | in the usual sense of the word | to use big words; to use grand words | compound word; compound | in sum
Zunge {f} [anat.] | Zungen {pl} | Zünglein {n} | eine scharfe Zunge haben [übtr.] | sich auf die Zunge beißen | (jdm.) die Zunge herausstecken | mit der Zunge schnalzen | lose (scharfe) Zunge {f} | mit der Zunge anstoßen | auf der Zunge zergehen | mit gespaltener Zunge | mit gespaltener Zunge reden | Böse Zungen behaupten, dass .... :: tongue | tongues | little tongue | to have a sharp tongue | to bite one's tongue | to put one's tongue out; to stick one's tongue out (at sb.) | to smack one's tongue | loose (sharp) tongue | to (have a) lisp | to melt in one's mouth | with forked tongue | to talk falsely | Malicious gossip has it that ...
Zureden {n} | erst nach langem Zureden :: suasion | only after a great deal of coaxing
jdn. abbringen, etw. zu tun; jdn. ausreden, etw. zu tun :: to put sb. off doing sth.
absolut nichts; absolut null; kein bisschen | Ich habe versucht, es ihm auszureden, aber das hat absolut nichts/null genützt. :: any (+ verb in a negative sentence) [Am.] [coll.] | I tried talking him out of it, but that didn't help any.
(Speisen) anbieten; darbieten; kredenzen [obs.] {vt} | anbietend; darbietend; kredenzend | angeboten; dargeboten; kredenzt :: to serve | serving | served
jdn. anreden (als) | anredend | angeredet :: to address sb. (as) | addressing | addressed
jdn. aufmuntern; jdn. aufheitern; jdm. gut zureden :: to jolly (along) sb. [coll.]
jdn. ausreden lassen; jdn. zu Ende erzählen lassen | Danke, dass du mich ausreden lassen hast. :: to hear out <> sb. | Thanks for hearing me out.
belatschern {vt} [ugs.] | jdn. belatschern, dass er/sie etw. macht; jdn. zu etw. überreden | sie hat mich belatschert ::  | to talk sb. into doing sth. | she talked me into it
beschwatzen; überreden {vt} | beschwatzend; überredend | beschwatzt; überredet | jdn. überreden, etw. zu tun :: to cajole | cajoling | cajoled | to cajole sb into doing sth.
diskutieren; besprechen; bereden; erörtern; debattieren (mit) | diskutierend; besprechend; beredend; erörternd; debattierend | diskutiert; besprochen; beredet; erörtert; debattiert | diskutiert; bespricht; beredet; erörtert; debattiert | diskutierte; besprach; beredete; erörterte; debattierte | wie besprochen; wie diskutiert | die Lage besprechen | nicht besprochen; unerörtert :: to discuss (with) | discussing | discussed | discusses | discussed | as discussed | to discuss the situation | undiscussed
dozieren; sich dogmatisch auslassen; hochtrabend reden | dozierend; sich dogmatisch auslassend; hochtrabend redend | doziert; sich dogmatisch ausgelassen; hochtrabend geredet :: to pontificate | pontificating | pontificated
durcheinander {adv} | durcheinander reden :: in confusion | to speak all at once
jdm. etw. einreden :: to talk sb. into believing sth.
sich etw. einreden :: to talk oneself into believing sth.
eintönig reden; herleiern; brummen; dröhnen :: to drone
sich in etw. ergehen {vr} | sich in Lobreden ergehen | Er erging sich in wüsten Beschimpfungen. :: to indulge in sth. | to indulge in lavish/profuse praise | He let out a stream of abuse.
erzählen; berichten; sagen {vt} | erzählend; berichtend; sagend | erzählt; berichtet; gesagt | er/sie erzählt; er/sie berichtet; er/sie sagt | ich/er/sie erzählte; ich/er/sie berichtete; ich/er/sie sagte | er/sie hat/hatte erzählt; er/sie hat/hatte berichtet; er/sie hat/hatte gesagt | jdm. von etw. erzählen; jdm. von etw. berichten | nicht erzählt; nicht berichtet | Sag mal, ... | es wird erzählt | Ich muss Ihnen davon erzählen, um es mir von der Seele zu reden. | Was habe ich gesagt?; Hab' ich's nicht gesagt? :: to tell {told; told} | telling | told | he/she tells | I/he/she told | he/she has/had told | to tell sb. about sth. | untold | Tell me ... | it is said; legend has it | I must tell you about it to get it off my chest. | What did I tell you?
fachsimpeln; von der Arbeit reden :: to talk shop
fusselig; fusslig {adj} | sich den Mund fusselig reden; sich den Mund fransig reden [übtr.] [ugs.] :: fluffy | to talk till one is blue in the face [fig.]
geschwollen reden {vi} | geschwollen redend | geschwollen geredet | redet geschwollen | redete geschwollen :: to rant | ranting | ranted | rants | ranted
sich herausreden {vr} | sich herausredend | sich herausgeredet :: to make excuses | making excuses | made excuses
herumreden {vi} | herumredend | herumgeredet | redet herum | redete herum :: to quibble | quibbling | quibbled | quibbles | quibbled
auf etw. herum reiten; immer wieder von etw. reden :: to harp on about sth.
heucheln {vi}; scheinheilig reden | heuchelnd; scheinheilig redend | geheuchelt; scheinheilig geredet :: to cant | canting | canted
irreredend {adv} :: deliriously
langatmig reden; wortreich darlegen :: to spiel
lebhaft anreden {vt} :: to apostrophize [eAm.]; to apostrophise [Br.]
mitreden {vt} | mitredend | mitgeredet :: to join in; to take part | joining ind; taking part | joined it; taken part
natürlich; selbstverständlich; gewiss; selbstredend {adv} | ganz selbstverständlich | Natürlich nicht! :: of course | as a matter of course | Of course not!
naturgemäß; verständlicherweise; selbstredend {adv} :: naturally
oberflächlich reden {vi} | oberflächlich redend | oberflächlich geredet | redet oberflächlich | redete oberflächlich :: to smatter | smattering | smattered | smatters | smattered
offen reden; sachlich reden (mit) :: to talk turkey (with)
reden {vi} (zu); sprechen {vi} (mit); sich unterhalten {vr} (mit) | redend; sprechend; sich unterhaltend | geredet; gesprochen; sich unterhalten | redet; spricht; unterhält sich | redete; sprach; unterhielt sich | sich miteinander unterhalten | über Geschäfte reden | ins Blaue hinein reden | dummes Zeug reden | große Töne reden; große Töne spucken [ugs.] | Red weiter!; Reden Sie weiter! | drauflos reden | großspurig reden | sich mit jdm. unterhalten | mit Engelszungen sprechen [übtr.] | Ich kann mit ihr reden, wenn du willst. | Ich würde mich gern mal mit dir unterhalten. | Ich will den Geschäftsführer sprechen, aber schnell! :: to talk (to) | talking | talked | talks | talked | to talk to each other | to talk business | to talk at large | to talk through one's hat | to talk big | Keep talking! | to talk wild; to talk away | to talk large | to have a talk with so. | to talk with the tongues of angels; to speak with a sweet tongue [fig.] | I can talk to her if you want. | I should like to have a little talk with you. | Let me talk to the manager and make it snappy!
von etw. anderem reden :: to change the subject
mit sich reden lassen :: to be reasonable
jdm. nach dem Mund reden :: to tell sb. what they want to hear
schimpfen; beschimpfen; schlecht reden {vi} | schimpfend; beschimpfend; schlecht redend | geschimpft; beschimpft; schlecht geredet | schimpft; beschimpft; redet schlecht | schimpfte; beschimpfte; redete schlecht :: to badmouth | badmouthing | badmouthed | badmouths | badmouthed
schmeicheln {vi} | schmeichelnd | geschmeichelt | schmeichelt | schmeichelte | jdm. nach dem Munde reden | jdm. etw. abbetteln :: to cajole | cajoling | cajoled | cajoles | cajoled | to cajole sb.; to echo sb. | to cajole sth. out of so.
schmeicheln; gut zureden {vi} | schmeichelnd; gut zuredend | geschmeichelt; gut zugeredet | schmeichelt | schmeichelte :: to coax | coaxing | coaxed | coaxes | coaxed
schönreden {vt} :: to be a smooth talker
schwätzen; schwatzen; dummes Zeug reden | schwätzend; schwatzend; dummes Zeug redend | geschwätzt; geschwatzt; dummes Zeug geredet | schwätzt; schwatzt | schwätzte; schwatzte :: to twaddle | twaddling | twaddled | twaddles | twaddled
jdn. siezen; jdn. mit Sie anreden :: to call sb. "Sie"; to use the polite form of address to sb.
sprechen; reden {vi} (über; von) | sprechend; redend | gesprochen; geredet | du sprichst; du redest | er/sie spricht; er/sie redet | ich/er/sie sprach; ich/er/sie redete | er/sie hat/hatte gesprochen; er/sie hat/hatte geredet | ich/er/sie spräche; ich/er/sie redete | sprich!; rede! | Deutsch sprechen | gebrochen Deutsch sprechen | Sprechen Sie Deutsch? | Mit wem spreche ich? | Ich spreche leider kein Englisch/nicht englisch. | lauter sprechen | sich klar und deutlich ausdrücken | frei sprechen | von jdm. schlecht reden | frisch von der Leber weg reden | also sprach ... :: to speak {spoke; spoken} (about) | speaking | spoken | you speak | he/she speaks | I/he/she spoke | he/she has/had spoken | I/he/she would speak | speak! | to speak German | to speak broken German | Do you speak German? | Who am I speaking to? | I'm sorry, I don't speak English. | to speak up | to speak plain English | to speak without notes | to speak evil of sb. | to speak freely; to let fly | thus spoke ...
streiten {vi}; bereden; vorbringen {vt} :: to argue
über {prp; +Akkusativ} | über die Ausstellung reden | ein Artikel über Online-Wörterbücher :: about | to talk about the exhibition | an article about/on online dictionaries
überreden; überzeugen {vt} (von; zu) | überredend; überzeugend | überredet; überzeugt | überredet; überzeugt | überredete; überzeugte :: to persuade (of; to) | persuading | persuaded | persuades | persuaded
überreden {vt} | überredend | überredet | jdm. etws ausreden :: to argue | arguing | argued | to argue so. out of sth.
überredend {adv} :: suasively
überzeugend; überredend {adj} :: suasive
sich uneinig sein; sich missverstehen {vr} | aneinander vorbeireden :: to be at cross purposes; to be divided (on sth.) | to talk at cross-purposes
unter jds. Niveau/Würde/Stand sein | Das ist unter seiner Würde. | Er findet solche Arbeiten unter seinem Niveau. | Ihre Mutter fand, dass sie nicht standesgemäß geheiratet hatte. | Er verdient keinerlei Beachtung. | Sie tut so, als wäre es schon unter ihrer Würde, mit uns zu reden. :: to be beneath sb. | That's beneath him. | He considers such jobs beneath him. | Her mother felt she had married beneath her. | He is beneath notice. | She acts as if even speaking to us is beneath her.
unterbrechen; stören {vt} | unterbrechend; störend | unterbrochen; gestört | unterbricht; stört | unterbrach; störte | jdm. dreinreden; jdm. ins Wort fallen; jdm. in die Rede fallen | Unterbrechen Sie mich nicht! | Musst du ständig dreinreden / dazwischenquatschen [ugs.]? :: to interrupt | interrupting | interrupted | interrupts | interrupted | to interrupt sb. | Don't interrupt me! | Do you have to keep interrupting?
etw. verabreden; abmachen; ausmachen {vt} | verabredend; abmachend; ausmachend | verabredet; abgemacht; ausgemacht | verabredet; macht ab; macht aus | verabredete; machte ab; machte aus | zu einer Zeit verabreden :: to agree on sth.; to arrange sth. | agreeing on; arranging | agreed on; arranged | agrees | agreed | to agree on a time
(Ort; Zeit) verabreden {vt} | verabredend | verabredet | verabredet | verabredete :: to fix | fixing | fixed | fixes | fixed
sich mit jdm. verabreden {vr} (geschäftlich) :: to make an appointment with sb.
sich mit jdm. verabreden {vr} :: to arrange to meet sb.; to go out with sb.; to make a date with sb.
verhandeln {vt}; sich bereden | verhandelnd; sich beredend | verhandelt; sich beredet :: to parley | parleying | parleyed
herumreden (um etw.); ausweichen (+Dat); sich herumdrücken (um etw.); sich nicht festlegen | herumredend; ausweichend; sich herumdrückend; sich nicht festlegend | herumgeredet; ausgewichen; sich herumgedrückt; sich nicht festgelegt | um ein Thema herumreden | He continues to hedge on whether ... | Red nicht herum und sag mir, was du wirklich denkst! | 'Das hängt von den Umständen ab', sagte sie ausweichend. | Sie relativierte ihre frühere Aussage/Zusage. :: to hedge (around); to hedge sth./on sth./around sth. | hedging | hedged | to hedge around a subject | Er lässt weiterhin offen, ob ... | Stop hedging and tell me what you really think! | 'That depends on the circumstances' she hedged. | She hedged her earlier statement/promise.
mit jdm. argumentieren; vernünftig reden; jdm. zureden {vi} | argumentierend; vernünftig redend; zuredend | argumentiert; vernünftig geredet; zugeredet | Sie ist vernünftigen Argumenten zugänglich. | Die Polizei redete den Luftpiraten zu, sie sollten zumindest die Kinder freilassen. | Er ist fest entschlossen hinzugehen und keinem Argument zugänglich. | Mit einem Betrunkenen kann man nicht vernünftig reden. :: to reason with sb. | reasoning | reasoned | She is willing to be reasoned with. | The police reasoned with the hijackers to at least let the children go free. | He is absolutely determined to go and there's just no reasoning with him. | There is no reasoning with a drunk.
aneinander vorbei reden; vorbeireden {vi} | aneinander vorbei redend; vorbeiredend | aneinander vorbei geredet; vorbeigeredet | vorbeigeredet :: to talk at cross purposes | talking at cross purposes | talked at cross purposes | talked at cross purposes
vorreden {vt} | vorredend | vorgeredet | jdm. etw. vorreden :: to tell a tale; to invent an explanation | telling a tale; inventing an explanation | told a tale; invented an explanation | to tell sb. a tale
wahnsinnig; irreredend {adj} :: delirious
weinerlich reden {vi} | weinerlich redend | weinerlich geredet :: to bleat | bleating | bleated
weiterreden {vi} | weiterredend | weitergeredet | er/sie redet weiter | ich/er/sie redete weiter | er/sie hat/hatte weitergeredet :: to go on talking; to carry on talking; to speak on; to run on | going on talking; carrying on talking; speaking on; running on | gone on talking; carried on talking; spoken on; run on | he/she goes on talking; he/she carries on talking; he/she speaks up; he/she runs on | I/he/she went on talking; I/he/she carried on talking; I/he/she spoke up; I/he/she ran on | he/she has/had gone on talking; he/she has/had carried on talking; he/she has/had spoken on; he/she has/had run on
willkürlich; blindlings; wahllos; querbeet {adv}; aufs Geratewohl | irgendetwas daherreden; einfach drauflosreden | auf Gutglück wählen :: at random | to talk at random | to choose at random
zureden :: to blandish
zweideutig reden {vi} | zweideutig redend | zweideutig geredet | redet zweideutig | redete zweideutig :: to equivocate | equivocating | equivocated | equivocates | equivocated
Da kann ich nicht mitreden. :: I don't know anything about that.
Darüber lässt sich reden. :: That's a matter of argument.
Das lasse ich mir nicht einreden! :: I won't be talked into it!
Du hast gut reden. :: You can talk.
Er lässt mit sich reden. :: He's open to reason.
Er ließ sich leicht überreden. :: He was easily persuaded.
Er lässt mit sich reden. :: He will listen to reason.
Hör auf zu reden! :: Stop talking!
Kommen Sie mir nicht mit Ausreden! :: None of your excuses!
Lassen Sie mich ausreden!; Lass mich ausreden! :: Hear me out!
Man soll nicht einmal reden dürfen? :: Aren't we even allowed to talk?
Sie haben gut reden. :: Talk is cheap.
Worüber reden sie? :: What are they talking about?
etw. zerreden {vt} | etw. zerreden {vt} | etw. zerreden {vt} :: to discuss sth. to death | to discuss sth. ad nauseam | to overdiscuss sth.
sich etw. zurechtlegen {vt} (Gegenstände) | sich etw. zurechtlegen {vt} (Ausreden, etc.) | jmd. etw. zurechtlegen {vt} (Gegenstände) :: to put sth. out ready | to have sth. ready | to put sth. out for so.
bis man schwarz wird [ugs.] | Da kannst du lange reden! | bis zum Gehtnichtmehr [ugs.] | bis in alle Ewigkeit [ugs.] :: until/till the cows come home [coll.] | You can talk till the cows come home! | until/till the cows come home [coll.] | until/till the cows come home [coll.]
Lass uns nochmal darüber reden! :: LUTA : Let us talk again!
Erst denken, dann reden! :: PMIGBOM : Put mind in gear, before opening mouth!
