class Cat < HappyApi::Base
  configure_api do |api|
    api.api_test_mode = true
  end
end