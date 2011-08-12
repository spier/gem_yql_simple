# Simple Ruby gem for YQL

This is currently more an experiment of ruby gem building than a real ruby gem!!! The gem is usable but still may not be useful for anybody other than myself! Considered yourself at danger if you use it :)

This is my first implementation of a simple wrapper for [YQL](http://developer.yahoo.com/yql/) queries. It does not do anything fancy. Instead it just sends an HTTP request to YQL with the given query and returns the results as either a ruby Hash or Nokogiri::XML::Document.

I am using [bundler](http://gembundler.com) for the fetching the dependencies, [RSpec](http://relishapp.com/rspec) for the testing, and [RDoc](http://rdoc.sourceforge.net/doc/index.html) for code documentation.


## Useful Reads for Gem Building
* [Developing a RubyGem using Bundler](https://github.com/radar/guides/blob/master/gem-development.md)
* [Making Ruby Gems](http://timelessrepo.com/making-ruby-gems)
* [Using .gemspecs as Intended](http://yehudakatz.com/2010/04/02/using-gemspecs-as-intended/)


## Continuous Integration

Shows the current built status of this gem, as reported by [Travis CI](http://travis-ci.org/)

[![Build Status](https://secure.travis-ci.org/spier/gem_yql_simple.png)](http://travis-ci.org/spier/gem_yql_simple)


## Installation

The gem is not released yet, so it is not on [http://rubygems.org](http://rubygems.org) or similar.
If you really want to try it, what I would not recommend, then you have to build it yourself from source.

If you are using bundler you can do the following to install directly from the source:

	gem "yql_simple", :git => "git://github.com/spier/gem_yql_simple.git"
	

## Usage

Example of doing a twitter search, using the yql_simple gem. You can also find this exaple in the *examples* folder.

	#!/usr/bin/env ruby
	require "rubygems"
	require "bundler/setup"

	require "yql_simple"

	query_string = 'SELECT * FROM twitter.search WHERE q="#ruby" LIMIT 5'
	response = YqlSimple.query(query_string)

	response["query"]["results"]["results"].each do |tweet| 
	  date = Time.parse(tweet["created_at"]).strftime("%Y-%m-%d %H:%M")  
	  puts "[#{date}] #{tweet["from_user"]}: #{tweet["text"]}"
	end
		
This will output something like this:

	[2011-05-15 13:12] eyoosuf: Rails and Django for Quick thinking Developers, PHP for Lazy Developers #PHP #RUBY #ROR #PYTHON #Rails #Django
	[2011-05-15 12:57] rudkovsky: Looking for a job! #rails #ruby #job
	[2011-05-15 12:48] IndianGuru: Podcaster Miles Forrest interviewing RubyLearning;'s mentor Victor Goff this 18th #ruby
	[2011-05-15 12:41] openairjoy: outdoor: http://openairjoy.com/05/09/woodstock-chimes-ruby-throated-hummingbird-windchime.html Woodstock Chimes R #Chimes #Hummingbird #Ruby
	[2011-05-15 12:27] Elusive_Joe: I'm not entirely successfully installed gitorious at work. It seems this is the problem of #gitorious with #ruby 1.9.2
	

## TODO

* implement OAuth with YQL (will give the user more calls to YQL)
* add more test
* add [YQL Streaming](http://developer.yahoo.com/yql/guide/yql-odt-streaming.html) 


## Notes for Contributors

* build and install

	(sudo) rake install

* run the tests (this will check for a folder 'spec' and run rspec against all _spec files)

	bundle exec rspec spec
	
* generate rdoc (the rdoc documentation will be generated in ./doc)

	rake rdoc

* get a list of rake tasks

	rake -T
	