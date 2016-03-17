class AppleStoreController < ApplicationController
  get '/apple-store-all' do
    json AppleStoreService.find_all
  end
end