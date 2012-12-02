module HappyApi
  module BaseInterface

    def self.included(base)
      base.class_eval do
        extend ClassMethods
        include InstanceMethods
      end
    end

    module ClassMethods

    end # ClassMethods

    module InstanceMethods

        # Retrieve the primary key value
        def primary_key
          self.send(self.class.api_primary_key)
        end

        def new_record?
          self.primary_key.nil? || self.primary_key.empty?
        end
    end # InstanceMethods
  end
end