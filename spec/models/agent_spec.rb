require 'rails_helper'

RSpec.describe Agent, type: :model do

  before(:each) do 
    @agent = FactoryBot.create(:agent)
	end

		context "validation" do

  		it "has a valid factory" do
    		expect(build(:agent)).to be_valid
			end

			it "is valid with valid attributes" do
				expect(@agent).to be_a(Agent)
				expect(@agent).to be_valid
			end
		
			it 'creates an agent' do
				expect(@agent.class).to eq(Agent)
			end

		end
		
		context "associations" do

            it { expect(@agent).to belong_to(:agency) }
            it { expect(@agent).to belong_to(:position) }

		end

end