module SnipSnap
  class Twitgoo
    
    include Client
    
    def url
      identifier = @url.match(/([^\/]+)$/)[1]
      "http://twitgoo.com/api/message/info/#{identifier}"
    end
    
    def image_url
      body = response.body_str
      body.match(/<imageurl>(.+)<\/imageurl>/)[1]
    end
    
  end
end