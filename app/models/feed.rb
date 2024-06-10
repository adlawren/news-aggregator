class Feed
  include ActiveModel::Model

  def self.all
    feeds_config = Rails.application.config_for(:feeds)

    feeds_config[:urls].map do |feed_url|
      Feed.new(url: feed_url)
    end
  end

  attr_accessor :url
end
