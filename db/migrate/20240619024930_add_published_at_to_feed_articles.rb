class AddPublishedAtToFeedArticles < ActiveRecord::Migration[7.1]
  def change
    add_column :feed_articles, :published_at, :datetime
  end
end
