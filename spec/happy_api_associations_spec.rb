require 'spec_helper'

describe HappyApi::Associations do

  describe "class reflections" do
    it "should respond to #reflections in class level" do
      User.should respond_to(:reflections)
    end

    it "should contain a pointer to the comments association" do
      User.reflections.should have_key(:comments)
    end

  end

  describe "#has_many association" do

    it "should respond to association name" do

      user = User.new

      user.should respond_to(:comments)
    end
  end
end