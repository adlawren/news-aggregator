class AddUrlIndexToFeedArticles < ActiveRecord::Migration[7.1]
  def change
    add_index :feed_articles, :url, unique: true
  end
end
