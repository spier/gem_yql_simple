YQL-Simple - A simple Ruby gem for YQL
-----------------------

This is Ruby gem makes working with [YQL](http://developer.yahoo.com/yql/) queries a little bit easier. It does not do anything fancy, it just sends an HTTP request to YQL with the given query and returns the results as a hash.


Installation
-----------------------------

The gem is hosted on [http://rubygems.org](http://rubygems.org), so you just need to includ `gem "yql_simple"` in your `Gemfile` in order to install the gem.


Usage
-----------------------------

Example of doing a twitter search. You can find the full code in the *examples* folder.

	require "yql_simple"
	
	simple_client = YqlSimple::SimpleClient.new()

	query_string = 'SELECT * FROM twitter.search WHERE q="#ruby" LIMIT 5'
	response = simple_client.query(query_string)

	response["query"]["results"]["results"].each do |tweet| 
	  date = Time.parse(tweet["created_at"]).strftime("%Y-%m-%d %H:%M")  
	  puts "[#{date}] #{tweet["from_user"]}: #{tweet["text"]}"
	end
		
This will output something like this:

	[2011-05-15 13:12] eyoosuf: Rails and Django for Quick thinking Developers, PHP for Lazy Developers #PHP #RUBY #ROR #PYTHON #Rails #Django
	[2011-05-15 12:57] rudkovsky: Looking for a job! #rails #ruby #job
	[...]
	

Releases
-----------------------------

0.0.2
- added OAuth supported for 2-legged OAuth with YQL

0.0.1 (unreleased)
- added minimal RDoc documentation
- RDoc will be generated with `rake rdoc` or when installing the gem
- test installation via bundler and :git

Continuous Integration
-----------------------------

Shows the current built status of this gem, as reported by [Travis CI](http://travis-ci.org/)

[![Build Status](https://secure.travis-ci.org/spier/gem_yql_simple.png)](http://travis-ci.org/spier/gem_yql_simple)


Notes for Contributors
-----------------------------

I am using [bundler](http://gembundler.com) for the fetching the dependencies, [RSpec](http://relishapp.com/rspec) for the testing, and [RDoc](http://rdoc.sourceforge.net/doc/index.html) for code documentation.

* build and install

	(sudo) rake install

* run the tests (this will check for a folder 'spec' and run rspec against all _spec files)

	rake spec
	
* generate rdoc (the rdoc documentation will be generated in ./doc)

	rake rdoc

* get a list of rake tasks

	rake -T
	
* building the gem

	gem build yql_simple.gemspec
	
	
	
Useful Reads for Gem Building
-----------------------------

* [Developing a RubyGem using Bundler](https://github.com/radar/guides/blob/master/gem-development.md)
* [Making Ruby Gems](http://timelessrepo.com/making-ruby-gems)
* [Using .gemspecs as Intended](http://yehudakatz.com/2010/04/02/using-gemspecs-as-intended/)

	
	
Alternative Gems
-----------------------------

https://github.com/nas/yql
