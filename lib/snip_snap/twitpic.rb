module SnipSnap
  class Twitpic
    
    include Client
    
    request_method :head

    def identifier
      url.match(/([^\/]+)$/)[1]
    end
    
    def image_url
      "http://twitpic.com/show/large/#{identifier}"
    end
    
  end
end