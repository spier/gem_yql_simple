# Simple Ruby gem for YQL

This is my first implementation of a simple wrapper for [YQL][yql] queries. It does not do anything fancy. Instead it just sends an HTTP request to YQL with the given query and returns the results as either a ruby Hash or Nokogiri::XML::Document.

This is my first experiment with writing a ruby gem. You can tell when checking out the code!

I am using [bundler][bundler] for the dependencies and [rspec][RSpec] for the testing.


## Useful Reads
* [Developing a RubyGem using Bundler](https://github.com/radar/guides/blob/master/gem-development.md)
* [Making Ruby Gems](http://timelessrepo.com/making-ruby-gems)
* [Using .gemspecs as Intended](http://yehudakatz.com/2010/04/02/using-gemspecs-as-intended/)


## Installation

The gem is not released yet!
If you really want to try it, what I would not recommend, then you have to build it yourself from source.

If you are using bundler I guess you can do the following to install directly from the github repo but I have not tried this:

	gem "yql_simple", :git => "git://github.com:spier/gem_yql_simple.git"
	

## Usage

	require "yql_simple"
	query_string = "SHOW TABLES"
	pp YqlSimple.query(query_string)


## Notes (more for myself than for anybody else)

### get a list of rake tasks

	rake -T

### build and install

	sudo rake install

### run the tests (this will check for a folder 'spec' and run rspec against all _sec files)

	bundle exec rspec spec
	
### generate the rdoc documentation in ./doc
	rake rdoc



[bundler]: http://gembundler.com/
[rspec]: http://relishapp.com/rspec
[yql]: http://developer.yahoo.com/yql/