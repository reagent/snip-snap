require File.dirname(__FILE__) + '/../../test_helper'

module SnipSnap
  class ImglyTest < Test::Unit::TestCase
    
    context "An instance of the Imgly class" do
      setup do
        @url          = 'http://img.ly/3aa'
        @expanded_url = 'http://img.ly/show/large/3aa'
      end

      
      should "have a url expanded from the source" do
        i = SnipSnap::Imgly.new('http://img.ly/3aa')
        i.url.should == 'http://img.ly/show/large/3aa'
      end
      
      should "be able to fetch a response" do
        client = mock() do |c|
          c.expects(:http_head).with()
        end
        
        config = mock() do |c|
          c.expects(:follow_location=).with(true)
          c.expects(:max_redirects=).with(5)
        end
        
        Curl::Easy.expects(:new).with(@expanded_url).yields(config).returns(client)
        
        i = SnipSnap::Imgly.new(@url)
        i.fetch.should == client
      end
      
      should "fetch a response when calling response" do
        client = stub()
        
        i = SnipSnap::Imgly.new(@url)
        i.expects(:fetch).with().returns(client)
        
        i.response.should == client
      end
      
      should "cache the response object" do
        client = stub()
        
        i = SnipSnap::Imgly.new(@url)
        i.expects(:fetch).once.with().returns(client)
        
        2.times { i.response.should }
      end
      
      should "be able to return an image url for a given url" do
        client = stub()
        client.stubs(:last_effective_url).with().returns(@expanded_url)
        
        i = SnipSnap::Imgly.new(@url)
        i.stubs(:response).with().returns(client)
        
        i.image_url.should == @expanded_url
      end
      
    end
    
  end
end

