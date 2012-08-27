class SubAreaDecorator < ApplicationDecorator
  decorates :sub_area

  def editor_links
    if current_user
      link_to(image_tag('whiteplus.png'), new_topic_path, class: 'plus_button') +
        #link_to(image_tag('whitequestionmark.png')) +
        link_to(image_tag('whiteedit.png')) +
        check_box_tag('sub_area_selected', model.id, false, class: 'sub_category_checkbox')
    end
  end
end
