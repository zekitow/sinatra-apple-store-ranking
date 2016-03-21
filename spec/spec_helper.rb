require 'rack/test'
require 'rspec'
require 'json-schema'
require 'vcr'
VCR.configure do |c|
    c.cassette_library_dir = 'spec/cassettes'
    c.hook_into :webmock
    c.configure_rspec_metadata!
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

RSpec::Matchers.define :match_response_schema do |schema|
  match do |response|
    schema_directory = "#{Dir.pwd}/spec/support/schemas"
    schema_path = "#{schema_directory}/#{schema}.json"
    JSON::Validator.validate!(schema_path, response.body, strict: true)
  end
end
