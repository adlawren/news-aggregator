require "rails_helper"

RSpec.describe FetchFeedsJob, type: :job do
  include ActiveJob::TestHelper

  let!(:feed) { FactoryBot.create(:feed, url: "https://www.wired.com/feed/tag/ai/latest/rss") }

  describe "#perform" do
    it "creates a record for each feed article" do
      VCR.use_cassette("fetch_feeds_job/fetch_feeds") do
        expect do
          described_class.perform_later
          perform_enqueued_jobs
        end.to change { FeedArticle.count }.from(0).to(10)
      end
    end

    it "saves the expected attributes for each feed article" do
      VCR.use_cassette("fetch_feeds_job/fetch_feeds") do
        described_class.perform_later
        perform_enqueued_jobs

        first_feed_article = FeedArticle.first
        expect(first_feed_article.feed_id).to eq(feed.id)
        expect(first_feed_article.description).to eq("Researchers are drawing on ideas from game theory to improve large language models and make them more correct, efficient, and consistent.")
        expect(first_feed_article.title).to eq("How Game Theory Can Make AI More Reliable")
        expect(first_feed_article.url).to eq("https://www.wired.com/story/game-theory-can-make-ai-more-correct-and-efficient/")
        expect(first_feed_article.published_at).to eq("Sun, 09 Jun 2024 11:00:00.000000000 UTC +00:00".to_datetime)
      end
    end

    it "doesn't recreate existing article records" do
      VCR.use_cassette("fetch_feeds_job/fetch_feeds_twice") do
        described_class.perform_later
        perform_enqueued_jobs

        expect do
          described_class.perform_later
          perform_enqueued_jobs
        end.not_to change { FeedArticle.count }
      end
    end
  end
end
