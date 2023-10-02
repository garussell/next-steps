require 'rails_helper'

RSpec.describe "Provider Registration Page", :vcr do
  describe "as a visitor" do
    before do 
      @user1 = User.create!(username: "jil", password: "dogsname", role: "user", status: "approved")

      visit users_login_path

      fill_in "username", with: @user1.username
      fill_in "password", with: @user1.password
      click_button "Login"

      visit new_register_provider_path
    end

    describe "when I visit the provider registration page '/register/providers#new" do
      it "I see text boxes to create a orgization name (name), phone, email, description of services, and button to submit" do
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

        expect(current_path).to eq(user_path(@user1))
        expect(page).to have_content("Provider successfully created")
      end

      # Validate params on the front-end
      it "SAD PATH: If I do not fill in my organization name it errors" do
        # fill_in "name", with: "Housing Option"
        fill_in "street", with: "123 Street Street"
        fill_in "city", with: "Townsville"
        fill_in "state", with: "UI"
        fill_in "zipcode", with: "11111"
        fill_in "phone", with: "3334445555"
        fill_in "fees", with: "None"
        fill_in "schedule", with: "M-F 9-5"
        fill_in "description", with: "I have housing"

        click_button "Submit"
  
        expect(current_path).to eq(new_register_provider_path)
        expect(page).to have_content("Invalid entries, please try again")
      end

      it "SAD PATH: If I do not fill in my street it errors" do
        fill_in "name", with: "Housing Option"
        # fill_in "street", with: "123 Street Street"
        fill_in "city", with: "Townsville"
        fill_in "state", with: "UI"
        fill_in "zipcode", with: "11111"
        fill_in "phone", with: "3334445555"
        fill_in "fees", with: "None"
        fill_in "schedule", with: "M-F 9-5"
        fill_in "description", with: "I have housing"

        click_button "Submit"
  
        expect(current_path).to eq(new_register_provider_path)
        expect(page).to have_content("Invalid entries, please try again")
      end

      it "SAD PATH: If I do not fill in my city it errors" do
        fill_in "name", with: "Housing Option"
        fill_in "street", with: "123 Street Street"
        # fill_in "city", with: "Townsville"
        fill_in "state", with: "UI"
        fill_in "zipcode", with: "11111"
        fill_in "phone", with: "3334445555"
        fill_in "fees", with: "None"
        fill_in "schedule", with: "M-F 9-5"
        fill_in "description", with: "I have housing"

        click_button "Submit"
  
        expect(current_path).to eq(new_register_provider_path)
        expect(page).to have_content("Invalid entries, please try again")
      end

      it "SAD PATH: If I do not fill in my state it errors" do
        fill_in "name", with: "Housing Option"
        fill_in "street", with: "123 Street Street"
        fill_in "city", with: "Townsville"
        # fill_in "state", with: "UI"
        fill_in "zipcode", with: "11111"
        fill_in "phone", with: "3334445555"
        fill_in "fees", with: "None"
        fill_in "schedule", with: "M-F 9-5"
        fill_in "description", with: "I have housing"

        click_button "Submit"
  
        expect(current_path).to eq(new_register_provider_path)
        expect(page).to have_content("Invalid entries, please try again")
      end

      it "SAD PATH: If I do not fill in my zipcode it errors" do
        fill_in "name", with: "Housing Option"
        fill_in "street", with: "123 Street Street"
        fill_in "city", with: "Townsville"
        fill_in "state", with: "UI"
        # fill_in "zipcode", with: "11111"
        fill_in "phone", with: "3334445555"
        fill_in "fees", with: "None"
        fill_in "schedule", with: "M-F 9-5"
        fill_in "description", with: "I have housing"

        click_button "Submit"
  
        expect(current_path).to eq(new_register_provider_path)
        expect(page).to have_content("Invalid entries, please try again")
      end

    it "SAD PATH: If I do not fill in my phone number it errors" do
        fill_in "name", with: "Housing Option"
        fill_in "street", with: "123 Street Street"
        fill_in "city", with: "Townsville"
        fill_in "state", with: "UI"
        fill_in "zipcode", with: "11111"
        # fill_in "phone", with: "3334445555"
        fill_in "fees", with: "None"
        fill_in "schedule", with: "M-F 9-5"
        fill_in "description", with: "I have housing"

        click_button "Submit"
  
        expect(current_path).to eq(new_register_provider_path)
        expect(page).to have_content("Invalid entries, please try again")
      end

      it "SAD PATH: If I do not fill in my description it errors" do
        fill_in "name", with: "Housing Option"
        fill_in "street", with: "123 Street Street"
        fill_in "city", with: "Townsville"
        fill_in "state", with: "UI"
        fill_in "zipcode", with: "11111"
        fill_in "phone", with: "3334445555"
        # fill_in "fees", with: "None"
        fill_in "schedule", with: "M-F 9-5"
        fill_in "description", with: "I have housing"

        click_button "Submit"
  
        expect(current_path).to eq(new_register_provider_path)
        expect(page).to have_content("Invalid entries, please try again")
      end

      it "SAD PATH: If I do not fill in my description it errors" do
        fill_in "name", with: "Housing Option"
        fill_in "street", with: "123 Street Street"
        fill_in "city", with: "Townsville"
        fill_in "state", with: "UI"
        fill_in "zipcode", with: "11111"
        fill_in "phone", with: "3334445555"
        fill_in "fees", with: "None"
        # fill_in "schedule", with: "M-F 9-5"
        fill_in "description", with: "I have housing"

        click_button "Submit"
  
        expect(current_path).to eq(new_register_provider_path)
        expect(page).to have_content("Invalid entries, please try again")
      end

      it "SAD PATH: If I do not fill in my description it errors" do
        fill_in "name", with: "Housing Option"
        fill_in "street", with: "123 Street Street"
        fill_in "city", with: "Townsville"
        fill_in "state", with: "UI"
        fill_in "zipcode", with: "11111"
        fill_in "phone", with: "3334445555"
        fill_in "fees", with: "None"
        fill_in "schedule", with: "M-F 9-5"
        # fill_in "description", with: "I have housing"

        click_button "Submit"
  
        expect(current_path).to eq(new_register_provider_path)
        expect(page).to have_content("Invalid entries, please try again")
      end

      it "requires user to be logged in" do
        click_on "Sign out"
        visit new_register_provider_path
        expect(page).to have_content("You must be logged in to access this page.")
      end
    end
  end
end