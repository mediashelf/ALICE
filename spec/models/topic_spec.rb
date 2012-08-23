require 'spec_helper'

describe Topic do
  subject { FactoryGirl.create :topic }
  it { should have_and_belong_to_many(:sub_areas) }
  it { should validate_uniqueness_of :name }

  its(:name) { should == 'test name' }
  its(:description) { should == 'test description' }
end
