# require all gems from Bundler (default and development)
Bundler.require(:default, :development)

# the gem itself is available by default
# require 'yql_simple'

# the number of core tables changes but it should be more than 100
YQL_CORE_TABLE_COUNT = 100

# my oauth credentials
# TODO set up a dummy account here, as this will be public
OAUTH_CONSUMER_KEY = 'dj0yJmk9V3hYVGNTeTNHQ3ZsJmQ9WVdrOWRIQllVRGxNTjJrbWNHbzlNVEV5TlRZd01qSTJNZy0tJnM9Y29uc3VtZXJzZWNyZXQmeD0wMg--'
OAUTH_CONSUMER_SECRET = '4a183185ddc8bd6934f11116cf96895547d97508'

# Tests
# Docs: http://relishapp.com/rspec
describe YqlSimple do

  # create a new instance of SimpleClient
  simple_client = YqlSimple::SimpleClient.new()

  it "OAuth success" do
    query_string = "SHOW TABLES"

    # create client
    oauth_client = YqlSimple::OAuthClient.new(OAUTH_CONSUMER_KEY,OAUTH_CONSUMER_SECRET)

    response = oauth_client.query(query_string, "json", "true")

    core_tables = response["query"]["results"]["table"].select{|entry| not entry.is_a?(Hash)}
    core_tables.size.should >= YQL_CORE_TABLE_COUNT

    # ----------

    # all commits from the github feed should have an author key
    query_string = 'SELECT * FROM feed WHERE url="https://github.com/spier/gem_yql_simple/commits/master.atom"'
    response = oauth_client.query(query_string, 'json')
    response["query"]["results"]["entry"][0].should have_key("author")
  end

  # it "OAuth failure" do
  #   query_string = "SHOW TABLES"
  #
  #   # create client with wrong credentials
  #   oauth_client = YqlSimple::OAuthClient.new("I_AM_WRONG","I_AM_WRONG")
  #   puts oauth_client.to_str
  #
  #   lambda { oauth_client.query(query_string, "json", "true") }.should raise_error()
  # end


  it "test diagnostics parameter" do
    query_string = "SHOW TABLES"

    # diagnostics on
    response = simple_client.query(query_string, "json", "true")
    # pp response
    response["query"].should have_key("diagnostics")

    # diagnostics off
    response = simple_client.query(query_string, "json", "false")
    response["query"].should_not have_key("diagnostics")
  end

  # when using HTTParty the response is already a Ruby object

  # it "test XML response" do
  #   query_string = "SHOW TABLES"
  #
  #   response = YqlSimple.query(query_string, 'xml')
  #
  #   response.class.should be_a(Nokogiri::XML::Document.class)
  # end

  it "test JSON response" do
    query_string = "SHOW TABLES"

    response = simple_client.query(query_string, 'json')

    response.class.should be_a(Hash.class)
  end

  it "test for YQL core tables" do
    query_string = "SHOW TABLES"

    response = simple_client.query(query_string, 'json')

    core_tables = response["query"]["results"]["table"].select{|entry| not entry.is_a?(Hash)}
    core_tables.size.should >= YQL_CORE_TABLE_COUNT
  end

  it "test some simple YQL calls" do
    # should return a status code of 200
    # query_string = 'SELECT * FROM data.headers WHERE url="https://github.com/spier/gem_yql_simple"'
    # response = YqlSimple.query(query_string, 'json')
    # pp response
    # response["query"]["results"]["resources"]["status"].should == "200"

    # all commits from the github feed should have an author key
    query_string = 'SELECT * FROM feed WHERE url="https://github.com/spier/gem_yql_simple/commits/master.atom"'
    response = simple_client.query(query_string, 'json')
    response["query"]["results"]["entry"][0].should have_key("author")

    # YQL queries to github are forbidden
    expected_error_msg = 'Redirected to a robots.txt restricted URL: https://github.com/spier/gem_yql_simple'
    query_string = 'SELECT * FROM html WHERE url="https://github.com/spier/gem_yql_simple"'
    response = simple_client.query(query_string, 'json',"true")
    response["query"]["diagnostics"]["url"]["error"].should == expected_error_msg
  end

  it "test variable access" do
    # test set env
    env = "something"
    YqlSimple::SimpleClient.env = env
    YqlSimple::SimpleClient.env.should == env

    # # test set yql_api_url
    # yql_api = "url_to_api"
    # YqlSimple.yql_api_url = yql_api
    # YqlSimple.yql_api_url.should == yql_api
  end

end