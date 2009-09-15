module SnipSnap
  class Flickr

    include Client

    request_method :head
    
    def endpoint_url
      response.last_effective_url
    end
    
    def identifier
      pattern = /^http:\/\/(?:www\.)?flickr.com\/photos\/[^\/]+\/(\d+)/
      match = endpoint_url.match(pattern)
      
      match[1] unless match.nil?
    end
    
    # TODO: Handle case when this fetch fails (e.g. invalid photo ID)
    def photo
      Fleakr::Objects::Photo.find_by_id(identifier)
    end
    
    def image_url
      photo.medium.url
    end
    
  end
end