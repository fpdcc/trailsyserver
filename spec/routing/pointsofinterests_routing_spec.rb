require "rails_helper"

RSpec.describe PointsofinterestsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/pointsofinterests").to route_to("pointsofinterests#index")
    end

    it "routes to #new" do
      expect(:get => "/pointsofinterests/new").to route_to("pointsofinterests#new")
    end

    it "routes to #show" do
      expect(:get => "/pointsofinterests/1").to route_to("pointsofinterests#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/pointsofinterests/1/edit").to route_to("pointsofinterests#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/pointsofinterests").to route_to("pointsofinterests#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/pointsofinterests/1").to route_to("pointsofinterests#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/pointsofinterests/1").to route_to("pointsofinterests#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/pointsofinterests/1").to route_to("pointsofinterests#destroy", :id => "1")
    end

  end
end
