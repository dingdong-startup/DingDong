FactoryBot.define do
    factory :group do
        sequence(:name) {Faker::Name.name}
    end
  end