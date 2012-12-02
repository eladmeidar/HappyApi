require 'spec_helper'

describe HappyApi::BaseInterface do

  describe "basic HTTP interface" do

    it "should respond to GET requests" do
      User.should respond_to(:get)
    end

    it "should respond to PUT requests" do
      User.should respond_to(:put)
    end

    it "should respond to POST requests" do
      User.should respond_to(:post)
    end

    it "should respond to DELETE requests" do
      User.should respond_to(:delete)
    end

    it "should respond to HEAD requests" do
      User.should respond_to(:head)
    end
  end


end
