require "rails_helper"

RSpec.describe PicnicgrovesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/picnicgroves").to route_to("picnicgroves#index")
    end

    it "routes to #new" do
      expect(:get => "/picnicgroves/new").to route_to("picnicgroves#new")
    end

    it "routes to #show" do
      expect(:get => "/picnicgroves/1").to route_to("picnicgroves#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/picnicgroves/1/edit").to route_to("picnicgroves#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/picnicgroves").to route_to("picnicgroves#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/picnicgroves/1").to route_to("picnicgroves#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/picnicgroves/1").to route_to("picnicgroves#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/picnicgroves/1").to route_to("picnicgroves#destroy", :id => "1")
    end

  end
end
