module SnipSnap
  class Yfrog
    
    include Client

    request_method :get
    
    def url
      identifier = @url.match(/([^\/]+)$/)[1]
      "http://yfrog.com/api/xmlInfo?path=#{identifier}"
    end

    def image_url
      body = response.body_str
      body.match(/<image_link>(.+)<\/image_link>/)[1]
    end
    
  end
end