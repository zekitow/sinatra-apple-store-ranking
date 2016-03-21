class AppleStoreController < ApplicationController

  #
  # Search all ranking (free, grossing and paid)
  #
  get '/apple-store/ranking' do
    begin
      api_request     = Request::Ranking.new(params)
      halt_using_if_invalid(api_request)

      result          = AppleStoreRanking.new.find_by_genre(api_request)
      aditional_infos = AppleStoreLookup.new.find_all(map_lookup_ids(result))

      json(create_detailed_lists(result, aditional_infos))

    rescue NotFoundException => e
      halt_not_found(e)
    end
  end

  #
  # Search a ranking by specific category (free, grossing or paid)
  #
  get '/apple-store/category' do
    begin
      api_request = Request::Category.new(params)
      halt_using_if_invalid(api_request)

      result          = AppleStoreRanking.new.find_by_genre_and_monetization_type(api_request)
      aditional_infos = AppleStoreLookup.new.find_all(result['adamIds'])

      json(create_detailed_list(result, aditional_infos))

    rescue NotFoundException => e
      halt_not_found(e)
    end
  end

end