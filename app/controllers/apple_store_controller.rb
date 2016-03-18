class AppleStoreController < ApplicationController

  get '/apple-store/ranking' do
    result = AppleStore.new.find_all(params[:categoryId])

    if params[:categoryId].present?
      json(result['selectedChart'])
    else
      json(result['topCharts'])
    end
  end

end