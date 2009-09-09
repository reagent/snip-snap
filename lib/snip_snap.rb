$:.unshift File.dirname(__FILE__)

require 'curb'
require 'fleakr'
require 'uri'

require 'snip_snap/client'

require 'snip_snap/skitch'
require 'snip_snap/imgly'
require 'snip_snap/yfrog'
require 'snip_snap/twitpic'
require 'snip_snap/flickr'
require 'snip_snap/image'

# = SnipSnap
#
# This is a small Ruby library that allows you to extract images from the more popular
# image sharing services.  Currently supported services are:
#
# * Img.ly
# * Skitch
# * Twitpic
# * Yfrog
# * Flickr
#
# To use, just point it at a URL:
# 
#  require 'rubygems'
#  require 'snip_snap'
#
#  client = SnipSnap.from_url('http://yfrog.com/7hb9lj')
#  puts client.image_url
#
# That's it.
#
module SnipSnap
  
  def self.host_map # :nodoc:
    {
      'skitch.com'  => 'Skitch',
      'img.ly'      => 'Imgly',
      'twitpic.com' => 'Twitpic',
      /yfrog\.(com|us)$/ => 'Yfrog',
      'flic.kr'     => 'Flickr' 
    }
  end

  # Use the correct class to handle image extraction for a given URL
  def self.from_url(url)
    const_get(class_name_for(url)).new(url)
  end
  
  def self.class_name_for(url) # :nodoc:
    uri = URI.parse(url)
    match = host_map.detect {|k,v| Regexp.new(k) =~ uri.host }
    
    match.nil? ? 'Image' : match[1]
  end
  
  # Set the Flickr API key for use by the underlying Flickr API library
  def self.flickr_api_key=(key)
    Fleakr.api_key = key
  end
  
end