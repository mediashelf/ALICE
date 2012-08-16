class ChangeAssetSummaryToText < ActiveRecord::Migration
  def up
    change_column :assets, :summary, :text
  end

  def down
    change_column :assets, :summary, :string
  end
end
