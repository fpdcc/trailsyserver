require 'rails_helper'

RSpec.describe "Names", type: :request do
  describe "GET /names" do
    it "works! (now write some real specs)" do
      get names_path
      expect(response).to have_http_status(200)
    end
  end
end
