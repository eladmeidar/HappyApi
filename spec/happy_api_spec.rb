require 'spec_helper'

describe HappyApi do
  it "should not include port in base url if port is 80" do
    HappyApi::Base.api_end_point.should eql("http://localhost")
  end

  it "should include port in api base url if port != 80" do
    HappyApi::Base.api_port = 777
    HappyApi::Base.api_end_point.should eql("http://localhost:777")
  end

  describe "#configure" do
    it "should allow configuration of base url and port via block" do
      
      HappyApi::Base.configure_api do |api|
        api.api_port = 80
        api.api_base_url = "http://eladistheking.com"
      end

      HappyApi::Base.api_end_point.should eql("http://eladistheking.com")
    end
  end 
end