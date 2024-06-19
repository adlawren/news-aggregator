class FetchFeedsJob < ApplicationJob
  def perform
    Feed.all.each do |feed|
      parsed_feed = RSS::Parser.parse(feed.url)

      parsed_feed.items.map do |item|
        next if FeedArticle.exists?(url: item.link)

        FeedArticle.new(
          description: item.description,
          published_at: item.date,
          title: item.title,
          url: item.link,
        ).save!
      end
    end
  end
end
