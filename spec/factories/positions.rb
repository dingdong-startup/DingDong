FactoryBot.define do
    factory :position do
        sequence(:title) {Faker::Name.name}
    end
  end