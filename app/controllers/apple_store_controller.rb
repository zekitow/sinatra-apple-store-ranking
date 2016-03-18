class AppleStoreController < ApplicationController

  get '/apple-store/ranking' do
    result = AppleStoreRanking.new.find_all(params[:categoryId])


    adamIds = map_lookup_ids(result)
    binding.pry

    if params[:categoryId].present?
      json(result['selectedChart'])
    else
      json(result['topCharts'])
    end
  end

end