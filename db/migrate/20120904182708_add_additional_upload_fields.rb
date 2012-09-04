class AddAdditionalUploadFields < ActiveRecord::Migration
  def change
    add_column :assets, :bill_pdf, :string
    add_column :assets, :bill_pdf_content, :text
    add_column :assets, :bill_word, :string
    add_column :assets, :asset_word, :string
  end
end
