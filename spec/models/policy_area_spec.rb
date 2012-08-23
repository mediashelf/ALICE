require 'spec_helper'

describe PolicyArea do
  subject { FactoryGirl.create :policy_area }
  it { should have_many(:sub_areas) }
  it { should validate_uniqueness_of :name }

  its(:name) { should == 'policy area name' }
  its(:description) { should == 'policy area description' }
end
