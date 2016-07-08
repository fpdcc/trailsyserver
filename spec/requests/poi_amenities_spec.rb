require 'rails_helper'

RSpec.describe "PoiAmenities", type: :request do
  describe "GET /poi_amenities" do
    it "works! (now write some real specs)" do
      get poi_amenities_path
      expect(response).to have_http_status(200)
    end
  end
end
