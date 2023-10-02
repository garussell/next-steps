require 'rails_helper'

RSpec.describe "Provider Edit Page", :vcr do
  describe "as a logged-in user" do
    it "I should be able to access the edit page for my provider" do
      provider = Provider.create!(name: "Housing Option", street: "123 Street Street", city: "Townsville", state: "UI", zipcode: "11111", phone: "3334445555", fees: "None", schedule: "M-F 9-5", description: "I have housing")
      user = User.create!(username: "my_username", password: "my_password", provider_id: provider.id, provider: true)
      
      visit edit_register_provider_path(provider.id)
      
      expect(current_path).to eq(users_login_path)
      expect(page).to have_content("You must be logged in to access this page.")
    end
  end

  describe "as a logged in user" do
    it "I should not be able to access the edit page for another user" do
      user1 = User.create!(username: "my_username1", password: "my_password1")
      user2 = User.create!(username: "my_username2", password: "my_password2")
      visit users_login_path
      fill_in "Username", with: user1.username
      fill_in "Password", with: "my_password1"
      click_button "Login"
  
      provider = Provider.create!(name: "Housing Option", street: "123 Street Street", city: "Townsville", state: "UI", zipcode: "11111", phone: "3334445555", fees: "None", schedule: "M-F 9-5", description: "I have housing")
      visit edit_register_provider_path(provider.id)
      expect(page).to have_content("Update Your Business Profile")
    end
  end  
end