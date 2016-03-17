require 'rack/test'
require 'rspec'

ENV['RACK_ENV'] = 'test'
require './app.rb'

def app
  App.new
end


require File.expand_path '../../app.rb', __FILE__

module RSpecMixin
  include Rack::Test::Methods
end

RSpec.configure { |c| c.include RSpecMixin }
