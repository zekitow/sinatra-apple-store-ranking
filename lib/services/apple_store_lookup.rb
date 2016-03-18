class AppleStoreLookup < AppleStoreBase
  base_uri 'https://itunes.apple.com/lookup'

  def find_all(ids)
    self.class.get("?id=#{ids}")
  end

end