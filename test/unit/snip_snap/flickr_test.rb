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
      
      should "know the endpoint URL" do
        response = stub()
        response.stubs(:last_effective_url).with().returns(@expanded_url)

        f = SnipSnap::Flickr.new(@url)
        f.stubs(:response).with().returns(response)

        f.endpoint_url.should == @expanded_url
      end
      
      should "know the identifier for the basic photo URL" do
        f = SnipSnap::Flickr.new('')
        f.stubs(:endpoint_url).with().returns('http://www.flickr.com/photos/northernraven/3317998738/')
        
        f.identifier.should == '3317998738'
      end
      
      should "know the identifier for the basic photo URL without a trailing slash" do
        f = SnipSnap::Flickr.new('')
        f.stubs(:endpoint_url).with().returns('http://www.flickr.com/photos/northernraven/3317998738')
        
        f.identifier.should == '3317998738'
      end
      
      should "return nil if it can't find the identifier in the URL" do
        url = 'http://www.flickr.com/photos/viget'
        
        f = SnipSnap::Flickr.new('')
        f.stubs(:endpoint_url).with().returns(url)
        
        f.identifier.should be_nil
      end
      
      should "know the identifier for the photo URL as part of a set" do
        url = 'http://www.flickr.com/photos/viget/3852378037/in/set-72157621982815973/'

        f = SnipSnap::Flickr.new(@url)
        f.stubs(:endpoint_url).with().returns(url)
        
        f.identifier.should == '3852378037'
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
