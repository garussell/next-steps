require 'rails_helper'

RSpec.describe "Category Index", :vcr do
  describe "As a visitor" do
    describe "Will return search results based on selected categories" do
      it "If Urgent Care and Food are selected, only those categories will be displayed" do
        visit root_path
        within("div.select-services") do
          fill_in 'Enter your City, State, and/or Zip Code', with: 'Denver, Colorado'
          check('Urgent Care')
          check('Food')
          click_button('Get Help!', match: :first)
        end

        expect(current_path).to eq(search_results_path)
        expect(page).to have_content("Urgent care results")
        expect(page).to_not have_content("Crisis Hotline results")
        expect(page).to_not have_content("Shelter for Tonight results")
        expect(page).to have_content("Food results")
        expect(page).to_not have_content("Substance Use results")
      end
    end
  end
end