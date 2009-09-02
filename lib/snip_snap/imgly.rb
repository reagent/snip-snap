module SnipSnap
  class Imgly

    include Client

    request_method :head
    
    def url
      identifier = @url.match(/([^\/]+)$/)[1]
      "http://img.ly/show/large/#{identifier}"
    end
    
    def image_url
      response.last_effective_url
    end
    
  end
end