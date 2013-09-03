require "spec_helper"

describe EngineeringSystemsController do
  describe "routing" do

    it "routes to #index" do
      get("/engineering_systems").should route_to("engineering_systems#index")
    end

    it "routes to #new" do
      get("/engineering_systems/new").should route_to("engineering_systems#new")
    end

    it "routes to #show" do
      get("/engineering_systems/1").should route_to("engineering_systems#show", :id => "1")
    end

    it "routes to #edit" do
      get("/engineering_systems/1/edit").should route_to("engineering_systems#edit", :id => "1")
    end

    it "routes to #create" do
      post("/engineering_systems").should route_to("engineering_systems#create")
    end

    it "routes to #update" do
      put("/engineering_systems/1").should route_to("engineering_systems#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/engineering_systems/1").should route_to("engineering_systems#destroy", :id => "1")
    end

  end
end
