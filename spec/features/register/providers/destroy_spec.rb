require 'rails_helper'

RSpec.describe "Provider Delete Page", :vcr do
  before do 
    @provider = Provider.create!(name: "Housing Option", street: "123 Street Street", city: "Townsville", state: "UI", zipcode: "11111", phone: "3334445555", fees: "None", schedule: "M-F 9-5", description: "I have housing")
    @user1 = User.create!(username: "jil", password: "dogsname", role: "agent", status: "approved", provider_id: @provider.id, provider: true)

    visit users_login_path

    fill_in "username", with: @user1.username
    fill_in "password", with: @user1.password
    click_button "Login"

    visit new_register_provider_path
  end

  describe "as a logged-in user" do
    it "I should be able to access the delete page for my provider" do
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
      expect(page).to have_button("Delete")
      click_button "Delete", match: :smart

      expect(current_path).to eq(user_path(@user1))
      expect(page).to have_content("Provider deleted successfully")
    end
  end
end