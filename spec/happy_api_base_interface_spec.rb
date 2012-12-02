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

  describe "#instance_methods" do

    describe "#new_record?" do
      it "should return true for a new resource" do
        user = User.new
        user.new_record?.should be_true
      end

      it "should return false for a loaded resource" do
        pending "Not implemented"
      end
    end


  end


end
