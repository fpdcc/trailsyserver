require "rails_helper"

RSpec.describe ParkingEntrancesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/parking_entrances").to route_to("parking_entrances#index")
    end

    it "routes to #new" do
      expect(:get => "/parking_entrances/new").to route_to("parking_entrances#new")
    end

    it "routes to #show" do
      expect(:get => "/parking_entrances/1").to route_to("parking_entrances#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/parking_entrances/1/edit").to route_to("parking_entrances#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/parking_entrances").to route_to("parking_entrances#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/parking_entrances/1").to route_to("parking_entrances#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/parking_entrances/1").to route_to("parking_entrances#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/parking_entrances/1").to route_to("parking_entrances#destroy", :id => "1")
    end

  end
end
