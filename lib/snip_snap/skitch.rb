module SnipSnap
  class Skitch
    
    attr_reader :url
    
    def initialize(url)
      @url = url
    end
    
    def fetch
      Curl::Easy.http_get(url)
    end
    
    def response
      @response ||= fetch
    end
    
    def image_url
      body = response.body_str
      body.match(/addImage\(\s*'([^']+)'/)[1]
    end
    
  end
end