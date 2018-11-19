require 'rails_helper'

RSpec.describe "Alerts", type: :request do
  describe "Public access to alerts:", type: :request do
    it "denies access to alerts#new" do
      get new_alert_path
      expect(response).to redirect_to new_user_session_path
    end

    it "denies access to alerts#create" do
      alert_attributes = FactoryBot.attributes_for(:alert)
      expect {
        post "/alerts", params: { alert: alert_attributes }
      }.to_not change(Alert, :count)
      expect(response).to redirect_to new_user_session_path
    end

    it "denies access to alerts#update" do
      alert = FactoryBot.create(:alert)
      put alert_path(alert.id)
      expect(response).to redirect_to new_user_session_path
    end

    it "denies access to alerts#destroy" do
      alert = FactoryBot.create(:alert)
      delete alert_path(alert.id)
      expect(response).to redirect_to new_user_session_path
    end

    it "denies access to alerts#show" do
      alert = FactoryBot.create(:alert)
      get alert_path(alert.id)
      expect(response).to redirect_to new_user_session_path
    end

    it "denies access to alerts#index html" do
      get "/alerts"
      expect(response).to redirect_to new_user_session_path
    end

    it "denies access to alerts#global" do
      get "/alerts/global"
      expect(response).to redirect_to new_user_session_path
    end

    it "denies access to alerts#history" do
      get "/alerts/history"
      expect(response).to redirect_to new_user_session_path
    end

    it "denies access to alerts#poi" do
      get "/alerts/poi"
      expect(response).to redirect_to new_user_session_path
    end

    it "denies access to alerts#trail" do
      get "/alerts/trail"
      expect(response).to redirect_to new_user_session_path
    end

    it "allows access to alerts#index json" do
      get "/alerts.json"
      expect(response).to have_http_status(200)
    end

    it "allows access to alerts#list json" do
      get "/alerts/list.json"
      expect(response).to have_http_status(200)
    end
  end

  describe "Admin access to alerts:", type: :request do
    login_admin
    # it "denies access to alerts#new" do
    #   get new_alert_path
    #   expect(response).to redirect_to new_user_session_path
    # end

    it "allows access to alerts#create" do
      alert_attributes = FactoryBot.attributes_for(:alert)
      #request.env['HTTP_REFERER'] = 'https://map.fpdcc.com/alerts'
      expect {
        post "/alerts", params: { alert: alert_attributes }
      }.to change(Alert, :count)
    end

    it "allows access to alerts#update" do
      alert = FactoryBot.create(:alert)
      prev_updated_at = alert.updated_at
      alert_attributes = {description: "New Description"}
      put alert_path(alert.id), params: { alert: alert_attributes }
      alert.reload
      expect(alert.updated_at).not_to eq(prev_updated_at)
    end

    it "allows access to alerts#destroy" do
      alert = FactoryBot.create(:alert)
      expect { delete alert_path(alert.id) }.to change { Alert.count }.by(-1)
    end

    it "allows access to alerts#show" do
      alert = FactoryBot.create(:alert)
      get alert_path(alert.id)
      expect(response).to have_http_status(200)
    end

    it "allows access to alerts#index html" do
      get "/alerts"
      expect(response).to have_http_status(200)
    end

    it "allows access to alerts#global" do
      get "/alerts/global"
      expect(response).to have_http_status(200)
    end

    it "allows access to alerts#history" do
      get "/alerts/history"
      expect(response).to have_http_status(200)
    end

    it "allows access to alerts#poi" do
      get "/alerts/poi"
      expect(response).to have_http_status(200)
    end

    it "allows access to alerts#trail" do
      get "/alerts/trail"
      expect(response).to have_http_status(200)
    end

    it "allows access to alerts#index json" do
      get "/alerts.json"
      expect(response).to have_http_status(200)
    end

    it "allows access to alerts#list json" do
      get "/alerts/list.json"
      expect(response).to have_http_status(200)
    end
  end

  describe "Level1 access to alerts:", type: :request do
    login_level1
    # it "denies access to alerts#new" do
    #   get new_alert_path
    #   expect(response).to redirect_to new_user_session_path
    # end

    it "allows access to alerts#create" do
      alert_attributes = FactoryBot.attributes_for(:alert)
      #request.env['HTTP_REFERER'] = 'https://map.fpdcc.com/alerts'
      expect {
        post "/alerts", params: { alert: alert_attributes }
      }.to change(Alert, :count)
    end

    it "allows access to alerts#update" do
      alert = FactoryBot.create(:alert)
      prev_updated_at = alert.updated_at
      alert_attributes = {description: "New Description"}
      put alert_path(alert.id), params: { alert: alert_attributes }
      alert.reload
      expect(alert.updated_at).not_to eq(prev_updated_at)
    end

    it "allows access to alerts#destroy" do
      alert = FactoryBot.create(:alert)
      expect { delete alert_path(alert.id) }.to change { Alert.count }.by(-1)
    end

    it "denies access to alerts#show" do
      alert = FactoryBot.create(:alert)
      get alert_path(alert.id)
      expect(response).to redirect_to root_path
    end

    it "denies access to alerts#index html" do
      get "/alerts"
      expect(response).to redirect_to root_path
    end

    it "denies access to alerts#global" do
      get "/alerts/global"
      expect(response).to redirect_to root_path
    end

    it "denies access to alerts#history" do
      get "/alerts/history"
      expect(response).to redirect_to root_path
    end

    it "allows access to alerts#poi" do
      get "/alerts/poi"
      expect(response).to have_http_status(200)
    end

    it "denies access to alerts#trail" do
      get "/alerts/trail"
      expect(response).to redirect_to root_path
    end

    it "allows access to alerts#index json" do
      get "/alerts.json"
      expect(response).to have_http_status(200)
    end

    it "allows access to alerts#list json" do
      get "/alerts/list.json"
      expect(response).to have_http_status(200)
    end
  end

  describe "Level2 access to alerts:", type: :request do
    login_level2
    # it "denies access to alerts#new" do
    #   get new_alert_path
    #   expect(response).to redirect_to new_user_session_path
    # end

    it "allows access to alerts#create" do
      alert_attributes = FactoryBot.attributes_for(:alert)
      #request.env['HTTP_REFERER'] = 'https://map.fpdcc.com/alerts'
      expect {
        post "/alerts", params: { alert: alert_attributes }
      }.to change(Alert, :count)
    end

    it "allows access to alerts#update" do
      alert = FactoryBot.create(:alert)
      prev_updated_at = alert.updated_at
      alert_attributes = {description: "New Description"}
      put alert_path(alert.id), params: { alert: alert_attributes }
      alert.reload
      expect(alert.updated_at).not_to eq(prev_updated_at)
    end

    it "allows access to alerts#destroy" do
      alert = FactoryBot.create(:alert)
      expect { delete alert_path(alert.id) }.to change { Alert.count }.by(-1)
    end

    it "denies access to alerts#show" do
      alert = FactoryBot.create(:alert)
      get alert_path(alert.id)
      expect(response).to redirect_to root_path
    end

    it "denies access to alerts#index html" do
      get "/alerts"
      expect(response).to redirect_to root_path
    end

    it "denies access to alerts#global" do
      get "/alerts/global"
      expect(response).to redirect_to root_path
    end

    it "denies access to alerts#history" do
      get "/alerts/history"
      expect(response).to redirect_to root_path
    end

    it "allows access to alerts#poi" do
      get "/alerts/poi"
      expect(response).to have_http_status(200)
    end

    it "denies access to alerts#trail" do
      get "/alerts/trail"
      expect(response).to have_http_status(200)
    end

    it "allows access to alerts#index json" do
      get "/alerts.json"
      expect(response).to have_http_status(200)
    end

    it "allows access to alerts#list json" do
      get "/alerts/list.json"
      expect(response).to have_http_status(200)
    end
  end

end
