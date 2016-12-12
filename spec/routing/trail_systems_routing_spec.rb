require "rails_helper"

RSpec.describe TrailSystemsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/trail_systems").to route_to("trail_systems#index")
    end

    it "routes to #new" do
      expect(:get => "/trail_systems/new").to route_to("trail_systems#new")
    end

    it "routes to #show" do
      expect(:get => "/trail_systems/1").to route_to("trail_systems#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/trail_systems/1/edit").to route_to("trail_systems#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/trail_systems").to route_to("trail_systems#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/trail_systems/1").to route_to("trail_systems#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/trail_systems/1").to route_to("trail_systems#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/trail_systems/1").to route_to("trail_systems#destroy", :id => "1")
    end

  end
end
