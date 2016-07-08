require "rails_helper"

RSpec.describe TrailsInfosController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/trails_infos").to route_to("trails_infos#index")
    end

    it "routes to #new" do
      expect(:get => "/trails_infos/new").to route_to("trails_infos#new")
    end

    it "routes to #show" do
      expect(:get => "/trails_infos/1").to route_to("trails_infos#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/trails_infos/1/edit").to route_to("trails_infos#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/trails_infos").to route_to("trails_infos#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/trails_infos/1").to route_to("trails_infos#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/trails_infos/1").to route_to("trails_infos#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/trails_infos/1").to route_to("trails_infos#destroy", :id => "1")
    end

  end
end
