require File.dirname(__FILE__) + '/../../test_helper'

module SnipSnap
  class TwitgooTest < Test::Unit::TestCase
    
    context "An instance of the Twitgoo class" do
      setup do
        @url          = 'http://twitgoo.com/2r5hv'
        @expanded_url = 'http://twitgoo.com/api/message/info/2r5hv'
      end
      
      should "know that it's an image" do
        t = SnipSnap::Twitgoo.new(@url)
        t.should be_image
      end
      
      should "have a URL derived from the source URL" do
        t = SnipSnap::Twitgoo.new(@url)
        t.url.should == @expanded_url
      end
      
      should "know the image URL" do
        response = stub()
        response.stubs(:body_str).with().returns(read_fixture('twitgoo.xml'))
        
        t = SnipSnap::Twitgoo.new(@url)
        t.stubs(:response).with().returns(response)
        
        t.image_url.should == 'http://i29.tinypic.com/9sxqpx.png'
      end
      
      
    end
    
  end
end