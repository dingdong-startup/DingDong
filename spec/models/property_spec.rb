require 'rails_helper'

RSpec.describe Property, type: :model do

  before(:each) do 
    @property = FactoryBot.create(:property)
	end

		context "validation" do

  		it "has a valid factory" do
    		expect(build(:property)).to be_valid
			end

			it "is valid with valid attributes" do
				expect(@property).to be_a(Property)
				expect(@property).to be_valid
			end
		
			it 'creates an agency' do
				expect(@property.class).to eq(Property)
			end

            it { should validate_presence_of(:title) }
            it { expect(@property).to allow_value("un superbe appartement de 40m2").for(:title) }
			it { expect(@property).to_not allow_value("short").for(:title) }
        
            it { should validate_presence_of(:price) }
            it { expect(@property).to allow_value("1800").for(:price) }
            it { expect(@property).to_not allow_value("mille huit cent").for(:price) }
            it { expect(@property).to_not allow_value("1,800").for(:price) }
            it { expect(@property).to_not allow_value("1.800").for(:price) }
            
            it { should validate_presence_of(:surface) }
            it { expect(@property).to allow_value("60").for(:surface) }
            it { expect(@property).to allow_value("60.22").for(:surface) }
            it { expect(@property).to_not allow_value("60,22").for(:surface) }
            it { expect(@property).to_not allow_value("soixante").for(:surface) }
            
            it { should validate_presence_of(:description) }
            it { expect(@property).to allow_value("cet appartement est super bien et super grand, vous allez adorer !!!").for(:description) }
            it { expect(@property).to_not allow_value("short").for(:description) }
            
            it { should validate_presence_of(:floor) }
            it { expect(@property).to allow_value("1").for(:floor) }
            it { expect(@property).to_not allow_value("1er").for(:floor) }
            it { expect(@property).to_not allow_value("un").for(:floor) }
            
            it { should validate_presence_of(:room) }
            it { expect(@property).to allow_value("2").for(:room) }
            it { expect(@property).to_not allow_value("deux").for(:room) }
            it { expect(@property).to_not allow_value("2,5").for(:room) }
            it { expect(@property).to_not allow_value("2.5").for(:room) }

            
            it { should validate_presence_of(:address) }
            it { should validate_presence_of(:available_date) }

		end
		
		context "associations" do

            it { expect(@property).to belong_to(:agency) }
            it { expect(@property).to belong_to(:agent) }
            it { expect(@property).to belong_to(:area) }
            it { expect(@property).to have_many(:visits) }

		end

end