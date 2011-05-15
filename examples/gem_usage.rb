#!/usr/bin/env ruby
require "rubygems"
require "bundler/setup"

require "yql_simple"

#
# Example of doing a twitter search via YQL
#

query_string = 'SELECT * FROM twitter.search WHERE q="#ruby" LIMIT 5'
response = YqlSimple.query(query_string)

response["query"]["results"]["results"].each do |tweet| 
  date = Time.parse(tweet["created_at"]).strftime("%Y-%m-%d %H:%M")  
  puts "[#{date}] #{tweet["from_user"]}: #{tweet["text"]}"
end