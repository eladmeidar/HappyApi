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
      class MissingAssociation < ArgumentError; end
    end

    module ClassMethods

      ALLOWED_OPTIONS = [:includes, :conditions, :offset, :limit]
      
      # Filter resources from all aspects
      def all(options = {})
        sanitized_options = sanitize_options(options)

        json_items = api_conn.get(self.resources_path, :query => options[:conditions]).parsed_response

        resources = process_response(json_items, options)

        return [resources].flatten.compact
      end

      def first(options = {})
      end

      # Get resources that match a specific list of foreign keys
      def find_by_ids(ids, options = {})
        ids = ids.sort
        json_items = api_conn.get(self.resources_path, :query => {:id => ids.join(",")}).parsed_response

        resources = process_response(json_items, options)

        return resources
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

      def process_response(json_items, options = {})
        resources = [json_items].flatten.collect {|json| self.new_from_json(json)}
        if resources.size == 1
          resources = resources.first
        end

        append_includes(resources, options[:includes])

        resources
      end

      def append_includes(resources, reflections = [])
        return if reflections.nil? || reflections.empty?
        
        resources = [resources].flatten

        reflections.each do |reflection|
          unless self.reflections.has_key?(reflection)
            raise(HappyApi::Finders::Exceptions::MissingAssociation, "the is no '#{reflection}' association for the #{self.name} class")
          end

          reflection_info = self.reflections[reflection]

          if reflection_info.nested?
            resources.each do |resource|
              nested_resource_path = [resource.resource_path(with_json = false), reflection_info.associated_class.resources_path].join
              response = api_conn.get(nested_resource_path).parsed_response
              association_instances = [response].flatten.collect {|json| reflection_info.associated_class.new_from_json(json)}
              resource.send("#{reflection_info.name}=", association_instances)
            end
          else
            association_instances = reflection_info.associated_class.all(:conditions => {reflection_info.foreign_key => resources.collect(&:primary_key).join(",")}).group_by(&:"#{reflection_info.foreign_key}")
            resources.each do |resource|
              resource.send("#{reflection_info.name}=", association_instances[resource.primary_key])
            end
          end
        end
      end

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