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
        sanitized_options = sanitize_finder_options(options)

      end

      def first(options = {})
      end

      # Get resources that match a specific list of foreign keys
      def find_by_ids(ids, options = {})
        #api_conn.in_parallel do
          resp = api_conn.get(resources_path, {:id => ids.join(",")})
          resources = resp.body.collect {|json| self.new_from_json(json)}
          if resources.size == 1
            resources = resources.first
          end

          return resources
        #end
      end

      # Get a specific resource
      def find(id_or_symbol, options = {})
        case id_or_symbol
          when :first
            first(options)
          when :all
            all(options)
          else
            find_by_ids([id_or_symbol].flatten, options)
          end
      end

      protected

      def sanitize_options(option_set, options = {})

        # Normalize the options hash
        sanitized_options = HashWithIndifferentAccess.new(options)

        sanitized_options.keys.each do |finder_option|

          # Validate all options are allowed
          unless ALLOWED_OPTIONS.include?(finder_option)
            raise(HappyApi::Finders::Exceptions::InvalidFindOption, "option '#{finder_option}' is an invalid option for HappyApi finder")
          end
        end

        return sanitized_options
      end
    end

    module InstanceMethods
    end
  end
end