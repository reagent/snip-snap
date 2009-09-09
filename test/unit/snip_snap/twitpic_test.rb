require File.dirname(__FILE__) + '/../../test_helper'

module SnipSnap
  class TwitpicTest < Test::Unit::TestCase
    
    context "An instance of the Twitpic class" do
      setup do
        @url          = 'http://twitpic.com/203o0'
        @expanded_url = 'http://twitpic.com/show/large/203o0'
      end
      
      should "know the identifier" do
        t = SnipSnap::Twitpic.new(@url)
        t.identifier.should == '203o0'
      end
      
      should "have an image url derived from the source URL" do
        t = SnipSnap::Twitpic.new(@url)
        t.image_url.should == @expanded_url
      end
      
    end
    
  end
end