module SnipSnap
  module Client

    module InstanceMethods
      
      attr_reader :url
      
      def initialize(url)
        @url = url
      end
      
      def get
        get_response {|c| c.http_get }
      end

      def head
        get_response {|c| c.http_head }
      end

      def get_response(&block)
        client = Curl::Easy.new(url) do |config|
          config.follow_location = true
          config.max_redirects = 5
        end

        block.call(client)

        client
      end

    end
    
    module ClassMethods
      
      def request_method(method_name)
        class_eval <<-CODE
          def response
            @response ||= #{method_name}
          end
        CODE
      end
      
    end
    
    def self.included(other)
      other.send(:include, SnipSnap::Client::InstanceMethods)
      other.send(:extend, SnipSnap::Client::ClassMethods)
    end
    
  end
end