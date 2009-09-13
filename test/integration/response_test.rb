require File.dirname(__FILE__) + '/../test_helper'

# These are integration-level tests that actually hit the services that this library supports
# in order to ensure that image extraction works properly.  This is guaranteed *not* to work and 
# is not included in the default rake tasks.  
#
# If you *really* want to run this, use `rake integration` - don't complain if it doesn't work.
#

api_key = File.read(File.dirname(__FILE__) + '/../flickr_api_key').strip
SnipSnap.flickr_api_key = api_key

class ResponseTest < Test::Unit::TestCase
  
  context "The SnipSnap library" do
    
    should "be able to find the image in a Skitch URL" do
      client = SnipSnap.from_url('http://skitch.com/reagent/bh4ei/inbox-gmail-29466-messages-130-unread')
      client.image_url.should == 'http://img.skitch.com/20090913-bw3tnhse6rhn68erk6wpa882ea.jpg'
    end
    
    should "be able to find an image in a shortened Yfrog URL" do
      client = SnipSnap.from_url('http://yfrog.com/ahb97j')
      client.image_url.should == 'http://img377.yfrog.com/img377/9665/b97.jpg'
    end
    
    should "be able to find an image in a Yfrog.us URL" do
      client = SnipSnap.from_url('http://yfrog.us/ahb97j')
      client.image_url.should == 'http://img377.yfrog.com/img377/9665/b97.jpg'
    end
    
    should "be able to find an image in an expanded Yfrog URL" do
      client = SnipSnap.from_url('http://img377.yfrog.com/i/b97.jpg/')
      client.image_url.should == 'http://img377.yfrog.com/img377/9665/b97.jpg'
    end
    
    should "be able to find an image in a Twitpic URL" do
      client = SnipSnap.from_url('http://twitpic.com/h18dg')
      client.image_url.should == 'http://twitpic.com/show/large/h18dg'
    end
    
    should "be able to find an image in a shortened Flickr URL" do
      client = SnipSnap.from_url('http://flic.kr/p/5TTbLX')
      client.image_url.should == 'http://farm4.static.flickr.com/3449/3212555327_14d2d3f8b0.jpg'
    end
    
    should "be able to find an image in an expanded Flickr URL" do
      client = SnipSnap.from_url('http://flickr.com/photos/aureliaholandabarrigana/3212555327/')
      client.image_url.should == 'http://farm4.static.flickr.com/3449/3212555327_14d2d3f8b0.jpg'
    end
    
    should "be able to find an image in an img.ly URL" do
      client = SnipSnap.from_url('http://img.ly/3ey')
      client.image_url.should =~ /http:\/\/img\.ly\/media\/12434\/large_ChillPill13\.jpg/
    end
    
    should "be able to find an image in a Twitgoo URL" do
      client = SnipSnap.from_url('http://twitgoo.com/2r5hv')
      client.image_url.should == 'http://i29.tinypic.com/9sxqpx.png'
    end
    
    should "be able to find an image from a URL with a correct MIME type" do
      client = SnipSnap.from_url('http://img.ly/media/12434/large_ChillPill13.jpg')
      client.image_url.should == 'http://img.ly/media/12434/large_ChillPill13.jpg'
    end
    
    should "be able to find an image form a URL with a correct extension" do
      client = SnipSnap.from_url('http://1.bp.blogspot.com/_PnT6fOkhWyg/Smfa0gGhDzI/AAAAAAAABz8/BAweS5dIBCc/s1600-h/3747620025_21e47ae06f.jpg')
      client.image_url.should == 'http://1.bp.blogspot.com/_PnT6fOkhWyg/Smfa0gGhDzI/AAAAAAAABz8/BAweS5dIBCc/s1600-h/3747620025_21e47ae06f.jpg'
    end
    
    should "not return an image url for something that is not an image" do
      client = SnipSnap.from_url('http://lolwut.com/')
      client.image_url.should be_nil
    end
    
    should "be able to find an image in a shortened URL that points to an image" do
      client = SnipSnap.from_url('http://bit.ly/92g4x')
      client.image_url.should == 'http://1.bp.blogspot.com/_PnT6fOkhWyg/Smfa0gGhDzI/AAAAAAAABz8/BAweS5dIBCc/s1600-h/3747620025_21e47ae06f.jpg'
    end
    
    
  end
  
end