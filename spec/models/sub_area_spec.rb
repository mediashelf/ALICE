require 'spec_helper'

describe SubArea do
  subject { FactoryGirl.create :sub_area }
  it { should belong_to(:policy_area) }
  it { should have_and_belong_to_many(:topics) }

  its(:name) { should == 'sub area name' }
  its(:description) { should == 'sub area description' }
end
