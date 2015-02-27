# Curriculum Tagger Firefox Addon

## Installation

Menu > Addons > Extensions > [Options menu] > Install Add-on From File...
Select curriculum-tagger.xpi

## Building the Addon

You'll need the Mozilla Firefox SDK. You can download it here:
https://developer.mozilla.org/en-US/Add-ons/SDK/Tutorials/Installation#Installation

````
cd $FIREFOX_SDK_ROOT
source bin/activate
cd $GIT_REPO/firefox-addon
./build
````
