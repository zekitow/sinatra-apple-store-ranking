require 'json'

class ApplicationController < Sinatra::Base
  helpers ApplicationHelper

  configure :production, :development do
    enable :logging
  end

  #
  # Halt using Unprocessable Entity if request was not valid.
  #
  def halt_using_if_invalid(request)
    unless request.valid?
      halt 422, json({ message: request.reason })
    end
  end

  #
  # Halt using Not Found
  #
  def halt_not_found(exception)
    halt 404, json({ message: exception.reason })
  end
end