# Curriculum Tagger Web Application

## Installation

Curriculum Tagger is a RESTful web API. It's built on top of the Sinatra framework - and so as a rack based app - it can be configured to run in a number of environments (e.g. heroku or apache-passenger). It works well started on the commandline, running on a dedicated port too.

### Setup

``` bash
./setup.sh
```

### To run on a dedicated port

``` bash
./run.sh
```

Note: ^C to quit

### Testing

If the application started properly, you should see 'ok' when you visit [http://localhost:9292/ping](http://localhost:9292/ping).

### Usage / Getting Started

The Curriculum Tagger Web Application is a self documenting RESTful Web API. To get started visit [http://localhost:9292/](http://localhost:9292/)

