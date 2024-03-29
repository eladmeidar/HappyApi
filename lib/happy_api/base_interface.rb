module HappyApi
  module BaseInterface

    def self.included(base)
      base.class_eval do
        extend ClassMethods
        include InstanceMethods
      end
    end

    module ClassMethods

      def expire_cache(uri = nil)
        return if uri.nil?
        self.purge(uri).code == 200
      end
    end # ClassMethods

    module InstanceMethods

        def expire_cache
          self.class.purge(self.resource_path).code == 200
        end

        # Retrieve the primary key value
        def primary_key
          self.send(self.class.api_primary_key)
        end

        def new_record?
          self.primary_key.nil? || (self.primary_key.respond_to?(:empty?) && self.primary_key.empty?)
        end
    end # InstanceMethods
  end
end