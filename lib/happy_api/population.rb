module HappyApi
  module Poplulation
    def self.included(base)
      base.class_eval do
        extend ClassMethods
      end
    end

    module Exceptions
      class MissingAttribute < ArgumentError; end
    end

    module ClassMethods

      def new_from_json(json)
        return populate_by_mode(json)
      end

      private
      
      def populate_by_mode(json)

        instance = self.new
                
        json.each_pair do |attribute, value|
          if !(instance.respond_to?(:"#{attribute}="))
            if self.strict_population?
              raise(HappyApi::Poplulation::Exceptions::MissingAttribute,"attribute '#{attribute}' is missing for class #{self.name}")
            else

              # If we are using the "loose", auto create the attr_accessor
              instance.class.class_eval do
                attr_accessor :"#{attribute}"
              end
            end
          end
          
          instance.send("#{attribute}=", value)
        end
        
        instance
      end
    end
  end
end