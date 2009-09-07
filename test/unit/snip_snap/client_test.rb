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
      
      should "be able to fetch a response" do
        response = stub()
        
        c = ClientImplementation.new('http://example.com')
        c.expects(:fetch).once.with().returns(response)
        
        c.response.should == response
      end
      
      should "cache the response object" do
        response = stub()
        
        c = ClientImplementation.new('http://example.com')
        c.expects(:fetch).once.with().returns(response)
        
        2.times { c.response }
      end
      
    end
    
    context "The ClientGetImplementation class" do
      
      should "know that it doesn't make a head request" do
        ClientGetImplementation.head?.should be(false)
      end
      
    end
    
    context "An instance of the ClientGetImplementation class" do
      
      should "fetch a response using a GET request" do
        url = 'http://example.com'
        
        client = mock() do |c|
          c.expects(:perform).with()
        end
        
        config = mock() do |c|
          c.expects(:follow_location=).with(true)
          c.expects(:max_redirects=).with(5)
          c.expects(:head=).with(false)
        end
        
        Curl::Easy.expects(:new).with(url).yields(config).returns(client)
        
        c = ClientGetImplementation.new(url)
        c.fetch.should == client
      end
      
    end
    
    
    context "The ClientHeadImplementation class" do

      should "know that it doesn't makes a head request" do
        ClientHeadImplementation.head?.should be(true)
      end
      
    end
    
    context "An instance of the ClientHeadImplementation class" do
      
      should "fetch a response using a HEAD request" do
        url = 'http://example.com'
        
        client = mock() do |c|
          c.expects(:perform).with()
        end
        
        config = mock() do |c|
          c.expects(:follow_location=).with(true)
          c.expects(:max_redirects=).with(5)
          c.expects(:head=).with(true)
        end
        
        Curl::Easy.expects(:new).with(url).yields(config).returns(client)
        
        c = ClientHeadImplementation.new(url)
        c.fetch.should == client
      end
      
    end
    
    
  end
end