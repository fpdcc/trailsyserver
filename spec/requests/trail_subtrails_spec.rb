require 'rails_helper'

RSpec.describe "TrailSubtrails", type: :request do
  describe "GET /trail_subtrails" do
    it "works! (now write some real specs)" do
      get trail_subtrails_path
      expect(response).to have_http_status(200)
    end
  end
end
