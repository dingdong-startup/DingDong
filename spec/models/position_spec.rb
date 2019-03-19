require 'rails_helper'

RSpec.describe Position, type: :model do

  before(:each) do 
    @position = FactoryBot.create(:position)
	end

        context "validation" do
            
      it "has a valid factory" do
    		expect(build(:position)).to be_valid
		  end

			it "is valid with valid attributes" do
				expect(@position).to be_a(Position)
				expect(@position).to be_valid
			end
		
			it 'creates a Position' do
				expect(@position.class).to eq(Position)
			end

			describe 'title' do
				it { should validate_presence_of(:title) }
      end
            

		end
		
		context "associations" do

            it { expect(@position).to have_many(:agents) }


		end

end