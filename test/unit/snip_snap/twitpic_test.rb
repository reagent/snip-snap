require File.dirname(__FILE__) + '/../../test_helper'

module SnipSnap
  class TwitpicTest < Test::Unit::TestCase
    
    context "An instance of the Twitpic class" do
      setup do
        @url          = 'http://twitpic.com/203o0'
        @expanded_url = 'http://twitpic.com/show/large/203o0'
      end
      
      should "have a url derived from the source URL" do
        t = SnipSnap::Twitpic.new(@url)
        t.url.should == @expanded_url
      end
      
      should "use a HEAD request when retrieving the response" do
        response = stub()
        
        t = SnipSnap::Twitpic.new(@url)
        t.expects(:head).with().returns(response)
        
        t.response.should == response
      end
      
      should "be able to return an image url for a given url" do
        response = stub()
        response.stubs(:last_effective_url).with().returns(@expanded_url)
        
        t = SnipSnap::Twitpic.new(@url)
        t.stubs(:response).with().returns(response)
        
        t.image_url.should == @expanded_url
      end

      
    end
    
  end
end