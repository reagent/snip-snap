require File.dirname(__FILE__) + '/../../test_helper'

module SnipSnap
  class ImglyTest < Test::Unit::TestCase
    
    context "An instance of the Imgly class" do
      setup do
        @url          = 'http://img.ly/3aa'
        @expanded_url = 'http://img.ly/show/large/3aa'
      end

      should "know that it is an image" do
        i = SnipSnap::Imgly.new(@url)
        i.should be_image
      end

      should "have a url expanded from the source" do
        i = SnipSnap::Imgly.new(@url)
        i.url.should == @expanded_url
      end
      
      should "be able to return an image url for a given url" do
        response = stub()
        response.stubs(:last_effective_url).with().returns(@expanded_url)
        
        i = SnipSnap::Imgly.new(@url)
        i.stubs(:response).with().returns(response)
        
        i.image_url.should == @expanded_url
      end
      
    end
    
  end
end

