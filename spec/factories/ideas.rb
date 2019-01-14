FactoryBot.define do
  factory :idea do
    association :user, factory: :user
    title {Faker::App.name}
    description {Faker::Dog.meme_phrase}
  end
end
