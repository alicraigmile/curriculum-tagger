// Copyright (c) 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

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

function getImageUrl(searchTerm, callback, errorCallback) {
  var searchUrl = 'http://localhost:9292/images/search.json' +
    '?q=' + encodeURIComponent(searchTerm);
  var x = new XMLHttpRequest();
  x.open('GET', searchUrl);
  // The Google image search API responds with JSON, so let Chrome parse it.
  x.responseType = 'json';
  x.onload = function() {
    // Parse and process the response from Google Image Search.
    var response = x.response;
    console.log('x.response')
    if (!response || !response || !response.results ||
        response.results.length === 0) {
        console.log('bad data')
      errorCallback('No response from Curriculum Image search!');
      return;
    }
    console.log('firstResult')
    var firstResult = response.results[0];
    // Take the thumbnail instead of the full image to get an approximately
    // consistent image size.
    var imageUrl = firstResult.url;
    var width = parseInt(firstResult.width);
    var height = parseInt(firstResult.height);
    console.assert(
        typeof imageUrl == 'string' && !isNaN(width) && !isNaN(height),
        'Unexpected respose from the Curriculum Image Search API!');
    console.log('callback')
    callback(imageUrl, width, height);
  };
  x.onerror = function(err) {
    errorCallback('Network error.' + err.description);
  };
  x.send();
}


function renderStatus(statusText) {
  document.getElementById('status').textContent = statusText;
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

	document.getElementById('tag-button').addEventListener('click', function(e) {
  	document.body.style.backgroundColor = "red";

   // Put the image URL in Google search.
    renderStatus('Performing Curriculum Image search for ' + url);

    getImageUrl(url, function(imageUrl, width, height) {

      renderStatus('Search term: ' + url + '\n' +
          'Curriculum image search result: ' + imageUrl);
      var imageResult = document.getElementById('image-result');
      // Explicitly set the width/height to minimize the number of reflows. For
      // a single image, this does not matter, but if you're going to embed
      // multiple external images in your page, then the absence of width/height
      // attributes causes the popup to resize multiple times.
      imageResult.width = width;
      imageResult.height = height;
      imageResult.src = imageUrl;
      imageResult.hidden = false;

    }, function(errorMessage) {
      renderStatus('Cannot display image. ' + errorMessage);
    });


	});



   });
});
