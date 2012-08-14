require 'spec_helper'

describe Asset do
  let(:shark_asset) { FactoryGirl.build :asset, topic: 'Shark Week', summary: 'I love sharks' }

  before do
    r = RSolr.connect(url: 'http://localhost:8983/solr')
    r.delete_by_query('*:*')
    r.commit
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
  end

  def search_returns_results_for? search_text
    r = RSolr.connect(url: 'http://localhost:8983/solr')
    resp = r.get('select', params: { q: '*:*', qt: 'standard' })['response']
    resp['docs'].count > 0
  end
end
