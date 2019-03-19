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

			describe 'first_name' do
				it { should validate_presence_of(:first_name) }
            end
            
            describe 'last_name' do
				it { should validate_presence_of(:last_name) }
			end

			describe 'cellphone' do
				it { should validate_presence_of(:cellphone) }
			end

			describe 'email' do
				it { should validate_presence_of(:email) }
			end

		end
		
		context "associations" do

            it { expect(@agent).to belong_to(:agency) }

            it { expect(@agent).to belong_to(:position) }

		end

end