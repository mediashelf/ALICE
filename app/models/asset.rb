class Asset < ActiveRecord::Base
  mount_uploader :asset_file, AssetUploader

  attr_accessible :alternative_terms, :asset_file, :bill_number, :content, :external_link_to_asset, :format, :legislative_history, :level, :notes, :policy_area, :short_title, :source, :source_website, :state, :sub_area, :summary, :title, :topic, :type_of, :web_folder_link_to_asset_pdf, :web_folder_link_to_asset_word_doc, :web_folder_link_to_bill_pdf, :web_folder_link_to_bill_word_doc, :year

  validates_presence_of :title, :topic, :summary

  before_save :extract_content_from_asset_file
  after_save :index_record
  before_destroy :remove_from_index

  def to_solr
    { 'id' => id,
      'alternative_terms_texts' => alternative_terms,
      'bill_number_texts' => bill_number,
      'content_texts' => content,
      'format_texts' => format,
      'level_texts' => level,
      'policy_area_texts' => policy_area,
      'short_title_texts' => short_title,
      'source_texts' => source,
      'state_texts' => state,
      'sub_area_texts' => sub_area,
      'summary_texts' => summary,
      'title_texts' => title,
      'title_display' => title,
      'topic_texts' => topic,
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

  def extract_content_from_asset_file
    if asset_file.present?
      self.content = `pdftotext #{File.expand_path(asset_file.path)} -`
                       .force_encoding('ISO-8859-1')
                       .encode('utf-8', replace: nil)
                       .gsub("\n", ' ')
    end
  end
end
