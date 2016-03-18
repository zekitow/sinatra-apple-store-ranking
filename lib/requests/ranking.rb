module Request

  class Ranking
    attr_reader :genre_id

    def initialize(params)
      @genre_id = params[:genreId]
    end

    def valid?
      not @genre_id.blank?
    end

    def reason
      ['genreId is required.'] if @genre_id.blank?
    end
  end

end