ActiveAdmin.register Asset do
  index do
    #column :policy_area
    #column :sub_area
    #column :topic
    column :title
    default_actions
  end

  show title: :title do
    attributes_table do
      row :id
      #row :policy_area
      #row :sub_area
      #row :topic
      #row :topic_ids
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

      row :alternative_terms
      row :legislative_history
      row :notes

      row :asset_file do |asset|
        link_to 'Download', asset.asset_file.url
      end

      row :asset_word do |asset|
        link_to 'Download', asset.asset_word.url
      end

      row :bill_pdf do |asset|
        link_to 'Download', asset.bill_pdf.url
      end

      row :bill_word do |asset|
        link_to 'Download', asset.bill_word.url
      end

      row :content do |asset|
        div class: 'asset_content' do
          asset.content
        end
      end

      row :bill_pdf_content do |asset|
        div class: 'asset_content' do
          asset.bill_pdf_content
        end
      end

      panel 'Topics' do
        table_for asset.topics do
          column :name do |topic|
            link_to topic.name, admin_topic_path(topic)
          end
        end
      end
    end

  end

  form do |f|
    f.inputs do
      f.input :topics, as: :select, collection: options_from_collection_for_select(Topic.all, 'id', 'name', asset.topic_ids)
      #f.input :policy_area
      #f.input :sub_area
      #f.input :topic
      f.input :title
      f.input :short_title
      f.input :year, :as => :select, :collection=>((y = Date.today.year - 200 ) .. y+205).to_a.reverse, :input_html=>{:'data-placeholder'=>"Year", :style=>"width:350px;", :class=>"chzn-select"}
      f.input :bill_number
      f.input :source
      f.input :state_multiple, :label=>"State(s)", :as=>:select, :collection=>us_states, :multiple=>true, :input_html=>{:'data-placeholder'=>"Choose a state...", :style=>"width:350px;", :class=>"chzn-select"}
      f.input :format
      f.input :level
      f.input :type_of
      f.input :summary
      f.input :external_link_to_asset
      f.input :source_website

      f.input :alternative_terms
      f.input :legislative_history
      f.input :notes

      if asset.asset_file?
        f.input :asset_file, label: "Current Asset PDF: #{asset.asset_file.path.split('/').last}"
      else
        f.input :asset_file, label: 'Upload Asset PDF:'
      end

      if asset.asset_word?
        f.input :asset_word, label: "Current Word Asset: #{asset.asset_word.path.split('/').last}"
      else
        f.input :asset_word, label: 'Upload Word Asset:'
      end

      if asset.bill_pdf?
        f.input :bill_pdf, label: "Current Bill PDF: #{asset.bill_pdf.path.split('/').last}"
      else
        f.input :bill_pdf, label: 'Upload Bill PDF:'
      end

      if asset.bill_word?
        f.input :bill_word, label: "Current Word Bill: #{asset.bill_word.path.split('/').last}"
      else
        f.input :bill_word, label: 'Upload Word Bill:'
      end

      f.input :content, disabled: true
      f.input :bill_pdf_content, disabled: true
    end
    f.actions
  end
end
