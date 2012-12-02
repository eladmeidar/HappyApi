require 'spec_helper'

describe HappyApi::Finders do
  before(:each) do
    Cat.api_population_mode = :loose
  end

  after(:each) do
    Cat.api_population_mode = :strict
  end
  
  describe "#find" do
    it "should generate a GET to /cats.json?id=1" do
      FakeWeb.register_uri(:get, "http://localhost/cats.json?id=1", :body => '{"age": 3,"id": 1, "lives": 9}')

      cat = Cat.find(1)
      cat.age.should eql(3)
    end

    it "should order the ids given" do
      FakeWeb.register_uri(:get, "http://localhost/cats.json?id=1%2C2%2C15", :body => '[{"age": 3,"id": 1, "lives": 9}, {"age": 9,"id": 2, "lives": 3}, {"age": 1,"id": 15, "lives": 99}]')
      Cat.api_population_mode = :loose
      cats = Cat.find([15,1,2])
      cats.size.should eql(3)
    end
  end

  describe "#includes" do
    it "should return a non-nested reflection" do
      FakeWeb.register_uri(:get, "http://localhost/users.json?id=1", :body => '{"age": 3,"id": 1, "lives": 9}')
      FakeWeb.register_uri(:get, "http://localhost/comments.json?user_id=1", :body => '[{"user_id": 1,"id": 991, "body": "this is great"}]')
      @user = User.find(1, :includes => [:comments])

      @user.comments.size.should eql(1)
      @user.comments.first.id.should eql(991)
    end

    it "should return a nested reflection" do
      FakeWeb.register_uri(:get, "http://localhost/users.json?id=1", :body => '{"age": 3,"id": 1, "lives": 9}')
      FakeWeb.register_uri(:get, "http://localhost/users/1/profiles.json", :body => '[{"picture": "elad.jpg","id": 123, "user_id": 1}]')
      @user = User.find(1, :includes => [:profiles])

      @user.profiles.size.should eql(1)
      @user.profiles.first.picture.should eql("elad.jpg")
    end
  end
end