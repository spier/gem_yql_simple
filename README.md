# Simple Ruby gem for YQL

First experiment with writing a ruby gem.

I am using bundler for the dependencies and rspec for the testing.

## Useful Readings
[Developing a RubyGem using Bundler](https://github.com/radar/guides/blob/master/gem-development.md)
[Making Ruby Gems](http://timelessrepo.com/making-ruby-gems)
[Using .gemspecs as Intended](http://yehudakatz.com/2010/04/02/using-gemspecs-as-intended/)


## Notes

### get a list of rake tasks

	rake -T

### build and install

	sudo rake install

### run the tests (this will check for a folder 'spec' and run rspec against all _sec files)

	bundle exec rspec spec
