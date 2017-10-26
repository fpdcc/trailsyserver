require "rails_helper"

RSpec.describe NewTrailsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/new_trails").to route_to("new_trails#index")
    end

    it "routes to #new" do
      expect(:get => "/new_trails/new").to route_to("new_trails#new")
    end

    it "routes to #show" do
      expect(:get => "/new_trails/1").to route_to("new_trails#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/new_trails/1/edit").to route_to("new_trails#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/new_trails").to route_to("new_trails#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/new_trails/1").to route_to("new_trails#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/new_trails/1").to route_to("new_trails#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/new_trails/1").to route_to("new_trails#destroy", :id => "1")
    end

  end
end
