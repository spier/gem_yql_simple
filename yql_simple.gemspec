# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "yql_simple/version"

Gem::Specification.new do |s|
  # general gem information
  s.name        = "yql_simple"
  s.version     = YqlSimple::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Sebastian Spier"]
  s.email       = ["blog@airness.de"]
  s.homepage    = "https://github.com/spier/gem_yql_simple"
  s.description = s.summary = %q{Simple wrapper for calls to YQL}

  s.rdoc_options << '--title' << '--main' << 'README.rdoc' << '--line-numbers' << '--inline-source'
  #s.rubyforge_project = "yql_simple"

  # all dependencies of this gem
  # s.add_dependency "nokogiri"
  s.add_dependency "json"
  # s.add_dependency "curb"
  s.add_dependency "httparty"
  s.add_dependency "oauth"

  # dependencies when developing this gem
  s.add_development_dependency "rspec"
  s.add_development_dependency "rake"

  # all files that will be added to this gem. git is used for this
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end