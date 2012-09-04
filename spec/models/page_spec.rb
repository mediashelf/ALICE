require 'spec_helper'

describe Page do
  context 'factories are valid' do
    subject { build :page }
    it { should be_valid }
  end

  context 'navigation order' do

    context 'automatic ordering' do
      let(:alpha) { create :page }
      let(:beta) { create :page }

      it 'beta follows alpha' do
        alpha.position.should == 1
        beta.position.should == 2
      end
    end

    context 'children have their own ordering' do
      let(:parent) { create :page }
      let(:child)  { create :page, parent: parent }
      let(:second_child)  { create :page, parent: parent }

      it 'children position scoped by parent' do
        parent.position.should == 1
        child.position.should == 1
        second_child.position.should == 2
      end
    end

    context 'updating position updates siblings' do
      let(:alpha) { create :page }
      let(:beta) { create :page }

      before do
        beta.position = 1
        beta.save
      end

      it 'pushes sibling down' do
        alpha.position.should == 2
      end
    end

    context 'adding new page increments position' do
      let!(:alpha) { create :page, position: 459 }
      let(:beta) { create :page }

      it 'has next position' do
        beta.position.should == 460
      end

    end
  end
end
