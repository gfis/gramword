<?xml version="1.0" encoding="UTF-8"?>
<!--
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
-->
<!--
    get the first <td> element in each <tr>
    @(#) $Id: getkey.xsl 36 2008-09-08 06:05:06Z gfis $
    2006-10-05, Dr. Georg Fischer
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text"/>
    <xsl:strip-space elements="table tr"/> 

    <xsl:template match="tr">
        <xsl:value-of select="concat(translate(td[1], ' ',''), '&#xa;')" />
    </xsl:template>
    
</xsl:stylesheet>
