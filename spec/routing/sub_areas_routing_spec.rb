require "spec_helper"

describe SubAreasController do
  describe "routing" do

    it "routes to #index" do
      get("/sub_areas").should route_to("sub_areas#index")
    end

    it "routes to #new" do
      get("/sub_areas/new").should route_to("sub_areas#new")
    end

    it "routes to #show" do
      get("/sub_areas/1").should route_to("sub_areas#show", :id => "1")
    end

    it "routes to #edit" do
      get("/sub_areas/1/edit").should route_to("sub_areas#edit", :id => "1")
    end

    it "routes to #create" do
      post("/sub_areas").should route_to("sub_areas#create")
    end

    it "routes to #update" do
      put("/sub_areas/1").should route_to("sub_areas#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/sub_areas/1").should route_to("sub_areas#destroy", :id => "1")
    end

  end
end
