class Comment < HappyApi::Base
  
  attr_accessor :id

  configure_api do |api|
    api.api_population_mode = :loose
  end
end