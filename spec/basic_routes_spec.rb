require 'spec_helper'

describe HappyApi::BasicRoutes do
  
  describe "Class routes" do

    it "should generate a simple route to resources" do
      User.resources_path.should eql("/users.json")
    end
  end

  describe "Instance routes" do
    it "should generate a simple route to a resource" do
      @user = User.new

      @user.id = 1
      @user.resource_path.should eql("/users/1.json")
    end
  end
end