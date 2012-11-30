module HappyApi
  module StringTokenizer

    def self.included(base)
      base.class_eval do
        extend ClassMethods
      end
    end

    module ClassMethods
      def tokenize_string(string = "", value_hash = {})
        replaced_string = string.clone
        value_hash.each_pair do |token, value|
          replaced_string.gsub!(/\[#{token}\]/, value.to_s)
        end
        replaced_string
      end
    end
  end
end