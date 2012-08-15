class CreateSubAreasTopicsTable < ActiveRecord::Migration
  def change
    create_table :sub_areas_topics, id: false do |t|
      t.references :sub_area
      t.references :topic
    end

    add_index :sub_areas_topics, :sub_area_id
    add_index :sub_areas_topics, :topic_id
  end
end
