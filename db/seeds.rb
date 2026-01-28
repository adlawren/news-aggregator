# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

[
  # "https://feeds.a.dj.com/rss/RSSMarketsMain.xml", # WSJ Markets
  # "https://feeds.a.dj.com/rss/RSSWSJD.xml", # WSJ Tech News
  # "https://feeds.a.dj.com/rss/RSSWorldNews.xml", # WSJ World News
  # "https://feeds.a.dj.com/rss/WSJcomUSBusiness.xml", # WSJ US Business News
  "https://hnrss.org/newest?points=600", # Hacker News, top posts over 600 points
  # "https://www.cbc.ca/webfeed/rss/rss-canada", # CBC, Canada
  # "https://www.cbc.ca/webfeed/rss/rss-canada-calgary", # CBC, Calgary
  # "https://www.economist.com/briefing/rss.xml", # The Economist, Briefing
  "https://www.economist.com/business/rss.xml", # The Economist, Business
  "https://www.economist.com/finance-and-economics/rss.xml", # The Economist, Finance and Economics
  # "https://www.economist.com/international/rss.xml", # The Economist, International
  "https://www.economist.com/science-and-technology/rss.xml", # The Economist, Science and Technology
  # "https://www.economist.com/the-world-this-week/rss.xml", # The Economist, The World This Week
  # "https://www.economist.com/united-states/rss.xml", # The Economist, The United States
  "https://www.reddit.com/r/MachineLearning/top/.rss", # r/MachineLearning
  # "https://www.wired.com/feed/category/security/latest/rss", # Wired Security
  # "https://www.wired.com/feed/tag/ai/latest/rss", # Wired AI
].each do |feed_url|
  Feed.find_or_create_by!(url: feed_url)
end
