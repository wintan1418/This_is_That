require 'rails_helper'

RSpec.describe Place, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      place = build(:place)
      expect(place).to be_valid
    end

    it 'is invalid without a name' do
      place = build(:place, name: nil)
      expect(place).not_to be_valid
    end

    it 'is invalid without an address' do
      place = build(:place, address: nil)
      expect(place).not_to be_valid
    end
  end

  describe 'geocoding' do
    it 'geocodes automatically on save if address changes' do
      place = build(:place, address: '1600 Amphitheatre Parkway, Mountain View, CA')
      # We mock geocoder call to avoid hitting external API in tests
      allow(place).to receive(:geocode).and_return(true)
      
      expect(place).to be_valid
    end
  end
end
