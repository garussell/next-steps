require 'rails_helper'

RSpec.describe 'User Delete function' do
  describe "As a Visitor" do
    it "I should not be able to delete an existing user" do
      user = User.create!(username: "my_username", password: "my_password", provider_id: nil)
      visit user_path(user.id, method: :delete)
      
      expect(current_path).to eq users_login_path
      expect(page).to have_content("You must be logged in to access this page.")
    end
    
    it "I should not be able to delete a user that does not exist" do
      visit user_path(9999999, method: :delete)

      expect(current_path).to eq users_login_path
      expect(page).to have_content("You must be logged in to access this page.")
    end
  end
end