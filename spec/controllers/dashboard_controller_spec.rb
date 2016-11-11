require 'rails_helper'

RSpec.describe DashboardController, type: :controller do

  describe "GET #poi" do
    it "returns http success" do
      get :poi
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #trail" do
    it "returns http success" do
      get :trail
      expect(response).to have_http_status(:success)
    end
  end

end
