require 'spec_helper'

describe HappyApi::Finders do

  describe "#find" do
    it "should generate a GET to /cats.json?id=1" do
      
      FakeWeb.register_uri(:get, "http://localhost/cats.json?id=1", :body => '{"age": 3, "lives": 9}')
      
      cat = Cat.find(1)
      cat.age.should eql(3)
    end
  end
end