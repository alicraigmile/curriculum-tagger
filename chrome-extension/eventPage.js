chrome.tabs.onActivated.addListener(function(e) {
	var tabId = e.tabId;
	console.log('tab ' + tabId + ' activated.'); 
	chrome.tabs.get(tabId, function(tab) {
		var title = tab.title;
		
		if (title.indexOf('BBC') > -1) {
			console.log('bbc page');
			chrome.browserAction.setIcon({path:"icon-tagged.png"});
		} else {
			console.log('non bbc page');
			chrome.browserAction.setIcon({path:"icon-tag.png"});
		}	
		
	});
});

chrome.tabs.onUpdated.addListener(function(tabId, changeInfo, tab) {
	console.log('tab title: ' + tab.title); 	
	console.log('tab url: ' + tab.url);
	var title = tab.title;
	
	if (title.indexOf('BBC') > -1) {
		console.log('bbc page');
		chrome.browserAction.setIcon({path:"icon-tagged.png"});
	} else {
		console.log('non bbc page');
		chrome.browserAction.setIcon({path:"icon-tag.png"});
	}
});

chrome.tabs.onCreated.addListener(function(e) {         
	var tabId = e.tabId;
	
	console.log('tab ' + tabId + ' created - but it\'s probably too early to know anything about it yet.'); 
	
	
});

