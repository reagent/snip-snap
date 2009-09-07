require File.dirname(__FILE__) + '/../../test_helper'

module SnipSnap
  class FlickrTest < Test::Unit::TestCase
    
    context "An instance of the Flickr class" do
      setup do
        @url          = 'http://flic.kr/p/64cBqN'
        @expanded_url = 'http://www.flickr.com/photos/northernraven/3317998738/'
      end
      
      should "know that it is an image" do
        f = SnipSnap::Flickr.new(@url)
        f.should be_image
      end
      
      should "know the identifier for the photo" do
        response = stub()
        response.stubs(:last_effective_url).with().returns(@expanded_url)
        
        f = SnipSnap::Flickr.new(@url)
        f.stubs(:response).with().returns(response)
        
        f.identifier.should == '3317998738'
      end
      
      should "be able to find the photo for the identifier" do
        identifier = '3317998738'
        photo      = stub()
        
        Fleakr::Objects::Photo.expects(:find_by_id).with(identifier).returns(photo)
        
        f = SnipSnap::Flickr.new(@url)
        f.stubs(:identifier).with().returns(identifier)
        
        f.photo.should == photo
      end
      
      should "know the image url" do
        url = 'http://farm.flickr.com/photo.jpg'
        
        photo = stub()
        photo.stubs(:medium).with().returns(stub(:url => url))
        
        f = SnipSnap::Flickr.new(@url)
        f.stubs(:photo).with().returns(photo)
        
        f.image_url.should == url
      end
      
    end
    
  end
end
