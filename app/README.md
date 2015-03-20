# Curriculum Tagger Web Application

## Installation

Curriculum Tagger is a RESTful web API. It's built on top of the Sinatra framework - and so as a rack based app - it can be configured to run in a number of environments (e.g. heroku or apache-passenger). It works well started on the commandline, running on a dedicated port too.

### Setup

``` bash
$ setup-curriculum-tagger
```

### Starting from the command line

``` bash
$ curriculum-tagger
```

If the application started properly, you should see 'ok' when you visit [http://localhost:9292/ping](http://localhost:9292/ping).

### Starting from Apache w/ Passenger

``` bash
$ ln -s httpd.conf /etc/httpd/conf.d/curriculum.xgusties.com.conf
$ service httpd restart
```

### Usage / Getting Started

The Curriculum Tagger Web Application is a self documenting RESTful Web API. To get started visit [http://localhost:9292/](http://localhost:9292/)

