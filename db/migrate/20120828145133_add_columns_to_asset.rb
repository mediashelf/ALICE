class AddColumnsToAsset < ActiveRecord::Migration
  def change
    add_column :assets, :bill_number, :string
    add_column :assets, :external_link_to_asset, :string
    add_column :assets, :short_title, :string
    add_column :assets, :source_website, :string
    add_column :assets, :web_folder_link_to_asset_pdf, :string
    add_column :assets, :web_folder_link_to_asset_word_doc, :string
    add_column :assets, :web_folder_link_to_bill_pdf, :string
    add_column :assets, :web_folder_link_to_bill_word_doc, :string

    add_column :assets, :alternative_terms, :text
    add_column :assets, :legislative_history, :text
    add_column :assets, :notes, :text
  end
end
