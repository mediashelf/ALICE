class Asset < ActiveRecord::Base
  mount_uploader :asset_file, AssetUploader

  has_and_belongs_to_many :topics

  attr_accessible :alternative_terms, :asset_file, :bill_number, :content, :external_link_to_asset, :format, :legislative_history, :level, :notes, :short_title, :source, :source_website, :state, :summary, :title, :type_of, :year, :topic_ids

  validates_presence_of :title, :summary, :source, :year, :format, :level, :type_of, :asset_file, :topic_ids

  before_save :extract_content_from_asset_file
  after_save :index_record
  before_destroy :remove_from_index

  def to_solr
    { 'id' => id,
      # Searched by Solr
      'alternative_terms_texts' => alternative_terms,
      'bill_number_texts' => bill_number,
      'content_texts' => content,
      'format_ss' => format,
      'level_ss' => level,
      'policy_area_texts' => indexed_policy_areas,
      'short_title_texts' => short_title,
      'source_ss' => source,
      'state_ss' => state,
      'sub_area_texts' => indexed_sub_areas,
      'summary_texts' => summary,
      'title_texts' => title,
      'topic_texts' => indexed_topics,
      'type_of_ss' => type_of,
      'year_is' => year,

      # Display fields
      'title_display' => title,
      'source_website_display' => source_website,
      'external_link_to_asset_display' => external_link_to_asset,
      'legislative_history_display' => legislative_history,
      'notes_display' => notes,

      # Facet fields
      'policy_area_facet' => indexed_policy_areas,
      'sub_area_facet' => indexed_sub_areas,
      'topic_facet' => indexed_topics }
  end

  def indexed_topics
    topics.map(&:name)
  end

  def indexed_sub_areas
    topics.map(&:sub_areas).flatten.uniq.map(&:name)
  end

  def indexed_policy_areas
    topics.map(&:sub_areas).flatten.uniq.map do |sub_area|
      sub_area.policy_area.name
    end
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
    if asset_file.present? && (asset_file.path.split(".").last == 'pdf')
      self.content = `pdftotext #{File.expand_path(asset_file.path)} -`
                       .force_encoding('ISO-8859-1')
                       .encode('utf-8', replace: nil)
                       .gsub("\n", ' ')
    end
  end
end
