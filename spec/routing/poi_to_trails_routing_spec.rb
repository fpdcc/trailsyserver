require "rails_helper"

RSpec.describe PoiToTrailsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/poi_to_trails").to route_to("poi_to_trails#index")
    end

    it "routes to #new" do
      expect(:get => "/poi_to_trails/new").to route_to("poi_to_trails#new")
    end

    it "routes to #show" do
      expect(:get => "/poi_to_trails/1").to route_to("poi_to_trails#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/poi_to_trails/1/edit").to route_to("poi_to_trails#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/poi_to_trails").to route_to("poi_to_trails#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/poi_to_trails/1").to route_to("poi_to_trails#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/poi_to_trails/1").to route_to("poi_to_trails#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/poi_to_trails/1").to route_to("poi_to_trails#destroy", :id => "1")
    end

  end
end
