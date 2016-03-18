class AppleStoreRanking < AppleStoreBase
  base_uri 'https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewTop?country=US&dataOnly=true&l=en&'

  def find_by_genre(request)
    response = self.class.get("genreId=#{request[:genre_id]}")
    response['topCharts']
  end


  def find_by_genre_and_monetization_type(request)
    response = self.class.get("genreId=#{request[:genre_id]}&popId=#{request[:monetization_type]}")
    response['selectedChart']
  end

end