require "rails_helper"

RSpec.describe FeedCleanupJob, type: :job do
  include ActiveJob::TestHelper

  let!(:feed1) { FactoryBot.create(:feed, url: "https://www.wired.com/feed/tag/ai/latest/rss") }

  let!(:feed_article_1) do
    FactoryBot.create(
      :feed_article,
      description: "Artists are fleeing Meta’s platforms over fears their work will be used to train AI. Photographer Jingna Zhang’s Cara promises protection, but the influx of new users is taxing her niche portfolio app.",
      feed: feed1,
      title: "Meet the Photographer Behind the Social Media App for Everyone Sick of Meta’s AI",
      url: "https://www.wired.com/story/cara-portfolio-app-artificial-intelligence-jingna-zhang/",
    )
  end
  let!(:feed_article_2) do
    FactoryBot.create(
      :feed_article,
      description: "Wyoming’s secretary of state wants the county to reject its candidacy, but the AI bot’s human “meat puppet” says everything is in order.",
      feed: feed1,
      title: "An AI Bot Is (Sort of) Running for Mayor in Wyoming",
      url: "https://www.wired.com/story/ai-bot-running-for-mayor-wyoming/",
    )
  end
  let!(:feed_article_3) do
    FactoryBot.create(
      :feed_article,
      description: "The video-conferencing app is trying to create an \"everything workplace\" app in a crowded market.",
      feed: feed1,
      title: "Zoom Is Going After Google and Microsoft With AI-Driven Docs",
      url: "https://www.wired.com/story/zoom-is-going-after-google-and-microsoft-with-ai-driven-docs/",
      created_at: described_class::ARTICLE_LIFETIME.ago - 1.day,
    )
  end
  let!(:feed_article_4) do
    FactoryBot.create(
      :feed_article,
      description: "Researchers have developed a way to tamperproof open source large language models to prevent them from being coaxed into, say, explaining how to make a bomb.",
      feed: feed1,
      title: "A New Trick Could Block the Misuse of Open Source AI",
      url: "https://www.wired.com/story/center-for-ai-safety-open-source-llm-safeguards/",
      created_at: described_class::ARTICLE_LIFETIME.ago - 1.day,
    )
  end

  describe "#perform" do
    it "deletes outdated feed articles", :aggregate_failures do
      expect do
        described_class.perform_later
        perform_enqueued_jobs
      end.to change { FeedArticle.count }.from(4).to(2)

      expect do
        feed_article_3.reload
      end.to raise_error(ActiveRecord::RecordNotFound)

      expect do
        feed_article_4.reload
      end.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "does not delete non-outdated feed articles", :aggregate_failures do
      described_class.perform_later
      perform_enqueued_jobs

      expect do
        feed_article_1.reload
      end.not_to raise_error

      expect do
        feed_article_2.reload
      end.not_to raise_error
    end
  end
end
