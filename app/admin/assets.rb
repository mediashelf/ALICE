ActiveAdmin.register Asset do
  index do
    column :policy_area
    column :sub_area
    column :topic
    column :title
    default_actions
  end

  show title: :title do
    attributes_table do
      row :id
      row :policy_area
      row :sub_area
      row :topic
      row :title
      row :short_title
      row :year
      row :bill_number
      row :source
      row :state
      row :format
      row :level
      row :type_of
      row :summary
      row :external_link_to_asset
      row :source_website
      row :web_folder_link_to_asset_pdf
      row :web_folder_link_to_asset_word_doc
      row :web_folder_link_to_bill_pdf
      row :web_folder_link_to_bill_word_doc

      row :alternative_terms
      row :legislative_history
      row :notes

      row :asset_file do |asset|
        link_to 'Download', asset.asset_file.url
      end
      row :content do |asset|
        div class: 'asset_content' do
          asset.content
        end
      end

    end

  end

  form do |f|
    f.inputs do
      f.input :id
      f.input :policy_area
      f.input :sub_area
      f.input :topic
      f.input :title
      f.input :short_title
      f.input :year
      f.input :bill_number
      f.input :source
      f.input :state
      f.input :format
      f.input :level
      f.input :type_of
      f.input :summary
      f.input :external_link_to_asset
      f.input :source_website
      f.input :web_folder_link_to_asset_pdf
      f.input :web_folder_link_to_asset_word_doc
      f.input :web_folder_link_to_bill_pdf
      f.input :web_folder_link_to_bill_word_doc

      f.input :alternative_terms
      f.input :legislative_history
      f.input :notes

      if asset.asset_file?
        f.input :asset_file, label: "Current File: #{asset.asset_file.path.split('/').last}"
      else
        f.input :asset_file, label: 'Upload asset:'
      end

      #f.input :content, disabled: true
      f.input :content
    end
    f.buttons
  end
end
