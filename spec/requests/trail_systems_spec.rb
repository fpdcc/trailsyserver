require 'rails_helper'

RSpec.describe "TrailSystems", type: :request do
  describe "GET /trail_systems" do
    it "works! (now write some real specs)" do
      get trail_systems_path
      expect(response).to have_http_status(200)
    end
  end
end
