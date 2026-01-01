chrome.action.onClicked.addListener(function(tab) {
	chrome.runtime.openOptionsPage();
})

chrome.runtime.onInstalled.addListener(function(details) {
	if (details.reason === 'update') {
	  setTimeout(() => {
		chrome.tabs.create({
			url: chrome.runtime.getURL('update.html')
		  })
	  }, 100)
	}
  });