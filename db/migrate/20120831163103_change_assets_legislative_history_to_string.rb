class ChangeAssetsLegislativeHistoryToString < ActiveRecord::Migration
  def up
    change_column :assets, :legislative_history, :string
  end

  def down
    change_column :assets, :legislative_history, :text
  end
end
