require 'rails_helper'

RSpec.describe "TrailsInfos", type: :request do
  describe "GET /trails_infos" do
    it "works! (now write some real specs)" do
      get trails_infos_path
      expect(response).to have_http_status(200)
    end
  end
end
