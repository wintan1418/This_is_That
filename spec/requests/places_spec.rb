require 'rails_helper'

RSpec.describe "Places", type: :request do
  let(:user) { create(:user) }
  let(:place) { create(:place, user: user) }

  before do
    sign_in user, scope: :user
  end

  describe "GET /places/:id" do
    it "returns http success" do
      get place_path(place)
      expect(response).to have_http_status(:success)
      expect(response.body).to include(place.name)
    end
  end

  describe "POST /places/:id/toggle_favorite" do
    it "toggles the favorite status" do
      # Initial state: not favorite (default in factory)
      expect(place.is_favorite).to be false

      # Toggle ON
      post toggle_favorite_place_path(place), headers: { "Accept" => "text/html" }
      expect(response).to redirect_to(place_path(place))
      expect(place.reload.is_favorite).to be true

      # Toggle OFF
      post toggle_favorite_place_path(place), headers: { "Accept" => "text/html" }
      expect(response).to redirect_to(place_path(place))
      expect(place.reload.is_favorite).to be false
    end
  end
end
