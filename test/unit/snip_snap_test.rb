require File.dirname(__FILE__) + '/../test_helper'

class SnipSnapTest < Test::Unit::TestCase

  describe "The SnipSnap module" do

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
    
    should "know the correct class name for a Yfrog URL" do
      url = 'http://yfrog.com/ahb97j'
      SnipSnap.class_name_for(url).should == 'Yfrog'
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
    
  end

end