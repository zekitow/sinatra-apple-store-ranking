class AppleStoreController < ApplicationController

  #
  # Search all ranking (free, grossing and paid)
  #
  get '/apple-store/ranking' do
    begin
      ranking_request = Request::Ranking.new(params)
      halt_using_if_invalid(ranking_request)

      result = AppleStore.find_by_genre(ranking_request)
      json(result)

    rescue NotFoundException => e
      halt_not_found(e)
    end
  end

  #
  # Search a ranking by specific category (popId)
  # and monitization type (free, grossing or paid)
  #
  get '/apple-store/category' do
    begin
      category_request = Request::Category.new(params)
      halt_using_if_invalid(category_request)

      result = AppleStore.find_by_genre_and_monetization_type_or_ranking_position(category_request)
      json(result)

    rescue NotFoundException => e
      halt_not_found(e)
    end
  end

end