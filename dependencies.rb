require 'rubygems'
require 'bundler'
require 'sinatra/base'
require 'sinatra/contrib/all'
require 'active_record'
require 'active_support'
require 'sinatra/activerecord'
require 'pg'
require 'sinatra'

ENV['RACK_ENV'] ||= 'development'
$env = ENV['RACK_ENV']

Dir.glob('./lib/services/apple_store_base.rb').each { |file| require file }
Dir.glob('./lib/{services}/*.rb').each { |file| require file }
Dir.glob('./app/controllers/application_controller.rb').each { |file| require file }
Dir.glob('./app/{controllers,models}/*.rb').each { |file| require file }


require 'pry' unless $env == 'production'
