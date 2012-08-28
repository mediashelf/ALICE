class RemoveKeywordsFromAssets < ActiveRecord::Migration
  def up
    remove_column :assets, :keywords
  end

  def down
    add_column :assets, :keywords, :string
  end
end
