require 'open-uri'
require 'pp'
require 'cgi'

# Load all required dependencies here manually.
# No bundler usage, as this would make the gem dependent on bundler! 
# require 'json'
# require 'nokogiri'
# require 'curb'

require 'httparty'
require 'oauth'

module YqlSimple
  
  class SimpleClient
    include HTTParty
    base_uri 'https://query.yahooapis.com/v1/public/yql'
    
    # @@yql_api_url = "https://query.yahooapis.com/v1/public/yql"
    # @@env = "env=store://datatables.org/alltableswithkeys"
    #   
    # attr_accessor :yql_api_url
    # attr_accessor :env
  
    # #get
    # def self.env
    #   @@env
    # end
    # 
    # #set
    # def self.env=(new_env)
    #   @@env = new_env
    # end
    # 
    # #get
    # def self.yql_api_url
    #   @@yql_api_url
    # end
    # 
    # #set
    # def self.yql_api_url=(new_yql_api_url)
    #   @@yql_api_url = new_yql_api_url
    # end


    # Runs the given <b>yql_query</b> and returns the complete response.
    # Depending on the <b>format</b> parameter the result is either a ruby Hash (parsed from JSON) or a Nokogiri::XML::Document. The default is 'json'.
    # The <b>diagnostics</b parameter specifies whether or not to return query diagnostics. The default is 'false'.
    # 
    def query(yql_query, format='json', diagnostics='false')  
      # TODO tried to make the necessary parameters more flexibel. failed for now :)
      # format = (hash.nil? or hash[:format.to_s].nil?) ? 'json' : hash[:format.to_s]
      # format = (hash && hash[:format]) || 'json'
      
      puts "SimpleClient query()"
    
      # try to run YQL query. If an error occures return an empty array 
      begin  
      
        #
        # Httparty version :)
        #
        
        options = {
          :query => {
            :env => "store://datatables.org/alltableswithkeys",
            :diagnostics => diagnostics, 
            :format => format, 
            :q => yql_query
          }
        }
        
        yahoo_response = self.class.get('/', options)
        
        #
        # Curl Version
        #
        
        # # put together request URL
        # full_request_url = "#{@@yql_api_url}?diagnostics=#{diagnostics}"
        # full_request_url += "&#{@@env}"
        # full_request_url += "&format=#{format}"
        # full_request_url += "&q=#{CGI.escape(yql_query)}"
      
        # request = Curl::Easy.http_get(full_request_url)
        # request.perform
        # # pp request.header_str
        # if format == 'json'
        #   yahoo_response = JSON.parse(request.body_str)
        # elsif format == 'xml'
        #   yahoo_response = Nokogiri::XML(request.body_str)
        # end
      
      rescue Exception => ex
        puts ex
      end
  
      return yahoo_response
    end  

  end
  
  
  # from https://github.com/jnunemaker/twitter/blob/b9fcb86e9b5857940e290863474f8137fa899a49/lib/twitter/oauth.rb
  class OAuthClient   
    # extend Forwardable
    # def_delegators :get, :post
    # 
    # attr_reader :ctoken, :csecret
    
    
    
    def initialize(ctoken, csecret)  
      @ctoken, @csecret = ctoken, csecret
    end
    
    def consumer
      @consumer ||= ::OAuth::Consumer.new(@ctoken, @csecret, {:site => 'https://api.login.yahoo.com'})
    end
    
    def access_token
      @access_token ||= ::OAuth::AccessToken.new(consumer, @atoken, @asecret)
    end
    
    def query(yql_query, format='json', diagnostics='false')  
      puts "OAuthClient query()"

      options = {
        :query => {
          :env => "store://datatables.org/alltableswithkeys",
          :diagnostics => diagnostics, 
          :format => format, 
          :q => yql_query
        }
      }
      
      # yahoo_response = self.class.get('/', options)
      response = access_token.get("http://query.yahooapis.com/v1/yql?q=show%20tables&format=json&callback=")
      pp response.body
    end
  end

end



# pp response

