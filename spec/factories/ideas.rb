FactoryBot.define do
  factory :idea do
    title {Faker::App.name}
    description {Faker::Dog.meme_phrase}
  end
end
