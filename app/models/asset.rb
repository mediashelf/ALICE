class Asset < ActiveRecord::Base
  mount_uploader :asset_file, AssetUploader

  attr_accessible :asset, :asset_file, :format, :keywords, :level, :policy_area, :source, :state, :sub_area, :summary, :title, :topic, :type_of, :year

  validates_presence_of :title, :topic, :summary
  after_save :index_record
  before_destroy :remove_from_index

  def to_solr
    { 'id' => id,
      'topic_texts' => topic,
      'summary_texts' => summary,
      'asset_texts' => asset,
      'format_texts' => format,
      'keywords_texts' => keywords,
      'level_texts' => level,
      'source_texts' => source,
      'state_texts' => state,
      'policy_area_texts' => policy_area,
      'sub_area_texts' => sub_area,
      'title_texts' => title,
      'type_of_texts' => type_of,
      'year_is' => year }
  end

private

  def index_record
    SolrService.add(self.to_solr)
    SolrService.commit
  end

  def remove_from_index
    SolrService.delete_by_id(self.id)
    SolrService.commit
  end
end
