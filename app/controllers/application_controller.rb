require 'json'

class ApplicationController < Sinatra::Base
  # helpers ApplicationHelper

  configure :production, :development do
    enable :logging
  end
end