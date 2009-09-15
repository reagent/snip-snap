require File.dirname(__FILE__) + '/../test_helper'

class SnipSnapTest < Test::Unit::TestCase

  def self.should_know_the_class_name_for(matcher)
    url        = matcher.keys.first
    class_name = matcher.values.first

    should "know that the class name for #{url} is #{class_name}" do
      SnipSnap.class_name_for(url).should == class_name
    end
  end
  
  def self.should_create_an_instance_for(matcher)
    url        = matcher.keys.first
    class_name = matcher.values.first
    
    should "be able to create an instance of the #{class_name} class for the url: '#{url}'" do
      klass = SnipSnap.const_get(class_name)
      klass.expects(:new).with(url).returns('instance')
      
      SnipSnap.from_url(url).should == 'instance'
    end
    
  end

  context "The SnipSnap module" do

    should_know_the_class_name_for 'http://skitch.com/reagent/bh4ei/bleeergh'       => 'Skitch'
    should_know_the_class_name_for 'http://img.ly/3ey'                              => 'Imgly'
    should_know_the_class_name_for 'http://twitpic.com/203o0'                       => 'Twitpic'
    should_know_the_class_name_for 'http://yfrog.com/ahb97j'                        => 'Yfrog'
    should_know_the_class_name_for 'http://yfrog.us/ahb97j'                         => 'Yfrog'
    should_know_the_class_name_for 'http://img377.yfrog.com/i/b97.jpg/'             => 'Yfrog'
    should_know_the_class_name_for 'http://flic.kr/p/64cBqN'                        => 'Flickr'
    should_know_the_class_name_for 'http://www.flickr.com/photos/viget/3852378037/' => 'Flickr'
    should_know_the_class_name_for 'http://twitgoo.com/2r5hv'                       => 'Twitgoo'
    should_know_the_class_name_for 'http://example.com/image.jpg'                   => 'Image'
    
    should_know_the_class_name_for 'http://www.flickr.com/photos/viget/3852378037/in/set-72157621982815973/' => 'Flickr'

    should_create_an_instance_for 'http://skitch.com/reagent/bh4ei/bleeergh'       => 'Skitch'
    should_create_an_instance_for 'http://img.ly/3ey'                              => 'Imgly'
    should_create_an_instance_for 'http://twitpic.com/203o0'                       => 'Twitpic'
    should_create_an_instance_for 'http://yfrog.com/ahb97j'                        => 'Yfrog'
    should_create_an_instance_for 'http://yfrog.us/ahb97j'                         => 'Yfrog'
    should_create_an_instance_for 'http://img377.yfrog.com/i/b97.jpg/'             => 'Yfrog'
    should_create_an_instance_for 'http://flic.kr/p/64cBqN'                        => 'Flickr'
    should_create_an_instance_for 'http://www.flickr.com/photos/viget/3852378037/' => 'Flickr'
    should_create_an_instance_for 'http://twitgoo.com/2r5hv'                       => 'Twitgoo'
    should_create_an_instance_for 'http://example.com/image.jpg'                   => 'Image'

    should_create_an_instance_for 'http://www.flickr.com/photos/viget/3852378037/in/set-72157621982815973/' => 'Flickr'

    should "be able to set the Flickr API key" do
      key = 'abc123'
      
      Fleakr.expects(:api_key=).with(key)
      
      SnipSnap.flickr_api_key = key
    end
    
  end

end