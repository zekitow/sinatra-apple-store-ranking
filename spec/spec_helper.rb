require 'rack/test'
require 'rspec'

require 'vcr'
VCR.configure do |c|
    c.cassette_library_dir = 'spec/cassettes'
    c.hook_into :webmock
    c.configure_rspec_metadata!
    # c.allow_http_connections_when_no_cassette = true
end


ENV['RACK_ENV'] = 'test'
require './app.rb'


def app
  app = App.new
end

require File.expand_path '../../app.rb', __FILE__

module RSpecMixin
  include Rack::Test::Methods
end

RSpec.configure do |c|
  c.include RSpecMixin
end
