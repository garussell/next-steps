require 'rails_helper'
RSpec.describe TwoOneOneService, :vcr do
  describe "#search(keyword, location)" do
    it "returns the top ten results for a given keyword and location" do
      keyword = "healthcare"
      location = "denver+CO"
      service = TwoOneOneService.new
      json = service.search(keyword, location)

      expect(json[:results].count).to eq(10)
      
      provider = json[:results].first[:document]
    
      expect(provider).to have_key(:id)
      expect(provider[:id]).to be_an(String)

      expect(provider).to have_key(:nameService)
      expect(provider[:nameService]).to be_a(String)

      expect(provider).to have_key(:address1PhysicalAddress)
      expect(provider[:address1PhysicalAddress]).to be_a(String)

      expect(provider).to have_key(:cityPhysicalAddress)
      expect(provider[:cityPhysicalAddress]).to be_a(String)

      expect(provider).to have_key(:statePhysicalAddress)
      expect(provider[:statePhysicalAddress]).to be_a(String)

      expect(provider).to have_key(:latitudeLocation)
      expect(provider[:latitudeLocation]).to be_a(String)

      expect(provider).to have_key(:longitudeLocation)
      expect(provider[:longitudeLocation]).to be_a(String)

      expect(provider).to have_key(:descriptionService)
      expect(provider[:descriptionService]).to be_a(String)
    end
  end

  describe "get_provider_details(service_id)" do
    it "returns the detailed provider information based off of id" do
      provider_id = "211colorad-a0h4T000002u0RpQAI"
      service = TwoOneOneService.new
      json = service.get_provider_details(provider_id)

      expect(json).to be_an(Array)
      expect(json.count).to eq(1)

      provider = json.first
      
      expect(provider).to have_key(:idOrganization)
      expect(provider[:idOrganization]).to be_an(String)
      expect(provider).to have_key(:name)
      expect(provider[:name]).to be_a(String)
      expect(provider).to have_key(:description)
      expect(provider[:description]).to be_a(String)
      expect(provider).to have_key(:url)
      expect(provider[:url]).to be_a(String)

      expect(provider).to have_key(:services)
      expect(provider[:services]).to be_an(Array)
      expect(provider[:services].first).to have_key(:fees)
      expect(provider[:services].first[:fees]).to eq(nil)

      expect(provider).to have_key(:locations)
      expect(provider[:locations]).to be_a(Array)

      location = provider[:locations].first

      expect(location).to have_key(:latitude)
      expect(location[:latitude]).to be_a(String)
      expect(location).to have_key(:latitude)
      expect(location[:latitude]).to be_a(String)
      expect(location).to have_key(:schedule)
      expect(location[:latitude]).to be_a(String)
      
      expect(location).to have_key(:phone)
      expect(location[:phone]).to be_a(Array)
      expect(location[:phone].first).to have_key(:number)
      expect(location[:phone].first[:number]).to be_a(String)

      expect(location).to have_key(:address)
      expect(location[:address]).to be_a(Array)

      address = location[:address].first

      expect(address).to have_key(:address_1)
      expect(address).to have_key(:address_2)
      expect(address).to have_key(:city)
      expect(address).to have_key(:state_province)
      expect(address).to have_key(:zipcode)
    end
  end
end 
