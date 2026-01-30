require "rails_helper"

RSpec.describe FetchFeedsJob, type: :job do
  include ActiveJob::TestHelper

  let!(:feeds) do
    [
      FactoryBot.create(:feed, url: "https://www.wired.com/feed/tag/ai/latest/rss"),
      FactoryBot.create(:feed, url: "https://www.wired.com/feed/category/security/latest/rss"),
    ]
  end

  describe "#perform" do
    around do |example|
      # Freeze time to match the VCR cassettes
      travel_to Time.zone.parse("2024-06-30 12:00:00 UTC") do
        example.run
      end
    end

    it "creates a record for each feed article" do
      VCR.use_cassette("fetch_feeds_job/fetch_feeds") do
        expect do
          described_class.perform_later
          perform_enqueued_jobs
        end.to change { FeedArticle.count }.from(0).to(18)
      end
    end

    it "saves the expected attributes for each feed article", :aggregate_failures do
      VCR.use_cassette("fetch_feeds_job/fetch_feeds") do
        described_class.perform_later
        perform_enqueued_jobs

        first_feed = feeds.first
        first_feed_article = first_feed.feed_articles.first
        expect(first_feed_article.feed_id).to eq(first_feed.id)
        expect(first_feed_article.description).to include("WIRED was able to download stories from publishers like The New York Times and The Atlantic using Poe’s Assistant bot.")
        expect(first_feed_article.title).to eq("Quora’s Chatbot Platform Poe Allows Users to Download Paywalled Articles on Demand")
        expect(first_feed_article.url).to eq("https://www.wired.com/story/quora-chatbot-poe-download-paywalled-articles/")
        expect(first_feed_article.published_at).to eq("Fri, 28 Jun 2024 17:32:19.000000000 UTC +00:00".to_datetime)
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

    context "article description is mislocated" do
      let!(:feeds) { [FactoryBot.create(:feed, url: "https://www.reddit.com/r/MachineLearning/top/.rss")] }

      it "correctly retrieves the description" do
        VCR.use_cassette("fetch_feeds_job/fetch_reddit_feed") do
          described_class.perform_later
          perform_enqueued_jobs

          first_feed_article = FeedArticle.first
          expect(first_feed_article.description).to include("Given the current craze around LLMs and generative models,")
        end
      end
    end

    context "article title is mislocated" do
      let!(:feeds) { [FactoryBot.create(:feed, url: "https://www.reddit.com/r/MachineLearning/top/.rss")] }

      it "correctly retrieves the title" do
        VCR.use_cassette("fetch_feeds_job/fetch_reddit_feed") do
          described_class.perform_later
          perform_enqueued_jobs

          first_feed_article = FeedArticle.first
          expect(first_feed_article.title).to eq("[D] What's the endgame for AI labs that are spending billions on training generative models?")
        end
      end
    end

    context "article URL is mislocated" do
      let!(:feeds) { [FactoryBot.create(:feed, url: "https://www.reddit.com/r/MachineLearning/top/.rss")] }

      it "correctly retrieves the URL" do
        VCR.use_cassette("fetch_feeds_job/fetch_reddit_feed") do
          described_class.perform_later
          perform_enqueued_jobs

          first_feed_article = FeedArticle.first
          expect(first_feed_article.url).to eq("https://www.reddit.com/r/MachineLearning/comments/1dsnk1k/d_whats_the_endgame_for_ai_labs_that_are_spending/")
        end
      end
    end

    context "HTTP error" do
      it "skips to the next feed" do
        VCR.use_cassette("fetch_feeds_job/fetch_feeds_error") do
          expect do
            described_class.perform_later
            perform_enqueued_jobs
          end.to change { FeedArticle.count }.from(0).to(12)
        end
      end
    end
  end
end
