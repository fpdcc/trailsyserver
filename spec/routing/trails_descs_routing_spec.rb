require "rails_helper"

RSpec.describe TrailsDescsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/trails_descs").to route_to("trails_descs#index")
    end

    it "routes to #new" do
      expect(:get => "/trails_descs/new").to route_to("trails_descs#new")
    end

    it "routes to #show" do
      expect(:get => "/trails_descs/1").to route_to("trails_descs#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/trails_descs/1/edit").to route_to("trails_descs#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/trails_descs").to route_to("trails_descs#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/trails_descs/1").to route_to("trails_descs#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/trails_descs/1").to route_to("trails_descs#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/trails_descs/1").to route_to("trails_descs#destroy", :id => "1")
    end

  end
end
