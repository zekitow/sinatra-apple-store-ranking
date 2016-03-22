class AppleStoreLookupAPI < AppleStoreBase
  base_uri 'https://itunes.apple.com/lookup'

  # Find all aditional info using the Lookup API
  def find_all(ids)
    response = self.class.get("?id=#{ids.join(',')}")
    parse_results(response)
  end

  protected

    # Filter by the revelant information
    def parse_results(result)
      parse_result = []

      JSON.parse(result)['results'].each do | node |
        parse_result << {
                id: node['trackId'],
                publisher: node['artistName'],
                publisher_id: node['artistId'],
                icon: node['artworkUrl60'],
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