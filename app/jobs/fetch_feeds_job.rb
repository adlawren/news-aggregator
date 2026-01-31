class FetchFeedsJob < ApplicationJob
  def perform
    Feed.in_batches.each do |feeds|
      feeds.each do |feed|
        parsed_feed = RSS::Parser.parse(feed.url)

        parsed_feed.items.map do |item|
          next if item.date && item.date < 7.days.ago # Skip articles more than 7 days old

          feed_article = feed.new_article_from_rss_item(item)
          feed_article.save!
        rescue ActiveRecord::RecordInvalid => e
          unless e.record.errors[:url].include?("has already been taken") # Skip duplicate URL errors
            Rails.logger.error("Failed to save article for feed #{feed.url}: #{e.message}")
          end

          next
        end
      rescue OpenURI::HTTPError => e
        next # Skip to the next feed
      end
    end
  end
end
