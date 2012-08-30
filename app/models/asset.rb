class Asset < ActiveRecord::Base
  mount_uploader :asset_file, AssetUploader

  attr_accessible :alternative_terms, :asset_file, :bill_number, :content, :external_link_to_asset, :format, :legislative_history, :level, :notes, :policy_area, :short_title, :source, :source_website, :state, :sub_area, :summary, :title, :topic, :type_of, :year

  # Questionable fields
  attr_accessible :web_folder_link_to_asset_pdf, :web_folder_link_to_asset_word_doc, :web_folder_link_to_bill_pdf, :web_folder_link_to_bill_word_doc

  validates_presence_of :title, :topic, :summary, :policy_area, :sub_area, :source, :year, :state, :format, :level, :type_of, :asset_file

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
      'policy_area_ss' => policy_area,
      'short_title_texts' => short_title,
      'source_ss' => source,
      'state_ss' => state,
      'sub_area_ss' => sub_area,
      'summary_texts' => summary,
      'title_texts' => title,
      'topic_ss' => topic,
      'type_of_ss' => type_of,
      'year_is' => year,

      # Display fields
      'title_display' => title,
      'source_website_display' => source_website,
      'external_link_to_asset_display' => external_link_to_asset,
      'legislative_history_display' => legislative_history,
      'notes_display' => notes,

      # Questionable fields
      'web_folder_link_to_asset_pdf_display' => web_folder_link_to_asset_pdf,
      'web_folder_link_to_asset_word_doc_display' => web_folder_link_to_asset_word_doc,
      'web_folder_link_to_bill_pdf_display' => web_folder_link_to_bill_pdf,
      'web_folder_link_to_bill_word_doc_display' => web_folder_link_to_bill_word_doc }
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
