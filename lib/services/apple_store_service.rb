require 'httparty'

class AppleStoreService

  def self.find_all
    return HTTParty.get("#{base_url}genreId=6001&popId=30", headers: headers)
  end

  private 
    def self.base_url
      'https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewTop?country=US&dataOnly=true&l=en&'
    end

    def self.headers
      {
        'Accept-Encoding' => 'gzip, deflate, sdch',
        'Accept-Language' => 'en-US,en;q=0.8,lv;q=0.6',
        'User-Agent' => 'iTunes/11.1.1 (Windows; Microsoft Windows 7 x64 Ultimate Edition Service Pack 1 (Build 7601)) AppleWebKit/536.30.1',
        'Accept' => 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
        'Cache-Control' => 'max-age=0',
        'X-Apple-Store-Front' => '143441-1,17'
      }
    end
end