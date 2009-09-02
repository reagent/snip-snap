require File.dirname(__FILE__) + '/../../test_helper'

class ClientImplementation
  include SnipSnap::Client
end

class ClientGetImplementation
  include SnipSnap::Client
  request_method :get
end

class ClientHeadImplementation
  include SnipSnap::Client
  request_method :head
end

module SnipSnap
  class ClientTest < Test::Unit::TestCase
    
    context "An instance of the ClientImplementation class" do
      
      should "be able to make a get request" do
        url = 'http://example.com'
        
        client = mock() do |c|
          c.expects(:http_get).with()
        end
        
        config = mock() do |c|
          c.expects(:follow_location=).with(true)
          c.expects(:max_redirects=).with(5)
        end
        
        Curl::Easy.expects(:new).with(url).yields(config).returns(client)
        
        c = ClientImplementation.new(url)
        c.get.should == client
      end
      
      should "be able to make a head request" do
        url = 'http://example.com'
        
        client = mock() do |c|
          c.expects(:http_head).with()
        end
        
        config = mock() do |c|
          c.expects(:follow_location=).with(true)
          c.expects(:max_redirects=).with(5)
        end
        
        Curl::Easy.expects(:new).with(url).yields(config).returns(client)
        
        c = ClientImplementation.new(url)
        c.head.should == client
      end
      
    end
    
    context "An instance of the ClientGetImplementation class" do
      
      should "fetch a response using a GET request when calling response" do
        response = stub()
        
        c = ClientGetImplementation.new('http://example.com')
        c.expects(:get).with().returns(response)
        
        c.response.should == response
      end
      
      should "cache the response object" do
        response = stub()
        
        c = ClientGetImplementation.new('http://example.com')
        c.expects(:get).once.with().returns(response)
        
        2.times { c.response.should }
      end
      
    end
    
    context "An instance of the ClientHeadImplementation class" do
      
      should "fetch a response using a GET request when calling response" do
        response = stub()
        
        c = ClientHeadImplementation.new('http://example.com')
        c.expects(:head).with().returns(response)
        
        c.response.should == response
      end
      
      should "cache the response object" do
        response = stub()
        
        c = ClientHeadImplementation.new('http://example.com')
        c.expects(:head).once.with().returns(response)
        
        2.times { c.response.should }
      end
      
    end
    
    
  end
end