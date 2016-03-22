class AppleStore

  #
  # Retrives a specific rankings from AppleStore API along
  # with their metadata and top publishers
  #
  def self.find_by_genre_and_monetization_type_or_ranking_position(category_request)

    elements = self.find_rankings_with_meta_data(category_request)

    top_publishers = sort_by_top_publishers(elements)

    if category_request.rank_position.present?
      filter_by_ranking_position(category_request.rank_position, elements)
    end

    OpenStruct.new(top_publishers: top_publishers, ranking: elements)
  end

  protected

    #
    # Retrives and create a ranking with all metadata
    #
    def self.find_rankings_with_meta_data(category_request)
      view_top_response = AppleStoreViewTopAPI.new.find_by_genre_and_monetization_type(category_request)
      lookup_response   = AppleStoreLookupAPI.new.find_all(view_top_response['adamIds'])

      aggregate_responses(view_top_response, lookup_response)
    end

  private

    #
    # Filter an specify app by ranking position
    #
    def self.filter_by_ranking_position(rank_position, elements)
      app = elements.apps.find { |e| e[:position] == rank_position.to_i } 
      raise NotFoundException.new('Ranking position not found.') unless app
      elements.apps = [app]
    end

    #
    # Sort the top publishers by total of apps
    #
    def self.sort_by_top_publishers(elements)

      top_publishers = []
      top_publishers = elements.apps.group_by { |w| w[:publisher] }

      top_publishers = top_publishers.map  do |k, v|
        { publisher_id: v[0][:publisher_id], publisher_name: k, number_of_apps: v.size, app_names: v.map {|k,v| k[:app_name] } }
      end

      top_publishers = top_publishers.sort { |a, b| b[:number_of_apps] <=> a[:number_of_apps] }

      top_publishers.each_with_index do | publisher, index |
        publisher[:position] = (index + 1)
      end
    end

    #
    # Agregates the API ids and metadata information
    #
    def self.aggregate_responses(ranking_results, aditional_infos)

      ranking = OpenStruct.new(rank_title: ranking_results['title'], apps: [])

      ranking_results['adamIds'].each do | trackId |
        app = aditional_infos.find{| el | el[:id] == trackId.to_i }

        if app
          app[:position] = (ranking.apps.length + 1)
          ranking.apps << app
        end
      end

      ranking
    end

end