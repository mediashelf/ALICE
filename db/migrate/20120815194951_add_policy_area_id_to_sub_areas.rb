class AddPolicyAreaIdToSubAreas < ActiveRecord::Migration
  def change
    add_column :sub_areas, :policy_area_id, :integer
    add_index :sub_areas, :policy_area_id
  end
end
