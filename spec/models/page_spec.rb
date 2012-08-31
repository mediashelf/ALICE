require 'spec_helper'

describe Page do
  context 'factories are valid' do
    subject { FactoryGirl.build :page }
    it { should be_valid }
  end
end
