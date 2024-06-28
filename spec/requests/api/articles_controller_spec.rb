require 'rails_helper'

RSpec.describe Api::ArticlesController, type: :request do
  let!(:feed) { FactoryBot.create(:feed, url: "https://www.wired.com/feed/tag/ai/latest/rss") }

  let!(:feed_article_1) do
    FactoryBot.create(
      :feed_article,
      feed: feed,
      description: "Artists are fleeing Meta’s platforms over fears their work will be used to train AI. Photographer Jingna Zhang’s Cara promises protection, but the influx of new users is taxing her niche portfolio app.",
      title: "Meet the Photographer Behind the Social Media App for Everyone Sick of Meta’s AI",
      url: "https://www.wired.com/story/cara-portfolio-app-artificial-intelligence-jingna-zhang/",
    )
  end
  let!(:feed_article_2) do
    FactoryBot.create(
      :feed_article,
      feed: feed,
      description: "Wyoming’s secretary of state wants the county to reject its candidacy, but the AI bot’s human “meat puppet” says everything is in order.",
      title: "An AI Bot Is (Sort of) Running for Mayor in Wyoming",
      url: "https://www.wired.com/story/ai-bot-running-for-mayor-wyoming/",
    )
  end

  describe "GET /api/articles" do
    it "returns a successful status" do
      get "/api/articles"

      expect(response).to be_ok
    end

    it "returns the available articles", :aggregate_failures do
      get "/api/articles"

      response_json = JSON.parse(response.body)
      expect(response_json.size).to eq(2)
      expect(response_json[0].to_json).to eq(feed_article_1.to_json)
      expect(response_json[1].to_json).to eq(feed_article_2.to_json)
    end
  end

  describe "DELETE /api/articles/:id" do
    it "returns a successful status" do
      delete "/api/articles/#{feed_article_1.id}"

      expect(response).to be_ok
    end

    it "hides the article" do
      expect do
        delete "/api/articles/#{feed_article_1.id}"
      end.to change { feed_article_1.reload.hidden }.from(false).to(true)
    end
  end
end
