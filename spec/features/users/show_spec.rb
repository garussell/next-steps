require 'rails_helper'

RSpec.describe 'User Dashboard page', :vcr do
  describe "As a Visitor" do
    it "I should not be able to access any user dashboard '/users/:id' and should instead be redirected to the login page.  And, I should see an error message indicating that I need to log in first" do
      registered_user = User.create!(username: "my_username", password: "my_password")
      visit user_path(registered_user.id)

      expect(current_path).to eq users_login_path
      expect(page).to have_content("You must be logged in to access this page.")
    end
  end

  describe "As a logged in user" do
    before do
      @user = User.create!(username: "my_username", password: "my_password")
      visit users_login_path
      fill_in "Username", with: @user.username
      fill_in "Password", with: @user.password
      click_button "Login"
    end

    it "when I visit my dashboard '/users/:id', I should see my username, a link to change my password, and a 'Favorite Providers' section." do
      expect(current_path).to eq user_path(@user.id)
      expect(page).to have_content("#{@user.username}")
      expect(page).to have_content("Change password")
    end

    it "When I visit my dashboard '/users/:id', I should also se  a link to delete my account" do
      expect(page).to have_button("Delete my account")
    end

    context "Password change:  When I click the change password link, " do
      
      before do
        visit edit_user_path(@user.id)
      end

      it "I see a form to enter a new password, confirm my password, and a button to update my password." do       
        
        expect(current_path).to eq edit_user_path(@user.id)
        expect(page).to have_field("Enter new password")
        expect(page).to have_field("Confirm new password")
        expect(page).to have_button("Update password")
      end

      it "HAPPY PATH:  If I enter matching passwords, I am redirected to my Dashboard and see a message that my password has been updated." do
        fill_in "Enter new password", with: "new_password"
        fill_in "Confirm new password", with: "new_password"
        click_button "Update password"

        expect(current_path).to eq user_path(@user.id)
        expect(page).to have_content("Your password has been updated successfully")
      end

      it "SAD PATH: If I enter non-matching passwords, I remain on the same page and see a message that my credentials are invalid." do
        fill_in "Enter new password", with: "new_password"
        fill_in "Confirm new password", with: "wrong_password"
        click_button "Update password"

        expect(current_path).to eq edit_user_path(@user.id)
        expect(page).to have_content("Invalid credentials. Please try again")
      end
    end

    context "Account deletion" do

      before do
        click_button "Delete my account"
      end

      it "When I click the link to delete my account, I am redirected to the Welcome page '/' and I see a message that my account has been deleted." do
        expect(current_path).to eq root_path
        expect(page).to have_content("Your account has been successfully deleted.")
      end

      it "After deleting my account, I no longer have access to my Dashboard /users/:id'." do
        visit user_path(@user.id)

        expect(current_path).to eq users_login_path
        expect(page).to have_content("You must be logged in to access this page.")
      end

      it "EDGE CASE:  Visitors should not have access to this page" do
        visit user_path(@user.id, method: :delete)

        expect(current_path).to eq users_login_path
        expect(page).to have_content("You must be logged in to access this page.")
      end

      it "EDGE CASE:  Visitors should not have access delete other accounts" do
        visit user_path(99999999999, method: :delete)

        expect(current_path).to eq users_login_path
        expect(page).to have_content("You must be logged in to access this page.")
      end
    end
  end

  # User vs Agent Show Page
  it "displays a link to 'Add My Service' only if the user is an agent && approved" do
    user = User.create!(username: "pal", password: "password", role: "agent", status: "approved")

    visit users_login_path

    fill_in "username", with: user.username
    fill_in "password", with: user.password
    click_button "Login"
    save_and_open_page
    expect(page).to have_current_path(user_path(user))
    expect(page).to have_content("Add Service")
  end

  it "displays 'My Favorite Providers' if the current user is a 'user' and not 'agent'" do
    user = User.create!(username: "pal", password: "password", role: "agent", status: "approved")
    user.favorites.create!(category: "Medical Care", name: "NextCare Urgent Care", description: "Provides urgent care services", address: "4590 W 121st Ave, Broomfield, CO 80020", website: "http://nextcare.com", phone: "(888) 381-4858", fees: "Medical Care Fees, call for current fees.", schedule: "Monday - Friday, 8 a.m. - 8 p.m.; Saturday, Sunday, 9 a.m. - 4 p.m.")
    
    favorite = user.favorites.create!(category: "Medical Care", name: "NextCare Urgent Care", description: "Provides urgent care services", address: "636 S 20th St Boulder, CO 80603", website: "http://nextcare.com", phone: "(888) 381-4858", fees: "Medical Care Fees, call for current fees.", schedule: "Monday - Friday, 8 a.m. - 8 p.m.; Saturday, Sunday, 9 a.m. - 4 p.m.")
   
    visit users_login_path

    fill_in "username", with: user.username
    fill_in "password", with: user.password
    click_button "Login"

    expect(page).to have_current_path(user_path(user))
    expect(page).to have_content("My Favorite Providers")
    expect(page).to have_content("Medical Care")
    expect(page).to have_content("NextCare Urgent Care")
    expect(page).to have_content("Provides urgent care services")
    expect(page).to have_content("4590 W 121st Ave, Broomfield, CO 80020")
    expect(page).to have_content("http://nextcare.com")
    expect(page).to have_content("(888) 381-4858")
    expect(page).to have_content("Medical Care Fees, call for current fees.")
    expect(page).to have_content("Monday - Friday, 8 a.m. - 8 p.m.; Saturday, Sunday, 9 a.m. - 4 p.m.")
    expect(page).to have_button("Remove")
  end
end