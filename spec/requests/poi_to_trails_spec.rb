require 'rails_helper'

RSpec.describe "PoiToTrails", type: :request do
  describe "GET /poi_to_trails" do
    it "works! (now write some real specs)" do
      get poi_to_trails_path
      expect(response).to have_http_status(200)
    end
  end
end
