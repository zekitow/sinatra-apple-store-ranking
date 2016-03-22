class AppleStoreLookupAPI < AppleStoreBase
  base_uri 'https://itunes.apple.com/lookup'

  #
  # Finds aditional infos, for the given adamIds, using Lookup API
  #
  def find_all(ids)
    response = self.class.get("?id=#{ids.join(',')}")
    parse_results(response)
  end

  protected

    #
    # Transcribes the relevant information into Hash
    #
    def parse_results(result)
      parse_result = []

      JSON.parse(result)['results'].each do | node |
        parse_result << {
                id: node['trackId'],
                publisher_id: node['artistId'],
                publisher_name: node['artistName'],
                icon: node['artworkUrl60'],
                description: node['description'],
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