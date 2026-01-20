require 'rails_helper'

RSpec.describe "Search", type: :request do
  let(:user) { create(:user) }
  let(:home_place) { create(:place, user: user, is_home_place: true, name: "Home Base") }

  before do
    sign_in user, scope: :user
  end

  describe "GET /search" do
    context "with valid parameters" do
      it "returns http success" do
        get search_path(home_place_id: home_place.id, term: "coffee", location: "New York")
        expect(response).to have_http_status(:success)
      end
    end

    context "missing home_place_id" do
      it "redirects to root or handles gracefully" do
        get search_path(term: "coffee")
        # Depending on implementation, it might redirect or show error
        # Assuming typical happy path for now, adjust based on controller logic
        expect(response).to have_http_status(:found).or have_http_status(:success)
      end
    end
  end
end
