require 'spec_helper'


describe HappyApi::Poplulation do

  before(:each) do
    Object.send(:remove_const, 'User')
    load "models/user.rb"
  end

  describe "Loose mode" do
    it "should default to :loose mode behavior" do
      User.api_population_mode.should eql(:loose)
    end

    it "should initialize an instance based on incoming population json" do

      user = User.new_from_json('{"username": "elad", "age": 28}')

      user.username.should eql("elad")
      user.age.should eql(28)
    end

    it "should reflect learned attributes on new instances after a loose initialization" do
      user = User.new_from_json('{"username": "elad", "age": 28}')

      user2 = User.new

      user2.should respond_to(:username)
    end
  end

  describe "Strict mode" do

    it "should raise an error when incoming attributes are missing" do
        User.api_population_mode = :strict

        lambda {
          user = User.new_from_json('{"username": "elad", "age": 28}')
        }.should raise_error(HappyApi::Poplulation::Exceptions::MissingAttribute, "attribute 'username' is missing for class User")
    end
  end
end