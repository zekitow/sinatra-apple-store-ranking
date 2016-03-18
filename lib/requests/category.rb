module Request

  class Category
    attr_reader :genre_id, :monetization_type

    def initialize(params)
      @genre_id = params[:genreId]
      @monetization_type = params[:monetizationType]
    end

    def valid?
      not (@genre_id.blank? or @monetization_type.blank?)
    end

    def reason
      messages = []
      messages << 'genreId is required.' if @genre_id.blank?
      messages << 'monetizationType is required.' if @monetization_type.blank?
      messages
    end
  end
end