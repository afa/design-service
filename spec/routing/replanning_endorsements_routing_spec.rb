require "spec_helper"

describe ReplanningEndorsementsController do
  describe "routing" do

    it "routes to #index" do
      get("/replanning_endorsements").should route_to("replanning_endorsements#index")
    end

    it "routes to #new" do
      get("/replanning_endorsements/new").should route_to("replanning_endorsements#new")
    end

    it "routes to #show" do
      get("/replanning_endorsements/1").should route_to("replanning_endorsements#show", :id => "1")
    end

    it "routes to #edit" do
      get("/replanning_endorsements/1/edit").should route_to("replanning_endorsements#edit", :id => "1")
    end

    it "routes to #create" do
      post("/replanning_endorsements").should route_to("replanning_endorsements#create")
    end

    it "routes to #update" do
      put("/replanning_endorsements/1").should route_to("replanning_endorsements#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/replanning_endorsements/1").should route_to("replanning_endorsements#destroy", :id => "1")
    end

  end
end
