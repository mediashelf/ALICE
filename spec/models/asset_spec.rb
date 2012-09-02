require 'spec_helper'

describe Asset do
  let(:shark_policy_area) { FactoryGirl.create :policy_area, name: 'Shark Policy Area' }
  let(:shark_sub_area) { FactoryGirl.create :sub_area, name: 'Shark Sub Area', policy_area: shark_policy_area }
  let(:shark_topic) { FactoryGirl.create :topic, name: 'Crazy Shark Topic', sub_areas: [shark_sub_area] }
  let(:another_shark_topic) { FactoryGirl.create :topic, name: 'Sharks Rule' }
  let(:shark_asset) { FactoryGirl.build :asset,
                        title: 'Shark Week',
                        summary: 'I love sharks',
                        asset_file: asset_file,
                        topics: [shark_topic, another_shark_topic] }

  let(:asset_file) { File.new(File.expand_path(File.join(Rails.root, 'support', 'fake.pdf'))) }
  let(:solr) { RSolr.connect(url: 'http://localhost:8983/solr') }

  it { should have_and_belong_to_many(:topics) }

  it { should validate_presence_of(:asset_file) }
  it { should validate_presence_of(:format) }
  it { should validate_presence_of(:level) }
  it { should validate_presence_of(:source) }
  it { should_not validate_presence_of(:state) }
  it { should validate_presence_of(:summary) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:topic_ids) }
  it { should validate_presence_of(:type_of) }
  it { should validate_presence_of(:year) }

  before do
    solr.delete_by_query('*:*')
    solr.commit
    solr.get('select')['response']['numFound'].should == 0
  end

  context 'before save' do
    it 'should not be indexed' do
      search_returns_results_for?('sharks').should be_false
    end
  end

  context 'on save' do
    before do
      shark_asset.save!
    end
    it 'should be indexed by Solr' do
      search_returns_results_for?('sharks').should be_true
    end
    it 'should be index multiple topics by Solr' do
      search_returns_results_for?('Crazy Shark Topic').should be_true
      search_returns_results_for?('Sharks Rule').should be_true
    end
    it 'should index by sub area' do
      search_returns_results_for?('Shark Sub Area').should be_true
    end
    it 'should index by policy area' do
      search_returns_results_for?('Shark Policy Area').should be_true
    end
    context 'with attached PDF' do
      let(:string_only_in_pdf) { 'truthfulness' }

      it 'should store text version of PDF contents to content field' do
        search_returns_results_for?(string_only_in_pdf).should be_true
      end
    end
    context 'with attached DOC' do
      let(:asset_file) { File.new(File.expand_path(File.join(Rails.root, 'support', 'fake.doc'))) }

      it 'does not extract contents of file' do
        shark_asset.content.should be_nil
      end
    end
  end

  def search_returns_results_for? search_text
    solr.get('select', params: {q: search_text, qt: 'standard'})['response']['numFound'] > 0
  end
end
