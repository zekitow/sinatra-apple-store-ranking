class AppleStoreController < ApplicationController

  #
  # Search all ranking (free, grossing and paid)
  #
  get '/apple-store/by-ranking' do
    api_request     = by_ranking_request(params)
    result          = AppleStoreRanking.new.find_by_genre(api_request)
    aditional_infos = AppleStoreLookup.new.find_all(map_lookup_ids(result))

    json(aggregate_element_lists(result, aditional_infos))
  end

  #
  # Search a ranking by specific category (free, grossing or paid)
  #
  get '/apple-store/category' do
    api_request     = by_category_request(params)

    result          = AppleStoreRanking.new.find_by_genre_and_monetization_type(api_request)
    aditional_infos = AppleStoreLookup.new.find_all(result['adamIds'])

    json(aggregate_elements(result, aditional_infos))
  end


  private
    def by_ranking_request(params)
      unless params[:genreId].present?
        halt 422, json({ message: 'genreId is required.' })
      end

      { genre_id: params[:genreId] }
    end

    def by_category_request(params)
      unless params[:genreId].present? or params[:monetization_type].present?
        halt 422, json({ message: 'Missing parameters, provide genreId and monetizationType.' })
      end

      {
        genre_id: params[:genreId],
        monetization_type: params[:monetizationType]
      }
    end
end