class AppleStoreRanking < AppleStoreBase
  base_uri 'https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewTop?country=US&dataOnly=true&l=en&'

  def find_all(categoryId = nil)
    response = self.class.get("genreId=6001&popId=#{categoryId}")

    if categoryId.nil?
      response['topCharts']
    else
      response['selectedChart']
    end
  end

end