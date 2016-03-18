module ApplicationHelper

  def map_lookup_ids(result)
    result.map {| object | object['adamIds']}.flatten.uniq
  end

  def aggregate_elements(ranking_results, aditional_infos)
    elements = []

    ranking_results['adamIds'].each do | trackId |
      elements << aditional_infos.find{| el | el[:id] == trackId.to_i }
    end

    elements
  end

  def aggregate_element_lists(ranking_results, aditional_infos)
    elements = []

    ranking_results.each do | ranking_list |
      elements << aggregate_elements(ranking_list, aditional_infos)
    end

    elements
  end
end