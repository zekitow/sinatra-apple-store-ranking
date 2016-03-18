class AppleStoreController < ApplicationController

  get '/apple-store/ranking' do
    result = AppleStoreRanking.new.find_all(params[:categoryId])

    if params[:categoryId].present?
      result = result['selectedChart']
    else
      result = result['topCharts']
    end

    aditional_infos = AppleStoreLookup.new.find_all(map_lookup_ids(result))

    json(aggregate(result, aditional_infos))
  end

end