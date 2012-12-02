module HappyApi
  module Associations
    def self.included(base)
      base.class_eval do
        extend ClassMethods
      end
    end

    module Exceptions
      class MissingAssociationName < ArgumentError; end
    end

    module ClassMethods
      def has_many(association_name = nil, options = {})

        if association_name.nil?
          raise(HappyApi::Associations::Exceptions::MissingAssociationName, "Association name is missing")
        end

        self.reflections[association_name.to_s.underscore] = HappyApi::AssociationProxy.new(association_name, options.merge(:parent_class_name => self.name.underscore))

        class_eval do
          attr_accessor :"#{association_name.to_s.underscore}"
        end
      end

      def reflections
        @@reflections ||= HashWithIndifferentAccess.new
      end
    end
  end
end

class HappyApi::AssociationProxy

  module Exceptions 
    class InvalidAssociationOption < ArgumentError; end
  end

  ALLOWED_OPTIONS = ["foreign_key", "associated_class", "nested", "parent_class_name"]
  
  attr_reader :name, :nested, :associated_class, :foreign_key
  
  def initialize(name, options = {})
    options = sanitize_options(ALLOWED_OPTIONS, options)

    if options.has_key?(:associated_class)
      associated_class = options[:associated_class]
    else
      associated_class = name.to_s.underscore.classify.constantize
    end

    options = HashWithIndifferentAccess.new({
      :foreign_key => "#{options[:parent_class_name].underscore}_id",
      :associated_class => associated_class,
      :nested => false
    }).merge(options)

    @foreign_key = options[:foreign_key]
    @associated_class = options[:associated_class]
    @name = name.to_s.underscore.to_sym

    @nested = [true, false].include?(options[:nested]) ? options[:nested] : false
  end

  def nested?
    @nested == true
  end

  def method_missing(method, *args, &block)
    self.associated_class.send(method, args, block)
  end

  protected

  def sanitize_options(option_set, options = {})

    # Normalize the options hash
    sanitized_options = HashWithIndifferentAccess.new(options)

    sanitized_options.keys.each do |finder_option|

      # Validate all options are allowed
      unless ALLOWED_OPTIONS.include?(finder_option)
        raise(HappyApi::AssociationProxy::Exceptions::InvalidAssociationOption, "option '#{finder_option}' is an invalid option for HappyApi Association")
      end
    end

    return sanitized_options
  end
end