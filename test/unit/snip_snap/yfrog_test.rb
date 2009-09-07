require File.dirname(__FILE__) + '/../../test_helper'

module SnipSnap
  class YfrogTest < Test::Unit::TestCase
    
    context "An instance of the Yfrog class" do
      setup do
        @url          = 'http://yfrog.com/ahb97j'
        @expanded_url = 'http://yfrog.com/api/xmlInfo?path=ahb97j'
      end

      should "know that it is an image" do
        y = SnipSnap::Yfrog.new(@url)
        y.should be_image
      end

      should "have a url derived from the source URL" do
        y = SnipSnap::Yfrog.new(@url)
        y.url.should == @expanded_url
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
