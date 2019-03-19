require 'rails_helper'

RSpec.describe Group, type: :model do

  before(:each) do 
    @group = FactoryBot.create(:group)
	end

		context "validation" do

  		it "has a valid factory" do
    		expect(build(:group)).to be_valid
			end

			it "is valid with valid attributes" do
				expect(@group).to be_a(Group)
				expect(@group).to be_valid
			end
		
			it 'creates an agency' do
				expect(@group.class).to eq(Group)
			end
		end

		describe 'name' do
			it { should validate_presence_of(:name) }
		end
		
		context "associations" do
	
			describe "agency have many groups though agency_groups" do
				it { should have_many(:agencies).through(:agency_groups) }
			end

		end

end