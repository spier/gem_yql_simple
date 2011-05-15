require 'open-uri'
require 'pp'
require 'cgi'

# this does not make sense! then the gem would depend on bundler! LOL!!! :))
#Bundler.require(:default)

# is this wrong? So I really need to list all the production gems that I have in the .gemspec?
require 'json'
require 'nokogiri'
require 'curb'

module YqlSimple

    @@yql_api_url = "https://query.yahooapis.com/v1/public/yql"
    @@env = "env=store://datatables.org/alltableswithkeys"


    # Runs the given <b>yql_query</b> and returns the complete response.
    # Depending on the <b>format</b> parameter the result is either a ruby Hash (parsed from JSON) or a Nokogiri::XML::Document. The default is 'json'.
    # The <b>diagnostics</b parameter specifies whether or not to return query diagnostics. The default is 'false'.
    # 
    def self.query(yql_query, format='json', diagnostics='false')  
      # TODO tried to make the necessary parameters more flexibel. failed for now :)
      # format = (hash.nil? or hash[:format.to_s].nil?) ? 'json' : hash[:format.to_s]
      # format = (hash && hash[:format]) || 'json'
      
      # try to run YQL query. If an error occures return an empty array 
      begin  
        # put together request URL
        full_request_url = "#{@@yql_api_url}?diagnostics=#{diagnostics}"
        full_request_url += "&#{@@env}"
        full_request_url += "&format=#{format}"
        full_request_url += "&q=#{CGI.escape(yql_query)}"

        
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
