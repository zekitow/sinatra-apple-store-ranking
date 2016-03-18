class AppleStoreLookup < AppleStoreBase
  base_uri 'https://itunes.apple.com/lookup'

  def find_all(ids)
    results = []
    
    ids.in_groups(3).each do | ids |
      query_result = self.class.get("?id=#{ids.join(',')}")
      results << parse_results(query_result)
    end

    results.flatten
  end


  protected
    def parse_results(result)
      parse_result = []

      JSON.parse(result)['results'].each do | node |
        parse_result << {
                id: node['trackId'],
                icon: node['screenshotUrls'][0],
                description: node['description'],
                publisher_name: node['artistName'],
                app_name: node['trackCensoredName'],
                app_name: node['trackCensoredName'],
                price: node['price'],
                version: node['version'],
                avg_rating: node['averageUserRating']
              }
      end
      parse_result
    end
end