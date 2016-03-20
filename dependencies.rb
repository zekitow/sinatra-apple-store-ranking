require 'rubygems'
require 'bundler'
require 'sinatra'
require 'sinatra/base'
require 'sinatra/contrib/all'
require 'active_support/all'

ENV['RACK_ENV'] ||= 'development'
$env = ENV['RACK_ENV']

Dir.glob('./lib/requests/*.rb').each { |file| require file }
Dir.glob('./lib/services/apple_store_base.rb').each { |file| require file }
Dir.glob('./lib/{services}/*.rb').each { |file| require file }
Dir.glob('./app/helpers/*.rb').each { |file| require file }
Dir.glob('./app/controllers/application_controller.rb').each { |file| require file }
Dir.glob('./app/{controllers}/*.rb').each { |file| require file }


require 'pry' unless $env == 'production'
