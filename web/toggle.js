/*
    Copyright (C) 2008 Dr. Georg Fischer <punctum at punctum dot kom>
    @(#) $Id: toggle.js 36 2008-09-08 06:05:06Z gfis $
    2008-05-16: with Christian, from Ajax Hacks sample files
*/
var timeoutId, request;
var hostName = "localhost";

function handleCheck() { // event handler for XMLHttpRequest
	if (request.readyState == 4){
		clearTimeout(timeoutId);
		if (request.status == 200){
			// Implement document object in DOM
			xmlReturnVal = request.responseText;
			var id = xmlReturnVal.substr(0, xmlReturnVal.length - 2);
			// alert("parm=/" + xmlReturnVal + "/" + id + "/");
			obj = document.getElementById(xmlReturnVal);
			obj.setAttribute("class", "Ir");
		} else {
			alert("Problem " + request.status 
					+ " occurred with communicating between the XMLHttpRequest object and the server program.");
		}
	} 
}
 
function warn() {
	request.abort();
	alert("A problem occurred with communicating with the server program."
		+ "\nPlease make sure you are connected to the Internet and try again in a few moments.");
}

function initReq (reqType,url,bool) { // Initialize a Request object that is already constructed 
	/* Specify the function that will handle the HTTP response */
	request.onreadystatechange=handleCheck; 
	request.open(reqType,url,bool);
	timeoutId = setTimeout(warn,10000);
	request.send(null);
}

/* Wrapper function for constructing a Request object.
	Parameters:
	reqType: The HTTP request type such as GET or POST.
	url: The URL of the server program.
	asynch: Whether to send the request asynchronously or not. 
*/
function httpRequest(reqType,url,asynch) { // Mozilla-based browsers
	if (window.XMLHttpRequest){
		request = new XMLHttpRequest();
		initReq(reqType,url,asynch);
	} else if (window.ActiveXObject){
		request=new ActiveXObject("Msxml2.XMLHTTP");
		if (! request){
			request=new ActiveXObject("Microsoft.XMLHTTP");
		}
		if (request){
			initReq(reqType,url,asynch);
		}
	} else {
		alert("Your browser does not permit the use of all of this application's features!");
	}
}

function toggle(id) {
	httpRequest("GET", "/webapps/gramword/listax.jsp?toggle=" + id, true);
}
