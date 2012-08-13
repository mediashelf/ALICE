require 'spec_helper'

describe SubArea do
  subject { FactoryGirl.create :sub_area }

  its(:name) { should == 'sub area name' }
  its(:description) { should == 'sub area description' }
end
