module Api
  class ArticlesController < ApplicationController
    def index
      render json: FeedArticle.all
    end
  end
end
