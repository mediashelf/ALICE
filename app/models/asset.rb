class Asset < ActiveRecord::Base
  mount_uploader :asset_file, AssetUploader

  attr_accessible :asset, :asset_file, :content, :format, :keywords, :level, :policy_area, :source, :state, :sub_area, :summary, :title, :topic, :type_of, :year

  validates_presence_of :title, :topic, :summary

  before_save :extract_content_from_asset_file
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
      'year_is' => year,
      'content_texts' => content }
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

  def extract_content_from_asset_file
    if asset_file.present? && content.nil?
      self.content = `pdftotext #{File.expand_path(asset_file.path)} -`.force_encoding('ISO-8859-1').encode('utf-8', replace: nil).gsub("\n", ' ')
    end
  end
end
