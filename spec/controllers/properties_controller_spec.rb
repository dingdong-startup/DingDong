require 'rails_helper'

RSpec.describe PropertiesController, type: :controller do

    describe "GET index" do
        it "assigns @properties" do
          # création d'une instance
          property = FactoryBot.create(:property)
    
          # on va sur index
          get :index
      
          # @properties doit être une array qui contient property
          expect(assigns(:properties)).to eq([property])
        end
      
      end

end