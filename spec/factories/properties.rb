FactoryBot.define do
    factory :property do
        title {"Sublime 3 pièces à Montmartre"}
        price {"1800"}
        surface {"60"}
        description {"cet appartement est super bien et super grand, vous allez adorer !!!"}
        floor {"3"}
        room {"2"}
        available_date {"2019-10-20"}
        address {"68 rue joseph de maistre Paris 18"}
        association :agency, factory: :agency
        association :agent, factory: :agent
        association :area, factory: :area
      
    end
end

