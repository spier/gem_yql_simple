#!/usr/bin/env ruby
require "rubygems"
require "bundler/setup"

Bundler.require

require "logger"

log = Logger.new(STDOUT)

#
# Example of doing a twitter search via YQL
#
log.info "creating YqlSimple::SimpleClient and fetching some data from Twitter via YQL"
simple_client = YqlSimple::SimpleClient.new()

query_string = 'SELECT * FROM twitter.search WHERE q="#ruby" LIMIT 5'
response = simple_client.query(query_string, 'xml')

response["query"]["results"]["results"].each do |tweet|
  date = Time.parse(tweet["created_at"]).strftime("%Y-%m-%d %H:%M")
  puts "[#{date}] #{tweet["from_user"]}: #{tweet["text"]}"
end