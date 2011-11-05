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
require 'json'
require 'logger'

module YqlSimple

  class Client
    include HTTParty
    base_uri 'https://query.yahooapis.com/v1/public/yql'

    # @@yql_api_url = "https://query.yahooapis.com/v1/public/yql"
    @@env = "store://datatables.org/alltableswithkeys"

    # attr_accessor :yql_api_url
    # attr_accessor :env

    #get
    def self.env
      @@env
    end

    #set
    def self.env= (new_env)
      @@env = new_env
    end

    # #get
    # def self.yql_api_url
    #   @@yql_api_url
    # end
    #
    # #set
    # def self.yql_api_url=(new_yql_api_url)
    #   @@yql_api_url = new_yql_api_url
    # end

    def initialize()
    # def initialize(apikey)
      @log = Logger.new(STDOUT)
      @log.level = Logger::WARN
      # @apikey = apikey
    end
  end


  class SimpleClient < Client
    include HTTParty
    base_uri 'https://query.yahooapis.com/v1/public/yql'

    # Runs the given <b>yql_query</b> and returns the complete response.
    # Depending on the <b>format</b> parameter the result is either a ruby Hash (parsed from JSON) or a Nokogiri::XML::Document. The default is 'json'.
    # The <b>diagnostics</b parameter specifies whether or not to return query diagnostics. The default is 'false'.
    #
    def query(yql_query, format='json', diagnostics='false')
      # TODO tried to make the necessary parameters more flexibel. failed for now :)
      # format = (hash.nil? or hash[:format.to_s].nil?) ? 'json' : hash[:format.to_s]
      # format = (hash && hash[:format]) || 'json'

      @log.info "SimpleClient query()"

      # try to run YQL query. If an error occures return an empty array
      begin

        #
        # Httparty version
        #
        options = {
          :query => {
            :env => SimpleClient.env, #"store://datatables.org/alltableswithkeys",
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
  class OAuthClient < Client
    attr_reader :ctoken, :csecret, :consumer

    def initialize(ctoken, csecret)
      super()
      @ctoken = ctoken
      @csecret = csecret
    end

    def consumer
      @consumer ||= OAuth::Consumer.new(@ctoken, @csecret, config())
    end

    def config
      {
        :site               => "https://api.login.yahoo.com",
        :scheme             => :header,
        :http_method        => :post,
        :request_token_path => "/oauth/v2/get_request_token",
        :access_token_path  => "/oauth/v2/get_access_token"
      }
    end

    def access_token
      @access_token ||= OAuth::AccessToken.new(consumer())
    end

    def query(yql_query, format='json', diagnostics='false')
      @log.info "OAuthClient query()"

      # TODO these options are not used yet!!!
      options = {
        :env => "store://datatables.org/alltableswithkeys",
        :diagnostics => diagnostics,
        :format => format,
        :q => yql_query
      }

      # yahoo_response = self.class.get('/', options)
      options_string = options.map{|k,v| "#{k}=#{CGI.escape(v)}"}.join("&")

      response = access_token.get("http://query.yahooapis.com/v1/yql?#{options_string}")
      # response = access_token.get("http://query.yahooapis.com/v1/yql",options)
      return JSON[response.body]
    end

    def to_str
      "ctoken: #{@ctoken}, csecret: #{@csecret}"
    end
  end

end
