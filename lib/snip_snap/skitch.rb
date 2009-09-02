module SnipSnap
  class Skitch

    include Client
    
    request_method :get
    
    def image_url
      body = response.body_str
      body.match(/addImage\(\s*'([^']+)'/)[1]
    end
    
  end
end