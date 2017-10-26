require "rails_helper"

RSpec.describe PoiDescsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/poi_descs").to route_to("poi_descs#index")
    end

    it "routes to #new" do
      expect(:get => "/poi_descs/new").to route_to("poi_descs#new")
    end

    it "routes to #show" do
      expect(:get => "/poi_descs/1").to route_to("poi_descs#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/poi_descs/1/edit").to route_to("poi_descs#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/poi_descs").to route_to("poi_descs#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/poi_descs/1").to route_to("poi_descs#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/poi_descs/1").to route_to("poi_descs#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/poi_descs/1").to route_to("poi_descs#destroy", :id => "1")
    end

  end
end
