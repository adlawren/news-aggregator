class Feed < ApplicationRecord
  has_many :feed_articles, dependent: :destroy
end
