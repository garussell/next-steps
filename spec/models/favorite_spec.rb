require 'rails_helper'

RSpec.describe Favorite, type: :model do
  describe 'relationships' do
    it { should belong_to :user }
  end

  describe 'validations' do
    it { should validate_presence_of :category }
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :address }
    it { should validate_presence_of :website }
    it { should validate_presence_of :phone }
    it { should validate_presence_of :fees }
    it { should validate_presence_of :schedule }
  end
end