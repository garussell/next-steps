require 'rails_helper'

RSpec.describe 'User Provider Update page', :vcr do
  before do
    @provider = Provider.create!(name: "Housing Option", street: "123 Street Street", city: "Townsville", state: "UI", zipcode: "11111", phone: "3334445555", fees: "None", schedule: "M-F 9-5", description: "I have housing")
    @user = User.create!(username: "new_username", password: "my_password", provider_id: @provider.id, provider: true)
    visit users_login_path

    fill_in "Username", with: @user.username
    fill_in "Password", with: "my_password"
    click_button "Login"
  end

  describe "As a Visitor" do
    it "updates a user's provider information" do
      visit edit_register_provider_path(@provider)

      expect(page).to have_content("Update Your Business Profile")
      expect(page).to have_content("Organization name")
      expect(page).to have_field("name")
      expect(page).to have_content("Street")
      expect(page).to have_field("street")
      expect(page).to have_content("City")
      expect(page).to have_field("city")
      expect(page).to have_content("State")
      expect(page).to have_field("state")
      expect(page).to have_content("Zipcode")
      expect(page).to have_field("zipcode")
      expect(page).to have_content("Contact phone")
      expect(page).to have_field("phone")
      expect(page).to have_content("Description of services")
      expect(page).to have_field("description")
      expect(page).to have_content("Fees")
      expect(page).to have_field("fees")
      expect(page).to have_content("Schedule")
      expect(page).to have_field("schedule")
      expect(page).to have_button("Submit")
    end

    it "I can fill in the form and submit it" do
      visit edit_register_provider_path(@provider)

      fill_in "name", with: "Housing Option"
      fill_in "street", with: "123 Street Street"
      fill_in "city", with: "Townsville"
      fill_in "state", with: "UI"
      fill_in "zipcode", with: "11111"
      fill_in "phone", with: "3334445555"
      fill_in "fees", with: "None"
      fill_in "schedule", with: "M-F 9-5"
      fill_in "description", with: "I have housing"
      click_button "Submit"

      expect(current_path).to eq(user_path(@user))
      expect(page).to have_content("Provider successfully updated")
    end

    it "sad path: I must fill in all values to submit" do
      visit edit_register_provider_path(@provider)

      fill_in "name", with: "Housing Option"

      click_button "Submit"

      expect(page).to have_content("Invalid entries, please try again")

    end
  end
end