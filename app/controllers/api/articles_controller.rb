module Api
  class ArticlesController < ApplicationController
    protect_from_forgery with: :null_session # These are REST API endpoints

    def index
      feed_id = params["feed_id"]

      feed_articles = FeedArticle.where(hidden: false)
      feed_articles = feed_articles.where(feed_id: feed_id) if feed_id.present?

      render json: feed_articles
    end

    def destroy
      feed_article_id = params.require(:id)

      feed_article = FeedArticle.find(feed_article_id)
      feed_article.update!(hidden: true)

      head :ok
    end
  end
end
