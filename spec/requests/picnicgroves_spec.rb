require 'rails_helper'

RSpec.describe "Picnicgroves", type: :request do
  describe "GET /picnicgroves" do
    it "works! (now write some real specs)" do
      get picnicgroves_path
      expect(response).to have_http_status(200)
    end
  end
end
