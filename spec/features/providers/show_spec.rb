require 'rails_helper'

RSpec.describe "Providers Show page", :vcr do
  describe "As a visitor" do
    describe "When I visit the providers show page" do
      it "I see that provider's address and website are links.  I also see all of the providers information, including phone number" do
        id = "211colorad-a0h4T000003fVncQAE"
        visit provider_path(id)

        expect(page).to have_content("NEXTCARE URGENT CARE")
        expect(page).to have_link("4590 W 121st Ave, Broomfield, CO 80020")
        expect(page).to have_content("Provides urgent care services")
        expect(page).to have_link("http://nextcare.com")
        expect(page).to have_content("(888) 381-4858")
        expect(page).to have_content("Medical Care Fees, call for current fees.")
        expect(page).to have_content("Monday - Friday, 8 a.m. - 8 p.m.; Saturday, Sunday, 9 a.m. - 4 p.m.")
        expect(page).to have_content("39.914985 | -105.045970")
      end
    end
  end
end