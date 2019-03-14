FactoryBot.define do
    factory :agent do
      agency { FactoryBot.create(:agency) }  
    end
  end