require File.dirname(__FILE__) + '/../../test_helper'

module SnipSnap
  class SkitchTest < Test::Unit::TestCase

    def read_fixture(filename)
      File.read(File.dirname(__FILE__) + '/../../fixtures/' + filename)
    end
    
    context "An instance of the Skitch class" do
      setup { @url = 'http://skitch.com/example' }
      
      should "have a URL" do
        s = SnipSnap::Skitch.new(@url)
        s.url.should == @url
      end
      
      should "be able to fetch a response" do
        response = stub()
        
        Curl::Easy.expects(:http_get).with(@url).returns(response)
        
        s = SnipSnap::Skitch.new(@url)
        s.fetch.should == response
      end
      
      should "fetch a response when calling response" do
        response = stub()
        
        s = SnipSnap::Skitch.new(@url)
        s.expects(:fetch).with().returns(response)
        
        s.response.should == response
      end
      
      should "cache the response object" do
        response = stub()
        
        s = SnipSnap::Skitch.new(@url)
        s.expects(:fetch).once.with().returns(response)
        
        2.times { s.response.should }
      end
      
      should "be able to return an image url for a given url" do
        s = SnipSnap::Skitch.new(@url)
        
        response = stub()
        response.stubs(:body_str).with().returns(read_fixture('skitch.html'))
        
        s.stubs(:response).with().returns(response)
        
        s.image_url.should == 'http://img.skitch.com/20090830-ejnqt1s9car55ju2sdnfirdsdn.jpg'
      end
      
    end
    
  end
end