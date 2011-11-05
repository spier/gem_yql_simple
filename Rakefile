require 'bundler'

# get the rake tasks build, install, and release from Bundler
Bundler::GemHelper.install_tasks
require 'rspec/core/rake_task'

# see example
# https://github.com/twitter/twitter-text-rb/blob/master/Rakefile
desc 'generate API documentation to doc/rdocs/index.html'
require 'rake/rdoctask'

Rake::RDocTask.new do |rd|
  namespace :doc do
    rd.main = "README.rdoc"
    rd.rdoc_dir = 'doc'
    # rd.rdoc_files.include("lib/**/*.rb")
    rd.rdoc_files.include("README.rdoc", "lib/**/*.rb")

    rd.options << '--inline-source'
    rd.options << '--line-numbers'
    rd.options << '--all'

    # For the --diagram and --fileboxes options to work you need GraphViz otherwise, delete those.
    # rd.options << '--fileboxes'
    # rd.options << '--diagram'
  end
end

# see http://duckpunching.com/rspec-2-0-rake-tasks
desc "Run specs (tests)"
RSpec::Core::RakeTask.new do |t|
  t.pattern = "./spec/**/*_spec.rb" # don't need this, it's default.
  # Put spec opts in a file named .rspec in root
end
