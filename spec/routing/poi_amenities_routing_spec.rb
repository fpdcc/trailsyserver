require "rails_helper"

RSpec.describe PoiAmenitiesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/poi_amenities").to route_to("poi_amenities#index")
    end

    it "routes to #new" do
      expect(:get => "/poi_amenities/new").to route_to("poi_amenities#new")
    end

    it "routes to #show" do
      expect(:get => "/poi_amenities/1").to route_to("poi_amenities#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/poi_amenities/1/edit").to route_to("poi_amenities#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/poi_amenities").to route_to("poi_amenities#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/poi_amenities/1").to route_to("poi_amenities#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/poi_amenities/1").to route_to("poi_amenities#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/poi_amenities/1").to route_to("poi_amenities#destroy", :id => "1")
    end

  end
end
