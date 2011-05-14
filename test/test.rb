#!/usr/bin/env ruby

# # load gem
# begin
#   require 'yql_simple'
# rescue LoadError
#   require 'rubygems'
#   require 'yql_simple'
# end
# 
#more code goes here

require '../lib/yql_simple/base'

query_string = "SHOW TABLES"
# response = YqlSimple.query(query_string)


# response = YqlSimple.query(query_string, :format => 'xml', :diagnostics => true)
response = YqlSimple.query(query_string)

pp response

# pp response.keys