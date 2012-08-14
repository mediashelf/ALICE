class Asset < ActiveRecord::Base
  attr_accessible :asset, :format, :keywords, :level, :policy_area, :source, :state, :sub_area, :summary, :title, :topic, :type_of, :year

  after_save :index_record
  before_destroy :remove_from_index

  def to_solr
    { 'id' => self.id, 'topic_texts' => self.topic, 'summary_texts' => self.summary }
  end

private

  SolrService = RSolr.connect(url: 'http://127.0.0.1:8983/solr')

  def index_record
    SolrService.add(self.to_solr)
    SolrService.commit
  end

  def remove_from_index
    SolrService.delete_by_id(self.id)
    SolrService.commit
  end
end
