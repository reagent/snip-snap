module SnipSnap
  class Flickr

    include Client

    request_method :head
    
    def identifier
      url = response.last_effective_url
      url.match(/([^\/]+)\/$/)[1]
    end
    
    def photo
      Fleakr::Objects::Photo.find_by_id(identifier)
    end
    
    def image_url
      photo.medium.url
    end
    
  end
end