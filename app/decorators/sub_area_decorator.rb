class SubAreaDecorator < ApplicationDecorator
  decorates :sub_area

  def editor_links
    if current_user
      link_to(image_tag('whiteplus.png'), new_policy_area_sub_area_topic_path(model.policy_area, model), class: 'plus_button') +
        #link_to(image_tag('whitequestionmark.png')) +
        link_to(image_tag('whiteedit.png')) +
        check_box_tag('sub_area_selected', model.id, false, class: 'sub_category_checkbox')
    end
  end
end
