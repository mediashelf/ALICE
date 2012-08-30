class CreateTableAssetsTopics < ActiveRecord::Migration
  def change
    create_table :assets_topics, id: false do |t|
      t.integer :asset_id
      t.integer :topic_id
    end
    add_index :assets_topics, [:topic_id, :asset_id]
    add_index :assets_topics, [:asset_id, :topic_id]
  end
end
