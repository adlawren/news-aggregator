class FeedCleanupJob < ApplicationJob
  ARTICLE_LIFETIME = 1.month.freeze

  def perform
    current_time = Time.now

    outdated_feed_article_ids = FeedArticle.where("created_at < ?", current_time - ARTICLE_LIFETIME).select(:id)
    FeedArticle.where(id: outdated_feed_article_ids).destroy_all
  end
end
