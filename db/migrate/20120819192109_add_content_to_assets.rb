class AddContentToAssets < ActiveRecord::Migration
  def change
    add_column :assets, :content, :text
  end
end
