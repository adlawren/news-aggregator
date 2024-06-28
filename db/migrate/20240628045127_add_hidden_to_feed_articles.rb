class AddHiddenToFeedArticles < ActiveRecord::Migration[7.1]
  def change
    add_column :feed_articles, :hidden, :boolean, default: false
  end
end
