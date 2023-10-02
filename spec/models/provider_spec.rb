require 'rails_helper'

RSpec.describe Provider, type: :model do

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:street) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zipcode) }
    it { should validate_presence_of(:phone) }
    it { should validate_length_of(:state).is_equal_to(2) }
    it { should validate_length_of(:zipcode).is_equal_to(5) }
  end
end
