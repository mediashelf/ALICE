require 'spec_helper'

describe PolicyArea do
  subject { FactoryGirl.create :policy_area }

  its(:name) { should == 'policy area name' }
  its(:description) { should == 'policy area description' }
end
