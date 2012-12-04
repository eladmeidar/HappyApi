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

    it "should respond to PURGE requests" do
      User.should respond_to(:purge)
    end

    describe "#GET params sorting" do
      
      it "should keep get the same params order for the same params hash" do
        FakeWeb.register_uri(:get, "http://localhost/users.json?age=3&name=elad", :status => 200)

        3.times do
          User.all(:conditions => {:name => "elad", :age => 3}).should eql([])
        end
        
      end

      it "should generate a different order for different param names" do
        pending "Query engine not implemented"
      end
    end
  end

  describe "#instance_methods" do

    describe "#clear_cache" do
      it "should respond with 200 for an existing resource" do
        FakeWeb.register_uri(:purge, "http://localhost/users/10.json", :status => 200)
        @user = User.new()
        @user.id = 10
        @user.expire_cache.should be_true
      end
    end

    describe "#new_record?" do
      it "should return true for a new resource" do
        user = User.new
        user.new_record?.should be_true
      end

      it "should return false for a loaded resource" do
        @user = User.new_from_json({"username" => "elad", "id" => 3})

        @user.new_record?.should be_false
      end
    end

    describe "#primary_key" do
      it "should return the value in :id" do
        user = User.new
        user.id = 1

        user.primary_key.should eql(1)
      end
    end
  end


end
