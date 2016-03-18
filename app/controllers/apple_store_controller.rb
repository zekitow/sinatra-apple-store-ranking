class AppleStoreController < ApplicationController

  get '/apple-store/by-ranking' do
    result = AppleStoreRanking.new.find_all
    result = result['topCharts']

    aditional_infos = AppleStoreLookup.new.find_all(map_lookup_ids(result))

    json(aggregate(result, aditional_infos))
  end

  get '/apple-store/category/:categoryId' do

    result = AppleStoreRanking.new.find_all(params[:categoryId])
    result = result['selectedChart']

    aditional_infos = AppleStoreLookup.new.find_all(map_lookup_ids(result))

    json(aggregate(result, aditional_infos))
  end

end