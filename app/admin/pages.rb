ActiveAdmin.register Page do
  show do
    h1 do
      page.title
    end
    div do
      page.body
    end
    div do
      strong do
        'Position in navigation'
      end
      div do
        page.position
      end
    end
    panel 'Children' do
      table_for page.children do
        column :name do |sub_page|
          link_to sub_page.title, admin_page_path(sub_page)
        end
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :parent
      f.input :position, label: 'Position in navigation'
      f.input :body, input_html: {class: 'wysiwyg_editor'}
    end
    f.actions
  end
end
