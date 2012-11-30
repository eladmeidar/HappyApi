module HappyApi
  module BasicRoutes
    def self.included(base)
      base.class_eval do
        extend ClassMethods
        include InstanceMethods
      end
    end

    module ClassMethods

      def resources_path
        self.tokenize_string(self.resources_path_with_tokens, {:api_resource_name => self.api_resource_name,
                                                              :api_request_format => self.api_request_format })
      end

      def resources_path_with_tokens
        "/[api_resource_name].[api_request_format]"
      end

      def resource_path_with_tokens(with_format = true)
        if with_format
          "/[api_resource_name]/[id].[api_request_format]"
        else
          "/[api_resource_name]/[id]"
        end
      end
    end

    module InstanceMethods
      def resource_path(with_format = true)
        self.class.tokenize_string(self.class.resource_path_with_tokens(with_format), {:api_resource_name => self.class.api_resource_name,
                                                              :id => self.send(self.class.api_primary_key), 
                                                              :api_request_format => self.class.api_request_format })
      end
    end
  end
end