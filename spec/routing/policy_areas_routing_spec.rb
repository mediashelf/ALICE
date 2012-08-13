require "spec_helper"

describe PolicyAreasController do
  describe "routing" do

    it "routes to #index" do
      get("/policy_areas").should route_to("policy_areas#index")
    end

    it "routes to #new" do
      get("/policy_areas/new").should route_to("policy_areas#new")
    end

    it "routes to #show" do
      get("/policy_areas/1").should route_to("policy_areas#show", :id => "1")
    end

    it "routes to #edit" do
      get("/policy_areas/1/edit").should route_to("policy_areas#edit", :id => "1")
    end

    it "routes to #create" do
      post("/policy_areas").should route_to("policy_areas#create")
    end

    it "routes to #update" do
      put("/policy_areas/1").should route_to("policy_areas#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/policy_areas/1").should route_to("policy_areas#destroy", :id => "1")
    end

  end
end
