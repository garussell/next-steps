require 'rails_helper'

RSpec.describe "Category Show", :vcr do
  describe "As a visitor" do
    describe "When I have successfully entered a search for an urgent resource, and I am taken to the Search Results Page, the is a link to 'See more results'." do
      it "When I click the link, I am taken to a page where I see all the results for that category." do
        visit root_path
        within('div.select-services') do
          fill_in 'Enter your City, State, and/or Zip Code', with: 'Denver, Colorado'
          check('Urgent Care')
          check('Food')
          click_button('Get Help!', match: :first)
        end
        expect(current_path).to eq(search_results_path)
        first('a', text: "See more results").click
        expect(current_path).to eq("/search_results/1")

        result_items = page.all('.result-item')
        expect(result_items.count).to be > 3
        
      end
    end
  end
end