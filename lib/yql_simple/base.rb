require 'open-uri'
require 'pp'
require 'cgi'

# this does not make sense! then the gem would depend on bundler! LOL!!! :))
#Bundler.require(:default)

# is this wrong?
require 'json'
require 'nokogiri'
require 'curb'

module YqlSimple

    @@yql_api_url = "https://query.yahooapis.com/v1/public/yql"
    @@env = "env=store://datatables.org/alltableswithkeys"

    # def self.query(yql_query, format='json', diagnostics='false')
    def self.query(yql_query, format='json', diagnostics='false')  
      # TODO tried to make the necessary parameters more flexibel. failed for now :)
      # format = (hash.nil? or hash[:format.to_s].nil?) ? 'json' : hash[:format.to_s]
      # format = (hash && hash[:format]) || 'json'
      
      # puts format
      # puts diagnostics
      
      # try to run YQL query. If an error occures return an empty array 
      begin  
        # put together request URL
        full_request_url = "#{@@yql_api_url}?diagnostics=#{diagnostics}"
        full_request_url += "&#{@@env}"
        full_request_url += "&format=#{format}"
        full_request_url += "&q=#{CGI.escape(yql_query)}"
        
        # puts full_request_url
        
        request = Curl::Easy.http_get(full_request_url)
        request.perform
        # pp request.header_str
        if format == 'json'
          yahoo_response = JSON.parse(request.body_str)
        elsif format == 'xml'
          yahoo_response = Nokogiri::XML(request.body_str)
        end
      rescue Exception => ex
        puts ex
      end

      return yahoo_response
    end  

end
