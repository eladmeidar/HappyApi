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
    end

    module InstanceMethods

      def save
      end

      def refresh
      end

      def update
      end

      def destroy
      end
      
    end
  end
end