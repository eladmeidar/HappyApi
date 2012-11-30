require 'rubygems'
require 'bundler/setup'
require 'fakeweb'

require 'happy_api' # and any other gems you need
require 'models/user'

RSpec.configure do |config|
  # some (optional) config here
  FakeWeb.allow_net_connect = false
end