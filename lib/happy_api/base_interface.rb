module HappyApi
  module BaseInterface

    def self.included(base)
      base.class_eval do
        extend ClassMethods
        include InstanceMethods
      end
    end

    module ClassMethods

      # GET requests interface
      def get(args)
        self.api_conn.get(args)
      end

      # POST requests interface
      def post(args)
        self.api_conn.get(args)
      end

      # PUT requests interface      
      def put(args)
        self.api_conn.get(args)
      end

      # DELETE requests interface
      def delete(args)
        self.api_conn.get(args)
      end

      # HEAD requests interface
      def head(args)
        self.api_conn.get(args)
      end
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