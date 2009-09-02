require File.dirname(__FILE__) + '/../../test_helper'

module SnipSnap
  class YfrogTest < Test::Unit::TestCase
    
    context "An instance of the Yfrog class" do
      setup do
        @url          = 'http://yfrog.com/ahb97j'
        @expanded_url = 'http://yfrog.com/api/xmlInfo?path=ahb97j'
      end
      
      
      should "have a url derived from the source URL" do
        y = SnipSnap::Yfrog.new('http://yfrog.com/ahb97j')
        y.url.should == 'http://yfrog.com/api/xmlInfo?path=ahb97j'
      end
      
      should "be able to fetch a response" do
        config = mock() do |c|
          c.expects(:follow_location=).with(true)
          c.expects(:max_redirects=).with(5)
        end
        
        client = mock() {|c| c.expects(:http_get).with() }
        
        Curl::Easy.expects(:new).with(@expanded_url).returns(client).yields(config)
        
        y = SnipSnap::Yfrog.new(@url)
        y.fetch.should == client
      end
      
      should "fetch a response when calling response" do
        client = stub()
        
        y = SnipSnap::Yfrog.new(@url)
        y.expects(:fetch).with().returns(client)
        
        y.response.should == client
      end

      should "cache the response object" do
        client = stub()
        
        y = SnipSnap::Yfrog.new(@url)
        y.expects(:fetch).once.with().returns(client)
        
        2.times { y.response }
      end
      
      should "be able to return an image url for a given url" do
        y = SnipSnap::Yfrog.new(@url)
        
        response = stub()
        response.stubs(:body_str).with().returns(read_fixture('yfrog.xml'))
        
        y.stubs(:response).with().returns(response)
        
        y.image_url.should == 'http://img377.imageshack.us/img377/9665/b97.jpg'
      end
      
    end
    
  end
end
