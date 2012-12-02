class Profile < HappyApi::Base
  
  configure_api do |api|
    api.api_population_mode = :loose
  end
end