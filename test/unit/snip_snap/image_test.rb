require File.dirname(__FILE__) + '/../../test_helper'

module SnipSnap
  class ImageTest < Test::Unit::TestCase

    MIME_TYPES = %w(image/jpeg image/gif image/pjpeg image/png)
    EXTENSIONS = %w(jpeg jpg gif png)

    context "An instance of the Image class" do
      setup { @url = 'http://example.com/image.jpg' }

      should "know the MIME type of the file referenced by the URL" do
        response = stub() {|r| r.stubs(:content_type).with().returns('image/jpeg') }

        i = SnipSnap::Image.new(@url)
        i.stubs(:response).with().returns(response)

        i.mime_type.should == 'image/jpeg'
      end

      should "know the extension of the file referenced by the URL" do
        response = stub() {|r| r.stubs(:last_effective_url).with().returns('http://example.com/image.jpg') }
        
        i = SnipSnap::Image.new('http://example.com/image.jpg')
        i.stubs(:response).with().returns(response)
        
        i.extension.should == 'jpg'
      end
      
      should "know that the extension is nil if the URL has no file extension" do
        response = stub() {|r| r.stubs(:last_effective_url).with().returns('http://example.com/path') }
                
        i = SnipSnap::Image.new('http://example.com/path')
        i.stubs(:response).with().returns(response)
        
        i.extension.should be_nil
      end

      should "know that the URL is not an image if it is of type 'text/html'" do
        i = SnipSnap::Image.new(@url)
        i.stubs(:extension).with().returns(nil)
        i.stubs(:mime_type).with().returns('text/html')

        i.should_not be_image
      end
      
      should "know that the URL is not an image if it has a '.html' extension" do
        i = SnipSnap::Image.new(@url)
        i.stubs(:extension).with().returns('html')
        i.stubs(:mime_type).with().returns(nil)

        i.should_not be_image
      end

      MIME_TYPES.each do |type|
        should "know that the URL is an image if it is of type '#{type}'" do
          i = SnipSnap::Image.new(@url)
          i.stubs(:mime_type).with().returns(type)
          i.stubs(:extension).with().returns(nil)
          
          i.should be_image
        end
      end
      
      EXTENSIONS.each do |extension|
        should "know that the URL is an image if it has a '.#{extension}' extension" do
          i = SnipSnap::Image.new(@url)
          i.stubs(:mime_type).with().returns(nil)
          i.stubs(:extension).with().returns(extension)
          
          i.should be_image
        end
      end

      should "know the URL for the image" do
        response = stub() {|r| r.stubs(:last_effective_url).with().returns('final_url') }
        
        i = SnipSnap::Image.new(@url)
        i.stubs(:image?).with().returns(true)
        i.stubs(:response).with().returns(response)
        
        i.image_url.should == 'final_url'
      end
      
      should "return nil for the image's URL if it is not an image" do
        i = SnipSnap::Image.new(@url)
        i.stubs(:image?).with().returns(false)
        
        i.image_url.should be_nil
      end
      
    end

  end
end