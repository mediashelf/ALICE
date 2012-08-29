ActiveAdmin.register PolicyArea do
  show title: :name do |policy_area|
    attributes_table do
      row :name
      row :description
    end

    panel 'Sub Areas' do
      table_for policy_area.sub_areas do
        column :name do |sub_area|
          link_to sub_area.name, admin_sub_area_path(sub_area)
        end
      end
    end
  end
end
