module HappyApi
  module Finders
    def self.included(base)
      base.class_eval do
        extend ClassMethods
        include InstanceMethods
      end
    end

    module Exceptions
      class InvalidFindOption < ArgumentError; end
    end

    module ClassMethods

      ALLOWED_OPTIONS = [:includes, :conditions, :offset, :limit]
      
      # Filter resources from all aspects
      def all(options = {})
        sanitized_options = sanitized_options(options)

      end

      # Get resources that match a specific list of foreign keys
      def find_by_ids(ids, options = {})
      end

      # Get a specific resource
      def find(id, options = {})
      end

      protected

      def sanitize_options(options = {})

        # Normalize the options hash
        sanitized_options = HashWithIndifferentAccess.new(options)

        sanitized_options.keys.each do |finder_option|

          # Validate all options are allowed
          unless ALLOWED_OPTIONS.include?(finder_option)
            raise(HappiApi::Finders::Exceptions::InvalidFindOption, "option '#{finder_option}' is an invalid option for HappyApi finder")
          end
        end

        return sanitized_options
      end
    end

    module InstanceMethods
    end
  end
end