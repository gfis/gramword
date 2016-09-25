/*  JavaScript functions for gramword
    @(#) $Id: script.js 36 2008-09-08 06:05:06Z gfis $
    2016-09-24: name was script.js, 1st function was setActiveStylesheet; Copyright
    2016-09-21: indexOf >= 0
    2008-05-18: with Christian, from Ajax Hacks sample files
    
    Make sure that ALL referenced stylesheets have a title= attribute,
    because otherwise they will not be deactivated !
*/
/*
 * Copyright 2008 Dr. Georg Fischer <punctum at punctum dot kom>
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
function activateStyles(title) {
    var i, a;
    for (i = 0; (a = document.getElementsByTagName("link")[i]); i ++) {
        if (a.getAttribute("rel").indexOf("stylesheet") >= 0 && a.getAttribute("title")) {
            a.disabled = true;
            if (a.getAttribute("title") == title) {
                a.disabled = false;
            }
        }
    } // for i
} // activateStyles
//----------------------------------------------------------
// now AJAX methods
var timeoutId, request;

function handleCheck() { // event handler for XMLHttpRequest
    if (request.readyState == 4){
        clearTimeout(timeoutId);
        if (request.status == 200){
            // Implement document object in DOM
            xmlReturnVal = request.responseText;
            var values = xmlReturnVal.split(",");
            // alert("parm=/" + xmlReturnVal + "/" + id + "/");
            obj = document.getElementById(values[0]);
            obj.setAttribute("class", values[1]);
        } else {
            alert("Problem " + request.status 
                    + " occurred with communicating between the XMLHttpRequest object and the server program.");
        }
    } 
} // handleCheck
 
function warn() {
    request.abort();
    alert("A problem occurred with communicating with the server program."
        + "\nPlease make sure you are connected to the Internet and try again in a few moments.");
} // warn

function initReq (reqType,url,bool) { // Initialize a Request object that is already constructed 
    // Specify the function that will handle the HTTP response
    request.onreadystatechange=handleCheck; 
    request.open(reqType,url,bool);
    timeoutId = setTimeout(warn,10000);
    request.send(null);
} // initReq

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
} // httpRequest

function toggle(id, entry) {
    httpRequest("GET", "servlet?view=toggle&id=" + id + "&entry=" + entry, true);
} // toggle
