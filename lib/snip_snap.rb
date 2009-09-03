$:.unshift File.dirname(__FILE__)

require 'curb'
require 'uri'

require 'snip_snap/client'

require 'snip_snap/skitch'
require 'snip_snap/imgly'
require 'snip_snap/yfrog'
require 'snip_snap/twitpic'

module SnipSnap
  
  def self.host_map
    {
      'skitch.com'  => 'Skitch',
      'img.ly'      => 'Imgly',
      'twitpic.com' => 'Twitpic',
      'yfrog.com'   => 'Yfrog'
    }
  end

  def self.factory(url)
    const_get(class_name_for(url)).new(url)
  end
  
  def self.class_name_for(url)
    uri = URI.parse(url)
    host_map[uri.host]
  end
  
end