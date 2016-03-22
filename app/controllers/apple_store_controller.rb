class AppleStoreController < ApplicationController

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