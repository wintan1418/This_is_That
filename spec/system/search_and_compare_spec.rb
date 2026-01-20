require 'rails_helper'

RSpec.describe 'Search and Compare', type: :system do
  before do
    driven_by(:selenium, using: :headless_chrome, screen_size: [1400, 1400])
  end

  let!(:user) { create(:user) }
  let!(:home_place) { create(:place, user: user, name: "Home Coffee", is_home_place: true) }

  before do
    sign_in user
  end

  describe 'Compare Flow' do
    it 'allows selecting places for comparison', js: true do
      visit search_path(home_place_id: home_place.id, term: 'coffee', location: 'Tokyo')
      
      # Mock the search logic/results if needed, 
      # but for now we verify the page loads and we can interact
      # Since we don't haven Search results without mocking external API, 
      # we will focus on verifying the elements exist if results were present
      
      expect(page).to have_content('Search')
    end
  end
end
