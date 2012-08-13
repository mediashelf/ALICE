require 'spec_helper'

describe Topic do
  subject { FactoryGirl.create :topic }

  its(:name) { should == 'test name' }
  its(:description) { should == 'test description' }
end
