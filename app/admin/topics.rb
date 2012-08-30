ActiveAdmin.register Topic do
  show title: :name do |topic|
    attributes_table do
      row :name
      row :description
    end
  end

  form do |f|
    f.inputs do
      f.input :sub_areas, as: :select, collection: options_from_collection_for_select(SubArea.all, 'id', 'select_formatted_name')
      f.input :name
      f.input :description
    end
    f.buttons
  end
end