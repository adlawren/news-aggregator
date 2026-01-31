class Feed < ApplicationRecord
  has_many :feed_articles, dependent: :destroy

  def new_article_from_rss_item(item)
    description = item.respond_to?(:content) ? item.content.content : item.description
    title = item.title.respond_to?(:content) ? item.title.content : item.title
    link = item.link.respond_to?(:href) ? item.link.href : item.link

    FeedArticle.new(
      feed_id: self.id,
      description: description,
      published_at: item.date,
      title: title,
      url: link,
    )
  end
end
