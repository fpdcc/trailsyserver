require "rails_helper"

RSpec.describe ParkingEntranceInfosController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/parking_entrance_infos").to route_to("parking_entrance_infos#index")
    end

    it "routes to #new" do
      expect(:get => "/parking_entrance_infos/new").to route_to("parking_entrance_infos#new")
    end

    it "routes to #show" do
      expect(:get => "/parking_entrance_infos/1").to route_to("parking_entrance_infos#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/parking_entrance_infos/1/edit").to route_to("parking_entrance_infos#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/parking_entrance_infos").to route_to("parking_entrance_infos#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/parking_entrance_infos/1").to route_to("parking_entrance_infos#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/parking_entrance_infos/1").to route_to("parking_entrance_infos#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/parking_entrance_infos/1").to route_to("parking_entrance_infos#destroy", :id => "1")
    end

  end
end
