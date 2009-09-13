require File.dirname(__FILE__) + '/../test_helper'

class SnipSnapTest < Test::Unit::TestCase

  context "The SnipSnap module" do

    should "know the correct class name for a Skitch URL" do
      url = 'http://skitch.com/reagent/bh4ei/bleeergh'
      SnipSnap.class_name_for(url).should == 'Skitch'
    end
    
    should "know the correct class name for an Imgly URL" do
      url = 'http://img.ly/3ey'
      SnipSnap.class_name_for(url).should == 'Imgly'
    end
    
    should "know the correct class name for a Twitpic URL" do
      url = 'http://twitpic.com/203o0'
      SnipSnap.class_name_for(url).should == 'Twitpic'
    end
    
    should "know the correct class name for a Yfrog.com URL" do
      url = 'http://yfrog.com/ahb97j'
      SnipSnap.class_name_for(url).should == 'Yfrog'
    end
    
    should "know the correct class name for a Yfrog.us URL" do
      url = 'http://yfrog.us/ahb97j'
      SnipSnap.class_name_for(url).should == 'Yfrog'
    end
    
    should "know the correct class name for an expanded Yfrog URL" do
      url = 'http://img377.yfrog.com/i/b97.jpg/'
      SnipSnap.class_name_for(url).should == 'Yfrog'
    end
    
    should "know the correct class name for a Flickr URL" do
      url = 'http://flic.kr/p/64cBqN'
      SnipSnap.class_name_for(url).should == 'Flickr'
    end
    
    should "know the correct class name for a Twitgoo URL" do
      url = 'http://twitgoo.com/2r5hv'
      SnipSnap.class_name_for(url).should == 'Twitgoo'
    end
    
    should "use the default class when it can't match on other URLs" do
      url = 'http://example.com/image.jpg'
      SnipSnap.class_name_for(url).should == 'Image'
    end
    
    should "be able to create an instance of the Skitch class with the supplied URL" do
      url = 'http://skitch.com/reagent/bh4ei/bleeergh'
      SnipSnap::Skitch.expects(:new).with(url).returns('skitch')
      
      SnipSnap.from_url(url).should == 'skitch'
    end
    
    should "be able to create an instance of the Imgly class with the supplied URL" do
      url = 'http://img.ly/3ey'
      SnipSnap::Imgly.expects(:new).with(url).returns('imgly')
      
      SnipSnap.from_url(url).should == 'imgly'
    end
    
    should "be able to create an instance of the Twitpic class with the supplied URL" do
      url = 'http://twitpic.com/203o0'
      SnipSnap::Twitpic.expects(:new).with(url).returns('twitpic')

      SnipSnap.from_url(url).should == 'twitpic'
    end

    should "be able to create an instance of the Yfrog class with the supplied URL" do
      url = 'http://yfrog.com/ahb97j'
      SnipSnap::Yfrog.expects(:new).with(url).returns('yfrog')

      SnipSnap.from_url(url).should == 'yfrog'
    end
    
    should "be able to create an instance of the Flickr class with the supplied URL" do
      url = 'http://flic.kr/p/64cBqN'
      SnipSnap::Flickr.expects(:new).with(url).returns('flickr')

      SnipSnap.from_url(url).should == 'flickr'
    end
    
    should "be able to create an instance of the Twitgoo class with the supplied URL" do
      url = 'http://twitgoo.com/2r5hv'
      SnipSnap::Twitgoo.expects(:new).with(url).returns('twitgoo')

      SnipSnap.from_url(url).should == 'twitgoo'
    end
    
    should "be able to create an instance of the Image class with the supplied URL" do
      url = 'http://example.com/image.jpg'
      SnipSnap::Image.expects(:new).with(url).returns('image')

      SnipSnap.from_url(url).should == 'image'
    end
    
    should "be able to set the Flickr API key" do
      key = 'abc123'
      
      Fleakr.expects(:api_key=).with(key)
      
      SnipSnap.flickr_api_key = key
    end
    
  end

end