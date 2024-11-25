class NextStepsService

  def self.search(location, keyword)
    @keyword = keyword
    get_url("search?keyword=#{keyword}&location=#{location}")
  end

  def self.get_url(url)
    response = conn.get(url)
    return JSON.parse(response.body, symbolize_names: true)[:data]&.map do |data|
      FilteredResults.new(data, @keyword) 
    end
  end
  
  def self.provider_details(id, category)
    get_provider("provider_details/#{id}", category)
  end

  def self.get_provider(url, category)
    response = conn.get(url)
    response_json = JSON.parse(response.body, symbolize_names: true)[:data]
    ProviderDetails.new(response_json, category) 
  end
  
  def self.conn
    Faraday.new(url: Rails.application.credentials.next_steps[:API_PATH])
  end
end