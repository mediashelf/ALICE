require 'spec_helper'

describe "PolicyAreas" do
  describe "GET /policy_areas" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get policy_areas_path
      response.status.should be(200)
    end
  end
end
