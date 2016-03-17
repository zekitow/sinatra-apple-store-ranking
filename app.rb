require './dependencies'

class App < Sinatra::Base

  YAML::load(File.open('./config/database.yml'))[$env].each do |key, value|
    set key, value
  end

   configure $env.to_sym do
    enable :raise_errors, :sessions, :logging

    ActiveRecord::Base.establish_connection(adapter: settings.adapter,
      username: settings.username,
      password: settings.password,
      host: settings.host,
      database: settings.database)
  end

  use AppleStoreController
  run! if app_file == $0
end
