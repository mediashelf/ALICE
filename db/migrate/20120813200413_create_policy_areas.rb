class CreatePolicyAreas < ActiveRecord::Migration
  def change
    create_table :policy_areas do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
