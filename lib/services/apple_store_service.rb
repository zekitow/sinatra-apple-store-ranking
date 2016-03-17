require 'httparty'

class AppleStoreService
  include HTTParty
  base_uri 'https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewTop?country=US&dataOnly=true&l=en&'
  headers self.headers

  def find_all
    self.class.get('genreId=6001&popId=30')
  end

  private 

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