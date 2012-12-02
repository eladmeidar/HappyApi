require 'spec_helper'

describe HappyApi::Configuration do
  
  before(:each) do
    load "models/user.rb"
  end

  describe "#api_port" do
    it "should not include port in base url if port is 80" do
      User.api_end_point.should eql("http://localhost")
    end

    it "should include port in api base url if port != 80" do
      User.api_port = 777
      User.api_end_point.should eql("http://localhost:777")
    end
  end

  describe "#api_primary_key" do
    it "should default to :id" do
      User.api_primary_key.should eql(:id)
    end

    it "should reflect a change" do
      User.api_primary_key = :uuid
      User.api_primary_key.should eql(:uuid)
      User.api_primary_key = :id
    end
  end

  describe "#api_population_mode" do
    it "should default to :strict" do
      Cat.api_population_mode.should eql(:strict)
    end

    it "should reflect a change" do
      Cat.api_population_mode = :loose
      Cat.api_population_mode.should eql(:loose)
    end

    it "should default to :loose when applied value is not in [:strict, :loose]" do
      Cat.api_population_mode == :funky
      Cat.api_population_mode.should eql(:loose)
      Cat.api_population_mode = :loose # just restoring defaults
    end
  end

  describe "#api_request_format" do
    it "should default to :json" do
      User.api_request_format.should eql(:json)
    end

    it "should reflect a change" do
      User.api_request_format = :xml
      User.api_request_format.should eql(:xml)
    end

    it "should default to :json when applied value is not in [:json, :xml]" do
      User.api_request_format = :html
      User.api_request_format.should eql(:json)
    end
  end

  describe "#api_resource_name" do
    it "should default to the plualized class name" do
      User.api_resource_name.should eql("users")
    end

    it "should reflect a change" do
      User.api_resource_name =  "cat"
      User.api_resource_name.should eql("cats")
      User.api_resource_name = "user"
    end
  end

  describe "#api_base_url" do
    it "should not accept invalid urls as values" do

      lambda{
        User.api_base_url = "dlfjkljksd"
      }.should raise_error(HappyApi::Configuration::Excpetions::InvalidApiAddress)

      lambda{
        User.api_base_url = "shoko.com/koko"
      }.should raise_error(HappyApi::Configuration::Excpetions::InvalidApiAddress)

      lambda{
        User.api_base_url = "htt://shoko.com/koko"
      }.should raise_error(HappyApi::Configuration::Excpetions::InvalidApiAddress)
    end

    it "should accept a valid url" do
      lambda{
        User.api_base_url = "http://service.elad.com/"
      }.should_not raise_error(HappyApi::Configuration::Excpetions::InvalidApiAddress)
    end
  end

  describe "#configure" do
    it "should allow configuration of base url and port via block" do
      
      User.configure_api do |api|
        api.api_port = 80
        api.api_base_url = "http://eladistheking.com"
      end

      User.api_end_point.should eql("http://eladistheking.com")

      User.api_base_url = "http://localhost"
    end
  end 
end