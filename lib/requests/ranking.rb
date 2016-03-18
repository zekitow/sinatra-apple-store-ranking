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
      messages = []
      messages << 'genreId is required.' if @genre_id.blank?
      messages
    end
  end

end