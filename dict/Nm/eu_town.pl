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
# all German towns
# Die '''Liste der Städte in Deutschland''' enthält eine 
# vollständige Auflistung aller 2074 [[Stadt|Städte]] in [[Deutschland]] 
# in alphabetischer Reihenfolge (Stand: 29. März 2006).
# from http://de.wikipedia.org/wiki/Liste_der_St%C3%A4dte_in_Deutschland
# take single words only
# @(#) $Id: eu_town.pl 36 2008-09-08 06:05:06Z gfis $
# 2006-08-13, Georg Fischer

use strict;
    binmode(STDOUT, ":utf8");

    while (<DATA>) {
        next if ! m/\:\[\[/;
        m/\[\[([^\(\|\]]+)/;
        my $city = $1;
        $city =~ s/ [abcdefghijklmnopqrstuvwäöü].*//; # remove "am ...", "im ..." etc.
        $city =~ s/ $//;
        $city =~ s/^Bad //;
        $city =~ s/^St\. //;
        $city =~ s/^Sankt //;
        foreach my $loc (split (/[\- ]/, $city)) {
            print "$loc =NmGeogCity.De\n";
        }
    }
__DATA__
| align="right" | 1 &nbsp; || [[London]] || align="right" | 7.421.209 || align="right" |1.579|| align="right" | 1. Jan. 2005 || [[Vereinigtes Königreich]]
|-
| align="right" | 2 &nbsp; || [[Berlin]] || align="right" | 3.395.200 || align="right" | 892|| align="right" | 1. Aug. 2006 || [[Deutschland]]
|-
| align="right" | 3 &nbsp; || [[Madrid]] || align="right" | 3.155.359 || align="right" | 607|| align="right" | 1. Jan. 2005 || [[Spanien]]
|-
| align="right" | 4 &nbsp; || [[Rom]] || align="right" | 2.547.932 || align="right" | 1.285|| align="right" | 31. Nov. 2005|| [[Italien]]
|-
| align="right" | 5 &nbsp; || [[Paris]] || align="right" | 2.138.551 || align="right" | 105 || align="right" | 1. Jan. 2005|| [[Frankreich]]
|-
| align="right" | 6 &nbsp; || [[Hamburg]] || align="right" | 1.744.215   || align="right" | 755 || align="right" | Nov. 2005|| [[Deutschland]]
|-
| align="right" | 7 &nbsp; || [[Budapest]] || align="right" | 1.697.343 || align="right" | 525|| align="right" | 1. Jan. 2005|| [[Ungarn]]
|-
| align="right" | 8 &nbsp; || [[Warschau]] || align="right" | 1.694.825 || align="right" | 517|| align="right" | 31. Dez. 2005|| [[Polen]]
|-
| align="right" | 9 &nbsp; || [[Wien]] || align="right" |  1.651.365 || align="right" | 414|| align="right" | 1. Jan. 2006|| [[Österreich]]
|-
| align="right" | 10 &nbsp; || [[Barcelona]] || align="right" | 1.612.237 || align="right" | 100|| align="right" | 30. Juni 2005 || [[Spanien]]
|-
| align="right" | 11 &nbsp; || [[Mailand]] || align="right" | 1.308.311 || align="right" | 160|| align="right" | 31. Dez. 2005 || [[Italien]]
|-
| align="right" | 12 &nbsp; || [[München]] || align="right" | 1.305.522 || align="right" | 310|| align="right" | 31. Mai 2006|| [[Deutschland]]
|-
| align="right" | 13 &nbsp; || [[Prag]] || align="right" | 1.181.610 || align="right" | 496|| align="right" | 31. Dez. 2005|| [[Tschechien]]
|-
| align="right" | 14 &nbsp; || [[Neapel]] || align="right" | 1.000.470 || align="right" | -|| align="right" | 31. Mai 2005|| [[Italien]]
|-
| align="right" | 15 &nbsp; || [[Birmingham]] || align="right" | 992.100 || align="right" | -|| align="right" | 31. Nov. 2005|| [[Vereinigtes Königreich]]
|-
| align="right" | 16 &nbsp; || [[Köln]] || align="right" | 983.347 || align="right" | 405|| align="right" | 30. Dez. 2005|| [[Deutschland]]
|-
| align="right" | 17 &nbsp; || [[Turin]] || align="right" | 900.142 || align="right" | -|| align="right" | 31. Nov. 2005|| [[Italien]]
|-
| align="right" | 18 &nbsp; || [[Marseille]] || align="right" | 808.700 || align="right" | -|| align="right" | 2004 (prov.)|| [[Frankreich]]
|-
| align="right" | 19 &nbsp; || [[Valencia (Spanien)|Valencia]] || align="right" | 796.549 || align="right" | -|| align="right" | 1. Jan. 2005 || [[Spanien]]
|-
| align="right" | 20 &nbsp; || [[Lódz]] || align="right" | 774.004 || align="right" | -|| align="right" | 31. Dez. 2004|| [[Polen]]
|-
| align="right" | 21 &nbsp; || [[Stockholm]] || align="right" | 766.747 || align="right" | -|| align="right" | 30. Juni 2005|| [[Schweden]]
|-
| align="right" | 22 &nbsp; || [[Krakau]] || align="right" | 757.430 || align="right" | -||align="right" | 1. Jan. 2005||  [[Polen]]
|-
| align="right" | 23 &nbsp; || [[Amsterdam]] || align="right" | 742.011 || align="right" | -|| align="right" | 1. Dez. 2005|| [[Niederlande]]
|-
| align="right" | 24 &nbsp; || [[Riga]] || align="right" | 731.672 || align="right" | -|| align="right" | 1. Jan. 2005|| [[Lettland]]
|-
| align="right" | 25 &nbsp; || [[Athen]] || align="right" | 729.137 || align="right" | -|| align="right" | 1. Jan. 2005 || [[Griechenland]]
|-
| align="right" | 26 &nbsp; || [[Sevilla]] || align="right" | 704.154 || align="right" | -|| align="right" | 1. Jan. 2005 || [[Spanien]]
|-
| align="right" | 27 &nbsp; || [[Palermo]] || align="right" | 674.647 || align="right" | 158|| align="right" | 2005|| [[Italien]]
|-
| align="right" | 28 &nbsp; || [[Frankfurt am Main]] || align="right" | 660.087 || align="right" | 248|| align="right" | 30. Sept. 2005|| [[Deutschland]]
|-
| align="right" | 29 &nbsp; || [[Saragossa]] || align="right" | 647.373 || align="right" | -|| align="right" | 1. Jan. 2005|| [[Spanien]]
|-
| align="right" | 30 &nbsp; || [[Breslau]] || align="right" | 636.268 || align="right" | -|| align="right" | 1. Jan. 2005|| [[Polen]]
|-
| align="right" | 31 &nbsp; || [[Genua]] || align="right" | 611.476 || align="right" | -|| align="right" | 30. Apr. 2005 || [[Italien]]
|-
| align="right" | 32 &nbsp; || [[Stuttgart]] || align="right" | 591.572 || align="right" | -|| align="right" | 31. Jan. 2006 || [[Deutschland]]
|-
| align="right" | 33 &nbsp; || [[Rotterdam]] || align="right" | 589.156 || align="right" | -|| align="right" | 1. Dez. 2005|| [[Niederlande]]
|-
| align="right" | 34 &nbsp; || [[Dortmund]] || align="right" | 587.830 || align="right" | -|| align="right" | 1. Aug. 2005 || [[Deutschland]]
|-
| align="right" | 35 &nbsp; || [[Essen]] || align="right" | 584.295 || align="right" | -|| align="right" | 1. Jan. 2006|| [[Deutschland]]
|-
| align="right" | 36 &nbsp; || [[Glasgow]] || align="right" | 577.670 || align="right" | -|| align="right" | 30. Juni 2004 || [[Vereinigtes Königreich]]
|-
| align="right" | 37 &nbsp; || [[Düsseldorf]] || align="right" | 577.886 || align="right" | 217|| align="right" | 31. Dez. 2005|| [[Deutschland]]
|-
| align="right" | 38 &nbsp; || [[Posen]] || align="right" | 570.778 || align="right" | -|| align="right" | 1. Jan. 2005|| [[Polen]]
|-
| align="right" | 39 &nbsp; || [[Helsinki]] || align="right" | 559.330 || align="right" | -|| align="right" | 31. Dez. 2004|| [[Finnland]]
|-
| align="right" | 40 &nbsp; || [[Málaga]] || align="right" | 558.287 || align="right" | -|| align="right" | 1. Jan. 2005|| [[Spanien]]
|-
| align="right" | 41 &nbsp; || [[Bremen]] || align="right" | 547.193 || align="right" | 325|| align="right" | 1. Dez. 2005|| [[Deutschland]]
|-
| align="right" | 42 &nbsp; || [[Wilna]] || align="right" | 541.600 || align="right" | -|| align="right" | 2003|| [[Litauen]]
|-
| align="right" | 43 &nbsp; || [[Lissabon]] || align="right" | 517.802 || align="right" | -|| align="right" | 2005|| [[Portugal]]
|-
| align="right" | 44 &nbsp; || [[Hannover]] || align="right" | 516.227 || align="right" | 204|| align="right" | 30. Okt. 2005|| [[Deutschland]]
|-
| align="right" | 45 &nbsp; || [[Leipzig]] || align="right" | 502.053 || align="right" | 298|| align="right" | 30. Nov. 2005|| [[Deutschland]]
|-
| align="right" | 46 &nbsp; || [[Kopenhagen]] || align="right" | 501.158 || align="right" | -|| align="right" | 2006|| [[Dänemark]]
|-
| align="right" | 47 &nbsp; || [[Duisburg]] || align="right" |  500.914 || align="right" | 233|| align="right" | 31. Dez. 2005 || [[Deutschland]]
|}
| align="right" | 1. || [[Tokio]] || align="right" | 36.769.213 || [[Japan]] 
|-
| align="right" | 2. || [[New York City|New York]] || align="right" | 22.531.069 || [[Vereinigte Staaten|USA]] 
|-
| align="right" | 3. || [[Mexiko-Stadt]] || align="right" | 22.414.319 || [[Mexiko]] 
|-
| align="right" | 4. || [[Seoul]] || align="right" | 22.173.711 || [[Südkorea]] 
|-
| align="right" | 5. || [[Mumbai|Mumbai]] || align="right" | 19.944.372 || [[Indien]] 
|-
| align="right" | 6. || [[São Paulo]] || align="right" | 19.357.485 || [[Brasilien]] 
|-
| align="right" | 7. || [[Jakarta]] || align="right" | 17.928.968 || [[Indonesien]] 
|-
| align="right" | 8. || [[Manila]] || align="right" | 17.843.620 || [[Philippinen]] 
|-
| align="right" | 9. || [[Los Angeles]] || align="right" | 17.767.199 || [[Vereinigte Staaten|USA]] 
|-
| align="right" | 10. || [[Delhi (Stadt)|Delhi]] || align="right" | 17.753.087 || [[Indien]] 
|-
| align="right" | 11. || [[Osaka]]-[[Kobe]]-[[Kyoto]] || align="right" | 17.524.809 || [[Japan]] 
|-
| align="right" | 12. || [[Kairo]] || align="right" | 15.707.992 || [[Ägypten]]
|-
| align="right" | 13. || [[Shanghai]] || align="right" | 14.871.156 || [[Volksrepublik China|VR China]] 
|-
| align="right" | 14. || [[Kolkata]] || align="right" | 14.681.589 || [[Indien]] 
|-
| align="right" | 15. || [[Moskau]] || align="right" | 14.520.800 || [[Russland]] 
|-
| align="right" | 16. || [[Buenos Aires]] || align="right" | 13.470.240 || [[Argentinien]] 
|-
| align="right" | 17. || [[London]] || align="right" | 12.524.316 || [[Vereinigtes Königreich|Großbritannien]]
|-
| align="right" | 18. || [[Teheran]] || align="right" | 12.183.682 || [[Iran]] 
|-
| align="right" | 19. || [[Karatschi]] || align="right" | 11.969.284 || [[Pakistan]] 
|-
| align="right" | 20. || [[Dhaka]] || align="right" | 11.918.442 || [[Bangladesch]] 
|-
| align="right" | 21. || [[Istanbul]] || align="right" | 11.912.511 || [[Türkei]] 
|-
| align="right" | 22. || [[Rio de Janeiro]] || align="right" | 11.826.609 || [[Brasilien]] 
|-
| align="right" | 23. || [[Rhein-Ruhr]] || align="right" | 11.793.829 || [[Deutschland]] 
|-
| align="right" | 24. || [[Paris]] || align="right" | 11.633.822 || [[Frankreich]] 
|-
| align="right" | 25. || [[Peking]] || align="right" | 11.537.036 || [[Volksrepublik China|VR China]] 
|-
| align="right" | 26. || [[Lagos]] || align="right" | 11.153.863 || [[Nigeria]] 
|-
| align="right" | 27. || [[Bangkok]] || align="right" | 9.996.388 || [[Thailand]] 
|-
| align="right" | 28. || [[Chicago]] || align="right" | 9.464.886 || [[Vereinigte Staaten|USA]] 
|-
| align="right" | 29. || [[Kinshasa]]-[[Brazzaville]] || align="right" | 9.343.416 || [[Demokratische Republik Kongo|DR Kongo]]/[[Republik Kongo]] 
|-
| align="right" | 30. || [[Hongkong]] || align="right" | 8.855.399 || [[Volksrepublik China|VR China]] 
|-
| align="right" | 31. || [[Nagoya]] || align="right" | 8.798.583 || [[Japan]] 
|-
| align="right" | 32. || [[Taipeh]] || align="right" | 8.136.572 || [[Taiwan]] 
|-
| align="right" | 33. || [[Washington (D.C.)|Washington]]-[[Baltimore]] || align="right" | 8.117.327 || [[Vereinigte Staaten|USA]] 
|-
| align="right" | 34. || [[Bogotá]] || align="right" | 7.941.955 || [[Kolumbien]] 
|-
| align="right" | 35. || [[Lima]] || align="right" | 7.857.121 || [[Peru]] 
|-
| align="right" | 36. || [[Khartum]] || align="right" | 7.830.479 || [[Sudan]] 
|-
| align="right" | 37. || [[Bagdad]] || align="right" | 7.724.982 || [[Irak]] 
|-
| align="right" | 38. || [[San Francisco]] || align="right" | 7.627.247 || [[Vereinigte Staaten|USA]] 
|-
| align="right" | 39. || [[Chongqing]] || align="right" | 7.572.198 || [[Volksrepublik China|VR China]] 
|-
| align="right" | 40. || [[Johannesburg]] || align="right" | 7.092.375 || [[Südafrika]] 
|-
| align="right" | 41. || [[Chennai]] || align="right" | 6.957.669 || [[Indien]] 
|-
| align="right" | 42. || [[Randstad]] || align="right" | 6.595.393 || [[Niederlande]] 
|-
| align="right" | 43. || [[Shenyang]] || align="right" | 6.545.021 || [[Volksrepublik China|VR China]] 
|-
| align="right" | 44. || [[Kuala Lumpur]] || align="right" | 6.527.057 || [[Malaysia]] 
|-
| align="right" | 45. || [[Lahore]] || align="right" | 6.485.175 || [[Pakistan]] 
|-
| align="right" | 46. || [[Tianjin]] || align="right" | 6.354.345 || [[Volksrepublik China|VR China]] 
|-
| align="right" | 47. || [[Philadelphia]] || align="right" | 6.262.182 || [[Vereinigte Staaten|USA]] 
|-
| align="right" | 48. || [[Bangalore]] || align="right" | 6.158.677 || [[Indien]] 
|-
| align="right" | 49. || [[Boston]] || align="right" | 6.149.196 || [[Vereinigte Staaten|USA]] 
|-
| align="right" | 50. || [[Toronto]] || align="right" | 6.141.895 || [[Kanada]] 
|-
| align="right" | 51. || [[Madrid]] || align="right" | 6.070.754 || [[Spanien]] 
|-
| align="right" | 52. || [[Dallas]] || align="right" | 6.034.858 || [[Vereinigte Staaten|USA]] 
|-
| align="right" | 53. || [[Hyderabad (Indien)|Hyderabad]] || align="right" | 6.012.368 || [[Indien]] 
|-
| align="right" | 54. || [[Detroit]]-[[Windsor (Ontario)|Windsor]] || align="right" | 5.905.764 || [[Vereinigte Staaten|USA]]/[[Kanada]] 
|-
| align="right" | 55. || [[Bandung]] || align="right" | 5.729.199 || [[Indonesien]] 
|-
| align="right" | 56. || [[Algier]] || align="right" | 5.723.749 || [[Algerien]] 
|-
| align="right" | 57. || [[Guangzhou]] || align="right" | 5.680.870 || [[Volksrepublik China|VR China]] 
|-
| align="right" | 58. || [[Singapur]]-[[Johor Bahru]] || align="right" | 5.331.235 || [[Singapur]]/[[Malaysia]] 
|-
| align="right" | 59. || [[Houston]] || align="right" | 5.299.946 || [[Vereinigte Staaten|USA]] 
|-
| align="right" | 60. || [[Thành ph? H? Chí Minh|Ho-Chi-Minh-Stadt]] || align="right" | 5.117.366 || [[Vietnam]] 
|-
| align="right" | 61. || [[Belo Horizonte]] || align="right" | 5.081.789 || [[Brasilien]]
|- 
| align="right" | 62. || [[Ahmedabad]] || align="right" | 5.080.566 || [[Indien]] 
|-
| align="right" | 63. || [[Abidjan]] || align="right" | 5.060.858 || [[Elfenbeinküste]]
|- 
| align="right" | 64. || [[Santiago de Chile|Santiago]] || align="right" | 4.893.495 || [[Chile]]
|- 
| align="right" | 65. || [[Barcelona]] || align="right" | 4.864.007 || [[Spanien]]
|- 
| align="right" | 66. || [[Sankt Petersburg]] || align="right" | 4.853.240 || [[Russland]]
|- 
| align="right" | 67. || [[Atlanta]] || align="right" | 4.843.183 || [[Vereinigte Staaten|USA]]
|-
| align="right" | 68. || [[San Diego]]-[[Tijuana]] || align="right" | 4.804.806 || [[Vereinigte Staaten|USA]]/[[Mexiko]]
|-
| align="right" | 69. || [[Xi'an]] || align="right" | 4.785.324 || [[Volksrepublik China|VR China]] 
|-
| align="right" | 70. || [[Harbin]] || align="right" | 4.757.265 || [[Volksrepublik China|VR China]]
|- 
| align="right" | 71. || [[Shantou]] || align="right" | 4.721.117 || [[Volksrepublik China|VR China]]
|- 
| align="right" | 72. || [[Pune]] || align="right" | 4.683.760 || [[Indien]]
|- 
| align="right" | 73. || [[Miami]] || align="right" | 4.680.930 || [[Vereinigte Staaten|USA]]
|- 
| align="right" | 74. || [[Wuhan]] || align="right" | 4.648.376 || [[Volksrepublik China|VR China]] 
|-
| align="right" | 75. || [[Busan]] || align="right" | 4.617.188 || [[Südkorea]]
|- 
| align="right" | 76. || [[Chengdu]] || align="right" | 4.610.820 || [[Volksrepublik China|VR China]]
|-
| align="right" | 77. || [[Rangun]] || align="right" | 4.572.948 || [[Myanmar]]
|- 
| align="right" | 78. || [[Hangzhou]] || align="right" | 4.541.393 || [[Volksrepublik China|VR China]] 
|-
| align="right" | 79. || [[Ibadan]] || align="right" | 4.535.894 || [[Nigeria]]
|- 
| align="right" | 80. || [[Kapstadt]] || align="right" | 4.503.063 || [[Südafrika]]
|- 
| align="right" | 81. || [[Sydney]] || align="right" | 4.444.513 || [[Australien]]
|-
| align="right" | 82. || [[Riad]] || align="right" | 4.328.067 || [[Saudi-Arabien]]
|- 
| align="right" | 83. || [[Alexandria]] || align="right" | 4.320.129 || [[Ägypten]]
|- 
| align="right" | 84. || [[Mailand]] || align="right" | 4.282.280 || [[Italien]]
|- 
| align="right" | 85. || [[Fukuoka]]-[[Kitakyushu]] || align="right" | 4.273.637 || [[Japan]]
|- 
| align="right" | 86. || [[Manchester]]-[[Liverpool]] || align="right" | 4.189.154 || [[Vereinigtes Königreich|Großbritannien]]
|- 
| align="right" | 87. || [[Nanking]] || align="right" | 4.071.600 || [[Volksrepublik China|VR China]]
|-
| align="right" | 88. || [[Guadalajara (Mexiko)|Guadalajara]] || align="right" | 4.056.684 || [[Mexiko]]
|- 
| align="right" | 89. || [[Berlin]] || align="right" | 4.010.470 || [[Deutschland]]
|- 
| align="right" | 90. || [[Surabaya]] || align="right" | 3.942.701 || [[Indonesien]]
|- 
| align="right" | 91. || [[Medan]] || align="right" | 3.927.188 || [[Indonesien]]
|- 
| align="right" | 92. || [[Kano]] || align="right" | 3.927.003 || [[Nigeria]]
|- 
| align="right" | 93. || [[Phoenix (Arizona)|Phoenix]] || align="right" | 3.907.429 || [[Vereinigte Staaten|USA]]
|-
| align="right" | 94. || [[Luanda]] || align="right" | 3.849.015 || [[Angola]]
|- 
| align="right" | 95. || [[Porto Alegre]] || align="right" | 3.812.571 || [[Brasilien]]
|- 
| align="right" | 96. || [[Seattle]] || align="right" | 3.810.856 || [[Vereinigte Staaten|USA]]
|-
| align="right" | 97. || [[Neapel]] || align="right" | 3.803.753 || [[Italien]]
|- 
| align="right" | 98. || [[Chittagong]] || align="right" | 3.795.034 || [[Bangladesch]]
|- 
| align="right" | 99. || [[Caracas]] || align="right" | 3.786.553 || [[Venezuela]]
|- 
| align="right" | 100. || [[Melbourne]] || align="right" | 3.780.871 || [[Australien]]
|- 
| align="right" | 101. || [[Nairobi]] || align="right" | 3.778.742 || [[Kenia]]
|- 
| align="right" | 102. || [[Athen]] || align="right" | 3.776.370 || [[Griechenland]]
|- 
| align="right" | 103. || [[Monterrey]] || align="right" | 3.745.120 || [[Mexiko]]
|-
| align="right" | 104. || [[Rom]] || align="right" | 3.695.467 || [[Italien]]
|- 
| align="right" | 105. || [[Ankara]] || align="right" | 3.625.597 || [[Türkei]]
|- 
| align="right" | 106. || [[Montréal]] || align="right" | 3.624.444 || [[Kanada]]
|-
| align="right" | 107. || [[Recife]] || align="right" | 3.587.059 || [[Brasilien]]
|- 
| align="right" | 108. || [[Salvador da Bahía]] || align="right" | 3.515.073 || [[Brasilien]]
|- 
| align="right" | 109. || [[Accra]] || align="right" | 3.404.507 || [[Ghana]]
|- 
| align="right" | 110. || [[Jinan]] || align="right" | 3.386.691 || [[Volksrepublik China|VR China]]
|- 
| align="right" | 111. || [[Guayaquil]] || align="right" | 3.348.250 || [[Ecuador]]
|- 
| align="right" | 112. || [[Medellín]] || align="right" | 3.313.230 || [[Kolumbien]]
|- 
| align="right" | 113. || [[Hamburg]] || align="right" | 3.277.237 || [[Deutschland]]
|- 
| align="right" | 114. || [[Daegu]] || align="right" | 3.271.668 || [[Südkorea]]
|- 
| align="right" | 115. || [[Durban]] || align="right" | 3.244.028 || [[Südafrika]]
|- 
| align="right" | 116. || [[Kanpur]] || align="right" | 3.243.745 || [[Indien]]
|- 
| align="right" | 117. || [[Birmingham]] || align="right" | 3.240.327 || [[Vereinigtes Königreich|Großbritannien]]
|- 
| align="right" | 118. || [[Minneapolis]]-[[Saint Paul (Minnesota)|Saint Paul]] || align="right" | 3.200.507 || [[Vereinigte Staaten|USA]]
|- 
| align="right" | 119. || [[Fortaleza]] || align="right" | 3.192.891 || [[Brasilien]]
|- 
| align="right" | 120. || [[Taschkent]] || align="right" | 3.190.085 || [[Usbekistan]]
|- 
| align="right" | 121. || [[Casablanca]] || align="right" | 3.177.281 || [[Marokko]]
|- 
| align="right" | 122. || [[Tel Aviv-Jaffa]] || align="right" | 3.127.554 || [[Israel]]
|- 
| align="right" | 123. || [[Curitiba]] || align="right" | 3.123.650 || [[Brasilien]]
|- 
| align="right" | 124. || [[Kabul]] || align="right" | 3.120.963 || [[Afghanistan]]
|- 
| align="right" | 125. || [[Rhein-Main-Gebiet|Rhein-Main]] || align="right" | 3.112.627 || [[Deutschland]]
|- 
| align="right" | 126. || [[Cali]] || align="right" | 3.109.430 || [[Kolumbien]]
|- 
| align="right" | 127. || [[Santo Domingo]] || align="right" | 3.089.252 || [[Dominikanische Republik]]
|- 
| align="right" | 128. || [[Surat (Indien)|Surat]] || align="right" | 3.044.731 || [[Indien]]
|- 
| align="right" | 129. || [[Rawalpindi]] || align="right" | 3.039.550 || [[Pakistan]]
|- 
| align="right" | 130. || [[Changchun]] || align="right" | 3.035.368 || [[Volksrepublik China|VR China]]
|-
| align="right" | 131. || [[Kiew]] || align="right" | 3.007.197 || [[Ukraine]]
