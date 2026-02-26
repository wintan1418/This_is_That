require 'rails_helper'

RSpec.describe 'Authentication', type: :system do
  before do
    driven_by(:selenium, using: :headless_chrome, screen_size: [ 1400, 1400 ])
  end

  describe 'Sign Up' do
    it 'allows user to create an account' do
      visit new_user_registration_path

      fill_in 'Name', with: 'Test User'
      fill_in 'Email', with: 'test@example.com'
      fill_in 'Password', with: 'password123'
      fill_in 'Confirm Password', with: 'password123'

      click_button 'Create Account'

      expect(page).to have_content('Welcome! You have signed up successfully.')
      expect(User.last.email).to eq('test@example.com')
    end
  end

  describe 'Sign In' do
    let!(:user) { create(:user, email: 'user@example.com', password: 'password123') }

    it 'allows user to sign in' do
      visit new_user_session_path

      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'password123'
      click_button 'Sign In'

      expect(page).to have_content('Signed in successfully.')
    end
  end
end
