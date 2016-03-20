require './dependencies'

class App < Sinatra::Base

  use AppleStoreController
  run! if app_file == $0
end
