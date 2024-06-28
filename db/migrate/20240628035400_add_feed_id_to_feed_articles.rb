class AddFeedIdToFeedArticles < ActiveRecord::Migration[7.1]
  def change
    add_column :feed_articles, :feed_id, :bigint, null: false
  end
end
