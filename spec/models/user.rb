class User < HappyApi::Base
  
  attr_accessor :id
  
  configure_api do |api|
    api.api_population_mode = :loose
  end

  has_many :comments

  has_many :profiles, :nested => true
end
