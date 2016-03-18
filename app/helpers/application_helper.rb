module ApplicationHelper

  #
  # Maps all lookup ids
  #
  def map_lookup_ids(result)
    result.map { | object | object['adamIds'] }.flatten.uniq
  end

  #
  # Creates an uniq Ranking
  #
  def aggregate_elements(ranking_results, aditional_infos)
    element = OpenStruct.new(rank_title: ranking_results['title'], apps: [])

    ranking_results['adamIds'].each do | trackId |
      element.apps << aditional_infos.find{| el | el[:id] == trackId.to_i }
    end

    element
  end

  #
  # Creates a ranking array
  #
  def aggregate_element_lists(ranking_results, aditional_infos)
    elements = []

    ranking_results.each do | ranking_list |
      elements << aggregate_elements(ranking_list, aditional_infos)
    end

    elements.flatten
  end
end