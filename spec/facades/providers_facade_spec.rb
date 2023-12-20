require 'rails_helper'

RSpec.describe ProvidersFacade, :vcr do
  describe '#provider_details' do
    it 'returns a provider object for a specific service location' do
      provider_id = '211colorad-a0h4T000002u0RpQAI'
      facade = ProvidersFacade.new(provider_id)
      provider = facade.provider_details

      expect(provider).to be_a(DetailedProvider)
    end
  end

  describe 'Private #create_provider(json)' do
    it 'raises an error when response is 404' do
      invalid_response = {:type=>"https://tools.ietf.org/html/rfc7231#section-6.5.4", 
                          :title=>"Not Found", :status=>404, 
                          :traceId=>"80000ac3-0002-c400-b63f-84710c7967bb"}

      provider_id = 'Float::INFINITY'
      facade = ProvidersFacade.new(provider_id)

      expect{ facade.send(:create_provider, invalid_response) }.to raise_error(RuntimeError, "Could not find a provider with that ID")
    end
    
    it 'creates a DetailedProvider object when response succeeds' do
      valid_response = [{:idOrganization=>"211contrac-213",
                        :name=>"DAVITA HEALTHCARE PARTNERS",
                        :alternateName=>nil,
                        :description=>
                        "Provides dialysis services for those diagnosed with chronic kidney failure, a condition also known as chronic kidney disease (CKD). Provides locations of over 2,000 outpatient dialysis facilities and acute units in over 800 hospitals 46 states and the District of Columbia. Website offers extensive information about CKD.",
                        :url=>"http://www.davita.com",
                        :taxStatus=>nil,
                        :taxId=>"None",
                        :yearIncorporated=>nil,
                        :legalStatus=>"For Profit",
                        :services=>
                        [{:idService=>"211contrac-1561",
                          :idOrganization=>"211contrac-213",
                          :name=>"DAVITA HEALTHCARE PARTNERS (DIALYSIS CENTERS)",
                          :alternateName=>nil,
                          :description=>
                            "Provides dialysis services for those diagnosed with chronic kidney failure, a condition also known as chronic kidney disease (CKD). Provides locations of over 2,000 outpatient dialysis facilities and acute units in over 800 hospitals 46 states and the District of Columbia. Website offers extensive information about CKD.",
                          :email=>nil,
                          :url=>"http://www.davita.com",
                          :status=>"active",
                          :applicationProcess=>"Call for information or use website to locate dialysis clinics by city and/or zip code",
                          :waitTime=>nil,
                          :fees=>"Varies, according to health plan.",
                          :accreditations=>nil,
                          :schedule=>"Monday-Friday, 5am-6:30pm; Saturday: 7-11am",
                          :language=>"English only",
                          :eligibility=>"Anyone in need of dialysis",
                          :document=>"None",
                          :contact=>[],
                          :phone=>[{:idPhone=>"8996837316245339326", :number=>"(800) 244-0680", :extension=>nil, :type=>"main number", :description=>nil, :name=>nil}],
                          :taxonomy=>
                            [{:idTaxonomy=>"7880547121544954498",
                              :code=>"LT-2600.1500",
                              :term=>"Dialysis Centers",
                              :nameLevel1=>"Health Care",
                              :nameLevel2=>"Specialized Treatment and Prevention",
                              :nameLevel3=>"Hemodialysis",
                              :nameLevel4=>"Dialysis Centers",
                              :nameLevel5=>nil,
                              :nameLevel6=>nil}],
                          :category=>nil,
                          :serviceAtLocation=>[{:idServiceAtLocation=>"211contrac-1561", :idLocation=>"211contrac-1617", :idService=>"211contrac-1561"}],
                          :temporaryMessage=>nil,
                          :createdOn=>nil,
                          :lastUpdated=>nil,
                          :lastVerified=>nil}],
                        :locations=>
                        [{:idLocation=>"211contrac-1617",
                          :name=>"DAVITA HEALTHCARE PARTNERS",
                          :alternateName=>nil,
                          :description=>
                            "Provides dialysis services for those diagnosed with chronic kidney failure, a condition also known as chronic kidney disease (CKD). Provides locations of over 2,000 outpatient d
                      ialysis facilities and acute units in over 800 hospitals 46 states and the District of Columbia. Website offers extensive information about CKD.",
                          :transportation=>nil,
                          :latitude=>"39.753627",
                          :longitude=>"-105.003635",
                          :schedule=>"Monday-Friday, 5am-6:30pm; Saturday: 7-11am",
                          :address=>
                            [{:idAddress=>"2509270918712944620",
                              :type=>"physical",
                              :address_1=>"2000 16th Street",
                              :address_2=>nil,
                              :city=>"Denver",
                              :region=>"Denver",
                              :state_province=>"CO",
                              :zipcode=>"80202",
                              :country=>"United States"}],
                          :accessibility=>nil,
                          :language=>nil,
                          :phone=>
                            [{:idPhone=>"4429686088590907983", :number=>"(800) 424-6589", :extension=>nil, :type=>"Backdoor Number", :description=>nil, :name=>nil},
                            {:idPhone=>"6719860891525450389", :number=>"(800) 244-0680", :extension=>nil, :type=>"Main Number", :description=>nil, :name=>nil}],
                          :serviceAtLocation=>
                            [{:idServiceAtLocation=>"211contrac-1561", :idLocation=>"211contrac-1617", :idService=>"211contrac-1561"},
                            {:idServiceAtLocation=>"211contrac-1562", :idLocation=>"211contrac-1617", :idService=>"211contrac-1562"}]}],
                        :source=>"211 Contra Costa",
                        :createdOn=>nil,
                        :lastUpdated=>nil,
                        :lastVerified=>nil,
                        :partitionKey=>"LT-2600.1500",
                        :id=>nil,
                        :_rid=>nil,
                        :_self=>nil,
                        :_etag=>nil,
                        :_attachments=>nil}]
  
      provider_id = '211contrac-1561'
      facade = ProvidersFacade.new(provider_id)
  
      expect(facade.send(:create_provider, valid_response)).to be_a(DetailedProvider)
    end
  end
end