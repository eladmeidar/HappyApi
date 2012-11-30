module HappyApi
  module BaseInterface

    def self.included(base)
      base.class_eval do
        extend ClassMethods
        include InstanceMethods
      end
    end

    module ClassMethods

      def get(args)
        self.api_conn.get(args)
      end

      def post(args)
        self.api_conn.get(args)
      end

      def put(args)
        self.api_conn.get(args)
      end

      def delete(args)
        self.api_conn.get(args)
      end

      def head(args)
        self.api_conn.get(args)
      end
    end # ClassMethods

    module InstanceMethods

      def new_record?

        def primary_key
          self.send(self.class.api_primary_key)
        end

        def new_record?
          !(self.primary_key.nil?) && !(self.primary_key.empty?)
        end
      end
    end # InstanceMethods
  end
end