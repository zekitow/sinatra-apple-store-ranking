class AppleStore

  # Retrives all rankings from API
  def self.find_by_genre(api_request)
    result          = AppleStoreRanking.new.find_by_genre(api_request)
    aditional_infos = AppleStoreLookup.new.find_all(map_lookup_ids(result))

    create_detailed_lists(result, aditional_infos)
  end

  # Retrives a specific rankings from API
  def self.find_by_genre_and_monetization_type(api_request)

      result          = AppleStoreRanking.new.find_by_genre_and_monetization_type(api_request)
      aditional_infos = AppleStoreLookup.new.find_all(result['adamIds'])

      create_detailed_list(result, aditional_infos)
  end

  private

    #
    # Maps all lookup ids
    # 1. to prevent an extra load at API I decided to make the 
    #    lookup uniq, but using it We have re-ordered the ranking position
    #    please check 'create_detailed_list' below
    #
    #
    def self.map_lookup_ids(result)
      result.map { | object | object['adamIds'] }.flatten.uniq
    end

    #
    # Creates an uniq Ranking
    #
    def self.create_detailed_list(ranking_results, aditional_infos)
      ranking = OpenStruct.new(rank_title: ranking_results['title'], apps: [])

      ranking_results['adamIds'].each do | trackId |
        app = aditional_infos.find{| el | el[:id] == trackId.to_i }

        if app
          app[:position] = ranking.apps.length
          ranking.apps << app
        end
      end

      ranking
    end

    #
    # Creates a ranking array
    #
    def self.create_detailed_lists(ranking_results, aditional_infos)
      elements = []

      ranking_results.each do | ranking_list |
        elements << create_detailed_list(ranking_list, aditional_infos)
      end

      elements.flatten
    end
end