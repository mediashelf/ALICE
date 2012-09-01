ActiveAdmin.register Topic do
  show title: :name do |topic|
    attributes_table do
      row :name
      row :description
    end

    panel 'Sub Areas' do
      table_for topic.sub_areas do
        column :name do |sub_area|
          link_to sub_area.name, admin_sub_area_path(sub_area)
        end
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :sub_areas, as: :select, collection: options_from_collection_for_select(SubArea.all, 'id', 'select_formatted_name', topic.sub_area_ids)
      f.input :name
      f.input :description
    end
    f.buttons
  end
end
