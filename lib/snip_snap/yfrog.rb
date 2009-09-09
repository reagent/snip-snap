module SnipSnap
  class Yfrog
    
    include Client

    request_method :get
    
    def image_url
      body = response.body_str
      body.match(/<link rel="image_src" href="(.+)" \/>/)[1]
    end
    
  end
end