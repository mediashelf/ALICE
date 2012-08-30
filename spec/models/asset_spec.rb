require 'spec_helper'

describe Asset do
  let(:shark_asset) { FactoryGirl.build :asset,
                        topic: 'Shark Week',
                        summary: 'I love sharks',
                        asset_file: asset_file }

  let(:asset_file) { File.new(File.expand_path(File.join(Rails.root, 'support', 'fake.pdf'))) }
  let(:solr) { RSolr.connect(url: 'http://localhost:8983/solr') }

  it { should have_and_belong_to_many(:topics) }
  it { should validate_presence_of(:policy_area) }
  it { should validate_presence_of(:sub_area) }
  it { should validate_presence_of(:source) }
  it { should validate_presence_of(:year) }
  it { should validate_presence_of(:state) }
  it { should validate_presence_of(:format) }
  it { should validate_presence_of(:level) }
  it { should validate_presence_of(:type_of) }
  it { should validate_presence_of(:asset_file) }
  it { should validate_presence_of(:topic) }
  it { should validate_presence_of(:summary) }
  it { should validate_presence_of(:title) }

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
