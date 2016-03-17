class AppleStoreController < ApplicationController

  get '/apple-store-all' do
    json AppleStoreService.new.find_all
  end

end