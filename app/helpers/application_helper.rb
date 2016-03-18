module ApplicationHelper

  def map_lookup_ids(result)

    if result.is_a?(Array)
      result.map {| object | object['adamIds']}.flatten.uniq
    else
      result['adamIds']
    end
  end


  def aggregate(ranking_results, aditional_infos)
    elements = []

    if ranking_results.is_a?(Array)

      ranking_results.each do | ranking_list |
        ranking_list['adamIds'].each do | trackId |
          elements << aditional_infos.find{| el | el[:id] == trackId.to_i }
        end
      end
      
    else
      
      ranking_results['adamIds'].each do | trackId |
        elements << aditional_infos.find{| el | el[:id] == trackId.to_i }
      end

    end

    elements
  end
end