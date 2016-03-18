require 'json'

class ApplicationController < Sinatra::Base
  helpers ApplicationHelper

  configure :production, :development do
    enable :logging
  end

  def halt_using_if_invalid(request)
    unless request.valid?
      halt 422, json({ message: request.reason })
    end
  end
end