var API_URL = 'http://localhost:9292/'
	
function isTagged(uri, callback, errorCallback) {
  var getUrl = API_URL + '/relationships/by/subject?uri='  + encodeURI(uri)
  var x = new XMLHttpRequest();
  x.open('GET', getUrl);
  x.setRequestHeader ("Accept", "application/json");
  x.responseType = 'json';
  x.onload = function() {
    // Parse and process the response from Google Image Search.
    var response = x.response;
    
    if (!response || !response.relationships[0]) {
        console.log('bad data')
      errorCallback('No (or bad) response from relationships API!');
      return;
    }

    var relationship = response.relationships[0];

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


chrome.tabs.onActivated.addListener(function(e) {
	var tabId = e.tabId;
	console.log('tab ' + tabId + ' activated.'); 
	chrome.tabs.get(tabId, function(tab) {
		var url = tab.url;
		
		isTagged(url,function(id) {
			chrome.browserAction.setIcon({path:"icon-tagged.png"});	
		}, function(err) {
			chrome.browserAction.setIcon({path:"icon-tag.png"});
		});
				
	});
});

chrome.tabs.onUpdated.addListener(function(tabId, changeInfo, tab) {
	console.log('tab title: ' + tab.title); 	
	console.log('tab url: ' + tab.url);
	var url = tab.url;
	
	isTagged(url,function(id) {
		chrome.browserAction.setIcon({path:"icon-tagged.png"});	
	}, function(err) {
		chrome.browserAction.setIcon({path:"icon-tag.png"});
	});
	
});

chrome.tabs.onCreated.addListener(function(e) {         
	var tabId = e.tabId;
	
	console.log('tab ' + tabId + ' created - but it\'s probably too early to know anything about it yet.'); 
});

