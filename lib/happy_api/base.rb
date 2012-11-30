module HappyApi
  class Base

    def self.inherited(base)
      base.class_eval do
        include HappyApi::BaseInterface
        include HappyApi::StringTokenizer
        include HappyApi::BasicRoutes
        include HappyApi::Finders
      end
    end
    # Configuration block that yields this class
    def self.configure_api(&block)
      yield(self)

      # Setup Hydra
      Typhoeus::Config.memoize = false
      @@hydra = Typhoeus::Hydra.new(:max_concurrency => 5)

      @@conn = Faraday.new(:url => self.api_end_point, :parallel_manager => self.hydra) do |faraday|
        faraday.adapter   :typhoeus
        faraday.request   :url_encoded
      end
    end

    def self.api_primary_key
      @@api_primary_key ||= :id
    end
    
    def self.api_primary_key=(new_api_primary_key)
      @@api_primary_key = new_api_primary_key.to_sym
    end

    def self.api_request_format
      @@api_request_format ||= "json"
    end

    def self.api_request_format=(new_request_format)
      if ["json", "xml"].include?(new_request_format.to_s.downcase) 
        @@api_request_format = new_request_format.to_s.downcase
      else
        @@api_request_format = "json"
      end
    end

    # Getter for the API resource name
    def self.api_resource_name
      @@api_resource_name ||= self.name.underscore.pluralize
    end

    def self.api_resource_name=(new_resource_name)
      @@api_resource_name = new_resource_name
    end

    # Setter for the base url to access the API
    def self.api_base_url=(new_api_base_url)
      @@api_base_url = new_api_base_url
    end

    # Getter for the API base url
    def self.api_base_url
      @@api_base_url ||= "http://localhost"
    end

    # Setter for the API port
    def self.api_port=(new_api_port)
      @@api_port=new_api_port.to_i
    end

    # Getter for the API Port
    def self.api_port
      @@api_port ||= 80
    end

    # Getter for the calculated end point for the API
    def self.api_end_point
      if self.api_port.to_i != 80
        "#{self.api_base_url}:#{self.api_port}"
      else
        self.api_base_url
      end
    end

    # Verbose mode for Typhoeus's cUrl calls
    def self.api_verbose=(verbose_mode)
      verbose_mode = [true, false].include?(verbose_mode) ? verbose_mode : false
      Typhoeus::Config.verbose = verbose_mode
    end

    protected 
    
    def self.api_conn
      @@conn
    end
    # Initialize or return an Hydra instance
    def self.hydra
      @@hydra ||= Faraday::Adapter::Typhoeus.setup_parallel_manager
    end
  end
end