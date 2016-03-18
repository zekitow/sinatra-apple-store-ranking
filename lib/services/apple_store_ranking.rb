class AppleStoreRanking < AppleStoreBase
  base_uri 'https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewTop?country=US&dataOnly=true&l=en&'

  def find_all(categoryId = nil)
    self.class.get("genreId=6001&popId=#{categoryId}")
  end

end