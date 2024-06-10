class CreateFeedArticles < ActiveRecord::Migration[7.1]
  def change
    create_table :feed_articles do |t|
      t.string :title
      t.text :description
      t.string :url

      t.timestamps
    end
  end
end
