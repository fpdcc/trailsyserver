require 'rails_helper'

RSpec.describe "NewTrails", type: :request do
  describe "GET /new_trails" do
    it "works! (now write some real specs)" do
      get new_trails_path
      expect(response).to have_http_status(200)
    end
  end
end
