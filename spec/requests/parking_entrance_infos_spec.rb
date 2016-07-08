require 'rails_helper'

RSpec.describe "ParkingEntranceInfos", type: :request do
  describe "GET /parking_entrance_infos" do
    it "works! (now write some real specs)" do
      get parking_entrance_infos_path
      expect(response).to have_http_status(200)
    end
  end
end
