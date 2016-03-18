module ApplicationHelper

  def map_lookup_ids(result)
    return result['topCharts'].map {| object | object['adamIds']}.flatten.uniq
  end

end