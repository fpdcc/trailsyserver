require 'rails_helper'

RSpec.describe "PoiInfos", type: :request do
  describe "GET /poi_infos" do
    it "works! (now write some real specs)" do
      get poi_infos_path
      expect(response).to have_http_status(200)
    end
  end
end
