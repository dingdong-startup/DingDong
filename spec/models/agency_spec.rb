require 'rails_helper'

RSpec.describe Agency, type: :model do

  # before(:each) do 
  #   @agency = FactoryBot.create(:agency)
	# end

	# 	context "validation" do

  # 		it "has a valid factory" do
  #   		expect(build(:agency)).to be_valid
	# 		end

	# 		it "is valid with valid attributes" do
	# 			expect(@agency).to be_a(Agency)
	# 			expect(@agency).to be_valid
	# 		end
		
	# 		it 'creates an agency' do
	# 			expect(@agency.class).to eq(Agency)
	# 		end

	# 		it { expect(@agency).to allow_value("0658227035").for(:phone) }

	# 		# it { expect(@agency).to_not allow_value("06.22.11.44.33").for(:phone) }
	# 		# it { expect(@agency).to_not allow_value("06 22 11 44 33").for(:phone) }
			
	# 		it { should validate_presence_of(:email) }
	# 		it { expect(@agency).to allow_value("dhh@nonopinionated.com").for(:email) }
	# 		it { expect(@agency).to_not allow_value("base@example").for(:email) }

	# 		it { should validate_presence_of(:password) }
	# 		it { expect(@agency).to allow_value("I am long enough to be a password").for(:password) }
	# 		it { expect(@agency).to_not allow_value("short").for(:password) }

	# 	end
		
	# 	context "associations" do

	# 		it { expect(@agency).to have_many(:agents) }
	# 		it { expect(@agency).to have_many(:properties) }
	# 		it { should have_many(:groups).through(:agency_groups) }

	# 	end

end