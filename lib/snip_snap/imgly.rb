module SnipSnap
  class Imgly
    
    def initialize(url)
      @url = url
    end
    
    def url
      identifier = @url.match(/([^\/]+)$/)[1]
      "http://img.ly/show/large/#{identifier}"
    end
    
    def fetch
      client = Curl::Easy.new(url) do |config|
        config.follow_location = true
        config.max_redirects = 5
      end
      client.http_head
      client
    end
    
    def response
      @response ||= fetch
    end
    
    def image_url
      response.last_effective_url
    end
    
  end
end