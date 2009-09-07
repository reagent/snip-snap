module SnipSnap
  class Image
    
    MIME_TYPES = %w(image/jpeg image/gif image/pjpeg image/png)
    EXTENSIONS = %w(jpeg jpg gif png)
    
    include Client
    
    request_method :head
    
    def mime_type
      response.content_type
    end
    
    def extension
      uri = URI.parse(url)
      extension = File.extname(uri.path).sub(/./, '')
      
      extension unless extension == ''
    end
    
    def image?
      MIME_TYPES.include?(mime_type) || EXTENSIONS.include?(extension)
    end
    
    def image_url
      url if image?
    end
    
  end
end