// Copyright (c) 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

var API_URL = 'http://localhost:9292/'

	/**
 * Get the current URL.
 *
 * @param {function(string)} callback - called when the URL of the current tab
 *   is found.
 **/
function getCurrentTabDetails(callback) {
  // Query filter to be passed to chrome.tabs.query - see
  // https://developer.chrome.com/extensions/tabs#method-query
  var queryInfo = {
    active: true,
    currentWindow: true
  };

  chrome.tabs.query(queryInfo, function(tabs) {
    // chrome.tabs.query invokes the callback with a list of tabs that match the
    // query. When the popup is opened, there is certainly a window and at least
    // one tab, so we can safely assume that |tabs| is a non-empty array.
    // A window can only have one active tab at a time, so the array consists of
    // exactly one tab.
    var tab = tabs[0];

    // A tab is a plain object that provides information about the tab.
    // See https://developer.chrome.com/extensions/tabs#type-Tab
    var url = tab.url;
    var title = tab.title;
    var favIconUrl = tab.favIconUrl;

    // tab.url is only available if the "activeTab" permission is declared.
    // If you want to see the URL of other tabs (e.g. after removing active:true
    // from |queryInfo|), then the "tabs" permission is required to see their
    // "url" properties.
    console.assert(typeof url == 'string', 'tab.url should be a string');
    console.assert(typeof title == 'string', 'tab.title should be a string');
    console.assert(typeof favIconUrl == 'string', 'tab.favIconUrl should be a string');

    callback(url,title,favIconUrl);
  });

  // Most methods of the Chrome extension APIs are asynchronous. This means that
  // you CANNOT do something like this:
  //
  // var url;
  // chrome.tabs.query(queryInfo, function(tabs) {
  //   url = tabs[0].url;
  // });
  // alert(url); // Shows "undefined", because chrome.tabs.query is async.
}


function postRelationship(s, p, o, callback, errorCallback) {
  var postUrl = API_URL + '/relationships';
  var x = new XMLHttpRequest();
  x.open('POST', postUrl);
  x.setRequestHeader("Content-type","application/x-www-form-urlencoded");
  x.setRequestHeader ("Accept", "application/json");
  x.send("subject="+s+"&predicate="+p+"&object="+o);
  x.responseType = 'json';
  x.onload = function() {
    // Parse and process the response from Google Image Search.
    var response = x.response;
    console.log('x.response')
    console.log(response)
    var y = response.relationship;
    console.log(y);
    var z = response['relationship'];
    console.log(z);
    
    console.log(response.relationship) // <!-- WHY THIS NO WORKY
    if (!response || !response.relationship) {
        console.log('bad data')
      errorCallback('No response from relationships API!');
      return;
    }
    console.log('relationship data')
    var relationship = response.relationship;
    // Take the thumbnail instead of the full image to get an approximately
    // consistent image size.
    var id = relationship.id;
    console.assert(
        typeof !isNaN(id),
        'Unexpected respose from the Relationships API!');
    console.log('callback: ' + id)
    callback(id);
  };
  x.onerror = function(err) {
    errorCallback('Network error.' + err.description);
  };
  x.send();
}


function renderStatus(statusText) {
  document.getElementById('status').innerHTML = statusText;
}

function openTab(newURL) {
	chrome.tabs.create({ url: newURL });
}

document.addEventListener('DOMContentLoaded', function() {

  getCurrentTabDetails(function(url,title,favIconUrl) {

   document.getElementById('subject-url').textContent = url;
   document.getElementById('subject-title').textContent = title;

   if (favIconUrl) {
       var imageFavIcon = document.getElementById('subject-image-fav-icon');
        imageFavIcon.width = 32;
        imageFavIcon.height = 32;
        imageFavIcon.src = favIconUrl;
      imageFavIcon.hidden = false;
   }

   document.getElementById('tag-button').disabled = false;

   // if level is mentioned in URL, pre-select a radio button
	var levels = document.getElementsByName('object');
	for(var i = 0; i < levels.length; i++){
    if (url.indexOf(levels[i].value) > 0) {
	    levels[i].checked = true;
    }
  }


	document.getElementById('tag-button').addEventListener('click', function(e) {

	  	var objects = document.getElementsByName('object');
	  	var object_value;
	  	for(var i = 0; i < objects.length; i++){
	  	    if(objects[i].checked){
	  	    	object_value = objects[i].value;
	  	    }
	  	}
	  	  	
	  	// subject, predicate, object
	  	s =  url;
	  	p = 'urn:about';
	  	o =  object_value;
	  	
	  	// Put the image URL in Google search.
	    renderStatus('Recording Tag for ' + s);

	    postRelationship(s, p, o, function(id) {
	    console.log('id ' + id);
	  	document.body.style.backgroundColor = "green";
	  	renderStatus('<a onClick="openTab(\''+API_URL+'/relationships/'+id + '\');">Tagged successfully!</a>');
	  	chrome.browserAction.setIcon({path:"icon-tagged.png"});

    }, function(errorMessage) {
  	document.body.style.backgroundColor = "red";
      renderStatus('Cannot tag. ' + errorMessage);
    });


	});



   });
});
