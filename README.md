# curriculum-tagger

## chrome extension

While browsing around the web, tag content you find against the UK Curricula.

To install: visit chrome://extensions, Developer mode, Load unpacked extension...

## firefox addon

See [firefox-addon/README.md]

## Web application

A small sintara web API to record the tagging relationships, and offer up curriculum concepts to tag things with.

To configure:

``` bash
cd app
bundle install
./database-setup.sh
```

To run

``` bash
cd app
bin/rackup -p 2000
```
