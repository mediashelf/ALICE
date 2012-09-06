# Need way to find way to stub current_user and RoleMapper in order to run these tests
require 'spec_helper'

describe CatalogHelper do
  
  describe "has_search_parameters?" do
    before do
    end
    it "should return true when f_inclusive is set" do
      helper.has_search_parameters?.should be_false
      params[:f_inclusive] = {:state_sms=>["California", "Arizona"]}
      helper.has_search_parameters?.should be_true
    end
  end
end
