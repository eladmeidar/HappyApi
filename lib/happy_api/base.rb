module HappyApi
  class Base

    def self.inherited(base)
      base.class_eval do
        include HappyApi::Configuration
        include HappyApi::BaseInterface
        include HappyApi::StringTokenizer
        include HappyApi::BasicRoutes
        include HappyApi::Finders
      end
    end 
  end
end