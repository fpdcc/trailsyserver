require "rails_helper"

RSpec.describe TrailSubtrailsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/trail_subtrails").to route_to("trail_subtrails#index")
    end

    it "routes to #new" do
      expect(:get => "/trail_subtrails/new").to route_to("trail_subtrails#new")
    end

    it "routes to #show" do
      expect(:get => "/trail_subtrails/1").to route_to("trail_subtrails#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/trail_subtrails/1/edit").to route_to("trail_subtrails#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/trail_subtrails").to route_to("trail_subtrails#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/trail_subtrails/1").to route_to("trail_subtrails#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/trail_subtrails/1").to route_to("trail_subtrails#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/trail_subtrails/1").to route_to("trail_subtrails#destroy", :id => "1")
    end

  end
end
