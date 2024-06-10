class FetchFeedsJob < ApplicationJob
  def perform
    Feed.all.each do |feed|
      parsed_feed = RSS::Parser.parse(feed.url)

      parsed_feed.items.map do |item|
        FeedArticle.new(
          description: item.description,
          title: item.title,
          url: item.link,
        ).save!
      end
    end
  end
end
