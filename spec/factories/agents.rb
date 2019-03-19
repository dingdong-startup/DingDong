FactoryBot.define do
  factory :agent do
      first_name {"Greg"}
      last_name {"Rouxel Oldrà"}
      cellphone {"0658227035"}
      email {Faker::Internet.email}
      association :position, factory: :position
      association :agency, factory: :agency
  end
end