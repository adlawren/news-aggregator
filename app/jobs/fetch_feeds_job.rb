class FetchFeedsJob < ApplicationJob
  def perform
    Feed.in_batches.each do |feeds|
      feeds.each do |feed|
        parsed_feed = RSS::Parser.parse(feed.url)

        parsed_feed.items.map do |item|
          feed_article_description = item.respond_to?(:content) ? item.content.content : item.description
          feed_article_title = item.title.respond_to?(:content) ? item.title.content : item.title
          feed_article_link = item.link.respond_to?(:href) ? item.link.href : item.link

          next if item.date && item.date < 7.days.ago # Skip articles more than 7 days old
          next if FeedArticle.exists?(url: feed_article_link)

          feed.feed_articles.create!(
            description: feed_article_description,
            published_at: item.date,
            title: feed_article_title,
            url: feed_article_link,
          ).save!
        end
      rescue OpenURI::HTTPError => e
        next # Skip to the next feed
      end
    end
  end
end
