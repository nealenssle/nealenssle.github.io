---
layout: post
title:  "How to roll your own Ajax"
date:   2006-09-26 05:47:32
categories: career
permalink: roll-your-own-ajax
---
A little while ago I decided I needed to get my head around this whole “Ajax” thing. From Wikipedia:

Ajax, shorthand for Asynchronous JavaScript and XML, is a web development technique for creating interactive web applications. The intent is to make web pages feel more responsive by exchanging small amounts of data with the server behind the scenes, so that the entire web page does not have to be reloaded each time the user makes a change. This is meant to increase the web page’s interactivity, speed, and usability.

Mainly it was for a couple of issues we were having at work, but I’ve long been a fan of the “magic” behind sites like Amazon, Flickr, and 30boxes.

So, after quite a bit of searching around in books and blogs, I managed to cobble together a couple of extremely simple scripts that take most of the mystique out of Ajax.

In fact, we’re also taking the “x” (for XML) out of Ajax, since this routine works by having your page call a JavaScript function that passes a request to some server-side code which then returns pure HTML. This HTML gets inserted into a container div on the calling page.

So here we go with the tutorial. An Ajax “how-to” in three easy steps (you can also download the code):

First things first, you need to get a “request object” that handles sending your request to the server. So we need a JavaScript function (inside a script block):

// initAjaxRequest():
//    Create a request object, based on browser type:

function initAjaxRequest() {
    var request;
    if (window.ActiveXObject) {
        request = new ActiveXObject("Microsoft.XMLHTTP");
    } else {
        request = new XMLHttpRequest();
    }
    return request;
}
Next, you’ll need to instantiate the request object at some point (this happens inside a JavaScript script block but outside of any function):

// Set a variable to hold an Ajax request object:

var ajaxRequest = initAjaxRequest();
Finally, you’ll need a JavaScript function that you can call to actually send the request to the server. The following function (inside a script block) takes URL parameter (that’s the server-side module, servlet, or page that will produce some HTML for us), along with a second parameter (”container”) that tells us where to put the resulting HTML:

// sendAjaxGetRequest(url, container):
//    Send an asychronous request to a specific URL,
//    designating CSS container ID to hold the
//    response information (HTML).

function sendAjaxGetRequest(url, container) {
    ajaxRequest.open('GET', url);
    ajaxRequest.setRequestHeader("Content-Type",
        "application/x-www-form-urlencoded");
    ajaxRequest.onreadystatechange = function() {
        if (ajaxRequest.readyState == 4 &&
            ajaxRequest.status == 200) {
            document.getElementById(container).innerHTML =
                ajaxRequest.responseText;
        }
    }
    ajaxRequest.send(null);
}
Now, to actually use these JavaScript functions, all we need to do is:

1. Call the JavaScript sendAjaxGetRequest(url, container) function (perhaps via an “onclick” handler), specifying the URL of a page that “does something” on the server-side, and a “container”. For example:

<p onclick="sendAjaxGetRequest('doSomething.htm', 'responseDiv');">Do something!</p>

2. Make sure we have a “container” div on the calling page that will hold the resulting HTML. For example:

<div id="responseDiv"></div>

Note that “doing something” can be as simple as printing any HTML to the screen. For example, the “doSomething.htm” page could simply look like this:

<p>I did something!</p>

Of course, this target page could be far more complex, such as a PHP page, ColdFusion template, or Java servlet that updates a database. The point of Ajax is just that you’re now able to post a request to the server, do something, and get information back without having to refresh the page.

If you want to send form fields via a POST instead URL parameters via a GET, here’s a slightly different function:

function sendAjaxPostRequest(url, parameters, container) {
    ajaxRequest.open('POST', url);
    ajaxRequest.setRequestHeader("Content-Type",
        "application/x-www-form-urlencoded");
    ajaxRequest.onreadystatechange = function() {
        if (ajaxRequest.readyState == 4 &&
            ajaxRequest.status == 200) {
            document.getElementById(container).innerHTML =
                ajaxRequest.responseText;
        }
    }
    ajaxRequest.send(parameters);
}
This function takes a “parameters” argument, which can be an encoded string of form field parameters. For example:

var url = "doSomething.php";
var parameters = "myField=" +
    encodeURI(document.myForm.myField.value);
sendAjaxPostRequest(url, parameters, "responseDiv");
That’s mostly it. Enjoy! (Again: You can download the code).
