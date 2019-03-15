FactoryBot.define do
    factory :agency do
        name {"Merci Greg"}
        phone {"0658227035"}
        address {"68 rue joseph de maistre Paris 18"}
        email {Faker::Internet.email}
        password {"jesuisunbonpassword"}
    end
end