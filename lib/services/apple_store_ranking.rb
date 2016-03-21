class AppleStoreRanking < AppleStoreBase
  base_uri 'https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewTop?country=US&dataOnly=true&l=en&'

  def find_by_genre(request)
    response = self.class.get("genreId=#{request.genre_id}")
    adam_ids = response['topCharts']

    raise NotFoundException.new('genreId not found.') if adam_ids.nil?
    
    adam_ids
  end


  def find_by_genre_and_monetization_type(request)
    response = self.class.get("genreId=#{request.genre_id}&popId=#{request.monetization_type}")
    adam_ids = response['selectedChart']
    
    raise NotFoundException.new('genreId or MonetizationType not found.') if adam_ids.nil?
    
    adam_ids
  end

end