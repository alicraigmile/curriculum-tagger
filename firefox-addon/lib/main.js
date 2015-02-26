var buttons = require('sdk/ui/button/action');
var tabs = require("sdk/tabs");

var button = buttons.ActionButton({
  id: "mozilla-link",
  label: "Tag against the UK Curricula",
  icon: {
    "16": "./icon.png",
  },
  onClick: handleClick
});

function handleClick(state) {
  tabs.open("http://localhost:9292/");
} 
