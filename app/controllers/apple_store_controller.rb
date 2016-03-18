class AppleStoreController < ApplicationController

  #
  # Search all ranking (free, grossing and paid)
  #
  get '/apple-store/by-ranking' do
    result          = AppleStoreRanking.new.find_all
    aditional_infos = AppleStoreLookup.new.find_all(map_lookup_ids(result))

    json(aggregate_element_lists(result, aditional_infos))
  end

  #
  # Search a ranking by specific category (free, grossing or paid)
  #
  get '/apple-store/category/:categoryId' do

    result          = AppleStoreRanking.new.find_all(params[:categoryId])
    aditional_infos = AppleStoreLookup.new.find_all(result['adamIds'])

    json(aggregate_elements(result, aditional_infos))
  end

end