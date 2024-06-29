module Api
  class ArticlesController < ApplicationController
    def index
      render json: FeedArticle.where(hidden: false)
    end

    def destroy
      feed_article_id = params.require(:id)

      feed_article = FeedArticle.find(feed_article_id)
      feed_article.update!(hidden: true)

      head :ok
    end
  end
end
