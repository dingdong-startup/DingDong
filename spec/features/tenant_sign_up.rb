require 'rails_helper'

describe "the signup process", type: :feature do
    
    before :each do
        Tenant.create(first_name: 'Greg', last_name: 'Rouxel Oldrà', email: 'greg@hellodingdong.com', password: 'password')
    end

    it "signs me in" do
        visit '/tenants/sign_up'
        within("#tenant") do
   
            fill_in 'Prénom', with: 'Greg'
            fill_in 'Nom', with: 'Rouxel Oldrà'
            fill_in 'Email', with: 'greg@hellodingdong.com'
            fill_in 'Password', with: 'password'
            fill_in 'Password', with: 'password'
        
        end
    
        click_button 'Sign in'
            expect(page).to have_content 'Success'
    
        end
end