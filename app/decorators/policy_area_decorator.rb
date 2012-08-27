class PolicyAreaDecorator < ApplicationDecorator
  decorates :policy_area

  def editor_links
    if current_user
      link_to image_tag('whiteplus.png'), new_policy_area_sub_area_path(model), id: 'plus_button'
    end
  end
end
