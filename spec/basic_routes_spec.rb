require 'spec_helper'

describe "#BasicRoutes" do
  
  it "should generate a simple route to a resource" do
    @user = User.new

    @user.resource_path.should eql("elad")
  end

  it "should generate a simple route to resources" do
    User.resources_path.should eql("/users.json")
  end
end