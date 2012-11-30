require 'spec_helper'

describe HappyApi::Configuration do

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
  end

  describe "#configure" do
    it "should allow configuration of base url and port via block" do
      
      User.configure_api do |api|
        api.api_port = 80
        api.api_base_url = "http://eladistheking.com"
      end

      User.api_end_point.should eql("http://eladistheking.com")
    end
  end 
end