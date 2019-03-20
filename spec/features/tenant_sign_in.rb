feature "Signing in" do
    background do
      Tenant.make(first_name: 'Greg', last_name: 'Rouxel Oldrà', email: 'greg@hellodingdong.com', password: 'password')
    end
  
    scenario "Signing in with correct credentials" do
      visit '/tenants/sign_in'
      within("#tenant") do
        fill_in 'Email', with: 'greg@hellodingdong.com'
        fill_in 'Password', with: 'password'
      end
      click_button 'Sign in'
      expect(page).to have_content 'Success'
    end
  
    given(:other_user) { Tenant.make(email: 'other@example.com', password: 'rous') }
  
    scenario "Signing in as another user" do
      visit '/tenants/new'
      within("#tenant") do
        fill_in 'Email', with: other_user.email
        fill_in 'Password', with: other_user.password
      end
      click_button 'Sign in'
      expect(page).to have_content 'Invalid email or password'
    end
  end