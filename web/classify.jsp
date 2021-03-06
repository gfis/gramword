<%--
    @(#) $Id: classify.jsp 805 2011-09-20 06:41:22Z gfis $
    2011-09-17: Dbat -> Configuration
    2008-05-16: classify a word list, with Ajax features
    Caution, this file must be encoded in pure ASCII because of Jasper2 compilation
--%>
<%@page import="java.util.Iterator"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="org.teherba.dbat.Configuration"%>
<%
response.setContentType("text/html; charset=utf-8"); 
%>
<?xml version="1.0"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%-- 
--%>
<%--
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
--%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Classify word list</title>
    <link rel="stylesheet" type="text/css" href="stylesheet.css" />
    <script src="script.js" type="text/javascript" />
</head>
<%
    String CVSID = "@(#) $Id: classify.jsp 805 2011-09-20 06:41:22Z gfis $";

    Object 
    field = session.getAttribute("format"   );  String format       = (field != null) ? (String) field : "html";
    field = session.getAttribute("lang"     );  String language     = (field != null) ? (String) field : "de";
    field = session.getAttribute("enc"      );  String encoding     = (field != null) ? (String) field : "ISO-8859-1";
    field = session.getAttribute("strat"    );  String strategy     = (field != null) ? (String) field : "all";
    field = session.getAttribute("infile"   );  String infile       = (field != null) ? (String) field : "";
    Configuration dbatConfig = new Configuration();
    dbatConfig.configure(dbatConfig.CLI_CALL);
    Connection con = dbatConfig.getOpenConnection();
    PreparedStatement pstmt = con.prepareStatement("SELECT entry, enrel FROM temp order by 1");
    pstmt.clearParameters();
    // pstmt.setString(1, word);
    ResultSet resultSet = pstmt.executeQuery();
%>
<body>
    <h2>Classify Words</h2>
	<table cellpadding="0" cellspacing="0"> 
<%
    int index = 0;
    boolean busy = true;
    while (resultSet.next()) { 
    	index ++;
    	String id = "L" + Integer.toString(index);
        String entry = resultSet.getString(1);
        String enrel = resultSet.getString(2);
	 	out.write("<tr><td onclick=\"toggle(\'" + id + "\',\'" + entry + "\');\"><span id=\"" 
	 			+ id + "\" class=\"" + enrel + "\">" + entry + "</span></td></tr>\n");
    } // while next()
	resultSet.close();
	pstmt.close();
	dbatConfig.closeConnection();
%>
    </table>        
</body>
</html>
