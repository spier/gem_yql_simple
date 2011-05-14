# require all gems from Bundler (default and development)
Bundler.require(:default, :development)

# the gem itself is available by default
# require 'yql_simple'

YQL_CORE_TABLE_COUNT = 116

# Test
# Docs: http://rdoc.info/gems/rspec/1.3.2/Spec/Matchers
describe YqlSimple do

  it "test diagnostics" do
    query_string = "SHOW TABLES"
    
    # diagnostics on
    response = YqlSimple.query(query_string, 'json', "true")
    response["query"].should have_key("diagnostics")
    
    # diagnostics off
    response = YqlSimple.query(query_string, 'json', "false")
    response["query"].should_not have_key("diagnostics")
  end
  
  it "test XML response" do
    query_string = "SHOW TABLES"
    
    response = YqlSimple.query(query_string, 'xml')

    response.class.should be_a(Nokogiri::XML::Document.class)
  end
  
  it "test JSON response" do
    query_string = "SHOW TABLES"
    
    response = YqlSimple.query(query_string, 'json')
    
    response.class.should be_a(Hash.class)
  end
  
  it "test for YQL core tables" do
    query_string = "SHOW TABLES"
    
    response = YqlSimple.query(query_string, 'json')
    
    core_tables = response["query"]["results"]["table"].select{|entry| not entry.is_a?(Hash)}
    core_tables.size.should == YQL_CORE_TABLE_COUNT
  end
  
  
end