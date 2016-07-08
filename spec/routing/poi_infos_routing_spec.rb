require "rails_helper"

RSpec.describe PoiInfosController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/poi_infos").to route_to("poi_infos#index")
    end

    it "routes to #new" do
      expect(:get => "/poi_infos/new").to route_to("poi_infos#new")
    end

    it "routes to #show" do
      expect(:get => "/poi_infos/1").to route_to("poi_infos#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/poi_infos/1/edit").to route_to("poi_infos#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/poi_infos").to route_to("poi_infos#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/poi_infos/1").to route_to("poi_infos#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/poi_infos/1").to route_to("poi_infos#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/poi_infos/1").to route_to("poi_infos#destroy", :id => "1")
    end

  end
end
