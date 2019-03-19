require 'rails_helper'

RSpec.describe Area, type: :model do

    before(:each) do 
        @area = FactoryBot.create(:area)
    end

    context "associations" do
    
        it { expect(@area).to have_many(:properties) }
        
	end

end