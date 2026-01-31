class FeedArticle < ApplicationRecord
  belongs_to :feed
  validates :url, presence: true, uniqueness: true
end
