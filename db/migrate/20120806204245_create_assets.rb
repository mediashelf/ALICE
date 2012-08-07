class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.string :policy_area
      t.string :sub_area
      t.string :topic
      t.string :asset
      t.string :title
      t.integer :year
      t.string :source
      t.string :state
      t.string :format
      t.string :level
      t.string :type_of
      t.string :keywords
      t.string :summary

      t.timestamps
    end
  end
end
