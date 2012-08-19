require 'spec_helper'

describe Asset do
  let(:shark_asset) { FactoryGirl.build :asset, topic: 'Shark Week',
                      summary: 'I love sharks', asset_file: asset_file }
  let(:asset_file) { nil }
  let(:solr) { RSolr.connect(url: 'http://localhost:8983/solr') }

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
      let(:asset_file) { File.new(File.expand_path(File.join(Rails.root, 'support', 'fake.pdf'))) }
      let(:string_only_in_pdf) { 'truthfulness' }

      it 'should store text version of PDF contents to content field' do
        search_returns_results_for?(string_only_in_pdf).should be_true
      end
    end
  end

  def search_returns_results_for? search_text
    solr.get('select', params: {q: search_text, qt: 'standard'})['response']['numFound'] > 0
  end
end
