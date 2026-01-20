require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      user = build(:user)
      expect(user).to be_valid
    end

    it 'is invalid without a name' do
      user = build(:user, name: nil)
      expect(user).not_to be_valid
    end

    it 'is invalid without an email' do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
    end
  end

  describe 'associations' do
    it 'has many places' do
      association = described_class.reflect_on_association(:places)
      expect(association.macro).to eq :has_many
    end

    it 'has many reviews' do
      association = described_class.reflect_on_association(:reviews)
      expect(association.macro).to eq :has_many
    end
  end

  describe '#home_places' do
    it 'returns only places marked as home place' do
      user = create(:user)
      home_place = create(:place, user: user, is_home_place: true)
      match_place = create(:place, user: user, is_home_place: false)

      expect(user.home_places).to include(home_place)
      expect(user.home_places).not_to include(match_place)
    end
  end
end
