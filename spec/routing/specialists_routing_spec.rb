require "spec_helper"

describe SpecialistsController do
  describe "routing" do

    it "routes to #index" do
      get("/specialists").should route_to("specialists#index")
    end

    it "routes to #new" do
      get("/specialists/new").should route_to("specialists#new")
    end

    it "routes to #show" do
      get("/specialists/1").should route_to("specialists#show", :id => "1")
    end

    it "routes to #edit" do
      get("/specialists/1/edit").should route_to("specialists#edit", :id => "1")
    end

    it "routes to #create" do
      post("/specialists").should route_to("specialists#create")
    end

    it "routes to #update" do
      put("/specialists/1").should route_to("specialists#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/specialists/1").should route_to("specialists#destroy", :id => "1")
    end

  end
end
