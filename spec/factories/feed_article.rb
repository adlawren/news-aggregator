FactoryBot.define do
  factory :feed_article do
    description { Faker::Lorem.sentences.join(" ") }
    title { Faker::Lorem.sentence }
    url { Faker::Internet.url }
  end
end
