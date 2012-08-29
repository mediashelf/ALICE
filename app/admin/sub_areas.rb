ActiveAdmin.register SubArea do
  show title: :name do |sub_area|
    attributes_table do
      row :name
      row :description
    end

    panel 'Topics' do
      table_for sub_area.topics do
        column :name do |topic|
          link_to topic.name, admin_topic_path(topic)
        end
      end
    end
  end
end
