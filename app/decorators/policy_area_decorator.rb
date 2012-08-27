class PolicyAreaDecorator < ApplicationDecorator
  decorates :policy_area

  def editor_links
    if current_user
      link_to(image_tag('whiteplus.png'), new_policy_area_sub_area_path(model), class: 'plus_button') +
        #link_to(image_tag('whitequestionmark.png')) +
        link_to(image_tag('whiteedit.png')) +
        check_box_tag('policy_area_selected', model.id, false, class: 'sub_category_checkbox')
    end
  end
end
