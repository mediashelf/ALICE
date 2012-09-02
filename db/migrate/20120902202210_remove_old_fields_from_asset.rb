class RemoveOldFieldsFromAsset < ActiveRecord::Migration
  def up
    remove_column :assets, :policy_area
    remove_column :assets, :sub_area
    remove_column :assets, :topic
    remove_column :assets, :web_folder_link_to_asset_pdf
    remove_column :assets, :web_folder_link_to_asset_word_doc
    remove_column :assets, :web_folder_link_to_bill_pdf
    remove_column :assets, :web_folder_link_to_bill_word_doc
  end

  def down
    add_column :assets, :policy_area, :string
    add_column :assets, :sub_area, :string
    add_column :assets, :topic, :string
    add_column :assets, :web_folder_link_to_asset_pdf, :string
    add_column :assets, :web_folder_link_to_asset_word_doc, :string
    add_column :assets, :web_folder_link_to_bill_pdf, :string
    add_column :assets, :web_folder_link_to_bill_word_doc, :string
  end
end
