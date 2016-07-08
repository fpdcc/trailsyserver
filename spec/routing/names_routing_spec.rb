require "rails_helper"

RSpec.describe NamesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/names").to route_to("names#index")
    end

    it "routes to #new" do
      expect(:get => "/names/new").to route_to("names#new")
    end

    it "routes to #show" do
      expect(:get => "/names/1").to route_to("names#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/names/1/edit").to route_to("names#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/names").to route_to("names#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/names/1").to route_to("names#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/names/1").to route_to("names#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/names/1").to route_to("names#destroy", :id => "1")
    end

  end
end
