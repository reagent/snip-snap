module SnipSnap
  class Yfrog
    
    def initialize(url)
      @url = url
    end
    
    def url
      identifier = @url.match(/([^\/]+)$/)[1]
      "http://yfrog.com/api/xmlInfo?path=#{identifier}"
    end
    
    def fetch
      client = Curl::Easy.new(url) do |config|
        config.follow_location = true
        config.max_redirects = 5
      end
      client.http_get
      client
    end
    
    def response
      @response ||= fetch
    end
    
    def image_url
      body = response.body_str
      body.match(/<image_link>(.+)<\/image_link>/)[1]
    end
    
  end
end