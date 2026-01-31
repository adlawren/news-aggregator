class FetchFeedsJob < ApplicationJob
  def perform
    Feed.in_batches.each do |feeds|
      feeds.each do |feed|
        parsed_feed = RSS::Parser.parse(feed.url)

        parsed_feed.items.map do |item|
          feed_article = feed.new_article_from_rss_item(item)

          next if item.date && item.date < 7.days.ago # Skip articles more than 7 days old
          next if FeedArticle.exists?(url: feed_article.url)

          feed_article.save!
        end
      rescue OpenURI::HTTPError => e
        next # Skip to the next feed
      end
    end
  end
end
