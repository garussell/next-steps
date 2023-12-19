require 'rails_helper'

RSpec.describe 'User Registration page', :vcr do
  describe "As a Visitor" do
    before do
      visit new_user_path
    end

    describe "When I visit the user registation page '/users/create'" do
      it "I see a link to sign in if I already have an account." do
        expect(page).to have_content("Do you already have an account? Click here to sign in")
        expect(page).to have_link("Click here to sign in", href: users_login_path)
      end
      
      it "I see text boxes to create a username, choose a password, and to confirm the password" do
        expect(page).to have_content("Choose a username")
        expect(page).to have_field("username")
        expect(page).to have_content("Enter a password")
        expect(page).to have_field("password")
        expect(page).to have_content("Confirm the password")
        expect(page).to have_field("password_verify")
        expect(page).to have_button("Create Account")
      end

      it "HAPPY PATH:  If I fill in a valid username and passwords then I am directed to a Dashboard page '/users/id'" do
        fill_in "username", with: "my_username"
        fill_in "password", with: "my_password"
        fill_in "password_verify", with: "my_password"
        click_button "Create Account"

        expect(page).to have_content("User Dashboard")
      end

      it "SAD PATH:  If I fail to fill in a username , I remain on the same page and see an error message, 'Invalid entries, please try again'" do
        # fill_in "username", with: "my_username"
        fill_in "password", with: "my_password"
        fill_in "password_verify", with: "my_password"
        click_button "Create Account"

        expect(current_path).to eq(new_user_path)
        expect(page).to have_content("Invalid entries, please try again")
      end
      
      it "SAD PATH:  If I fail to fill in a password or password verification, I remain on the same page and see an error message, 'Invalid entries, please try again'" do
        fill_in "username", with: "my_username"
        # fill_in "password", with: "my_password"
        fill_in "password_verify", with: "my_password"
        click_button "Create Account"
  
        expect(current_path).to eq(new_user_path)
        expect(page).to have_content("Invalid entries, please try again")

        fill_in "username", with: "my_username"
        fill_in "password", with: "my_password"
        # fill_in "password_verify", with: "my_password"
        click_button "Create Account"
  
        expect(current_path).to eq(new_user_path)
        expect(page).to have_content("Invalid entries, please try again")
      end
      
      it "SAD PATH:  If my passwords do not match, I remain on the same page and see an error message, 'Invalid entries, please try again'" do
        fill_in "username", with: "my_username"
        fill_in "password", with: "my_password"
        fill_in "password_verify", with: "not_my_password"
        click_button "Create Account"
  
        expect(current_path).to eq(new_user_path)
        expect(page).to have_content("Invalid entries, please try again")
      end

      it "displays a message 'account created with advanced features pending approval' after agent profile is created, and you should not see 'Add My Service'" do
        fill_in "username", with: "my_username"
        fill_in "password", with: "my_password"
        fill_in "password_verify", with: "my_password"
        click_button "Create Account"

        expect(page).to have_content("Account created with advanced features pending approval")
        expect(page).to have_content("User Dashboard")
        expect(page).to_not have_content("Add My Service")
      end
    end
  end
end