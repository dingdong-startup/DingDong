require 'rails_helper'

RSpec.describe Agency, type: :model do

  before(:each) do 
    @agency = FactoryBot.create(:agency)
	end

		context "validation" do

  		it "has a valid factory" do
    		expect(build(:agency)).to be_valid
			end

			it "is valid with valid attributes" do
				expect(@agency).to be_a(Agency)
				expect(@agency).to be_valid
			end
		
			it 'creates an agency' do
				expect(@agency.class).to eq(Agency)
			end
			
			it { should validate_presence_of(:email) }

		end
		
		context "associations" do

			it { expect(@agency).to have_many(:agents) }
			it { expect(@agency).to have_many(:properties) }
			it { should have_many(:groups).through(:agency_groups) }

		end

end