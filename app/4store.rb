#!/usr/bin/env ruby

require 'rubygems'
require '4store-ruby'
store = FourStore::Store.new 'http://dbtune.org/bbc/programmes/sparql/'
store.select("SELECT DISTINCT ?p WHERE {?p a <http://purl.org/ontology/po/Person>} LIMIT 10")
