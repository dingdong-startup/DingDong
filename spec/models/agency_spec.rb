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

			describe 'name' do
				it { should validate_presence_of(:name) }
			end

			describe 'phone' do
				it { should validate_presence_of(:phone) }
			end

			describe 'email' do
				it { should validate_presence_of(:email) }
			end

			describe 'address' do
				it { should validate_presence_of(:address) }
			end

		end
		
		context "associations" do

			describe "agency have many agents" do
				it { expect(@agency).to have_many(:agents) }
			end

			describe "agency have many properties" do
				it { expect(@agency).to have_many(:properties) }
			end
	
			describe "agency have many groups though agency_groups" do
				it { should have_many(:groups).through(:agency_groups) }
			end

		end

end