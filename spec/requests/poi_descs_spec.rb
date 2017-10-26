require 'rails_helper'

RSpec.describe "PoiDescs", type: :request do
  describe "GET /poi_descs" do
    it "works! (now write some real specs)" do
      get poi_descs_path
      expect(response).to have_http_status(200)
    end
  end
end
