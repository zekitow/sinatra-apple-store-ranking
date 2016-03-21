class NotFoundException < Exception
  attr_reader :reason

  def initialize(reason)
    @reason = reason
  end

end