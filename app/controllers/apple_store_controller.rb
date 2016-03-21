class AppleStoreController < ApplicationController

  #
  # Search all ranking (free, grossing and paid)
  #
  get '/apple-store/ranking' do
    begin
      api_request     = Request::Ranking.new(params)
      halt_using_if_invalid(api_request)

      result = AppleStore.find_by_genre(api_request)
      json(result)

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

      result = AppleStore.find_by_genre_and_monetization_type(api_request)
      json(result)

    rescue NotFoundException => e
      halt_not_found(e)
    end
  end

end