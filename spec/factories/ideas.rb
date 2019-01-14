FactoryBot.define do
  factory :idea, class: 'Ideas' do
    title {Faker::App.name}
    description {Faker::Dog.meme_phrase}
  end
end
