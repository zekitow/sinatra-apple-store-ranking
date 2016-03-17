class PostsController < ApplicationController
  get '/', provides: :json do
    json Post.all
  end
end