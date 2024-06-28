FactoryBot.define do
  factory :feed do
    url { "#{Faker::Internet.url}/rss" }
  end
end
