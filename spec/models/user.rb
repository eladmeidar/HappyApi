class User < HappyApi::Base
  
  attr_accessor :id
  
  configure_api do |api|
  end

  has_many :comments
end
