class TopicDecorator < ApplicationDecorator
  decorates :topic

  def editor_links
    if current_user
      link_to(image_tag('whiteedit.png'), edit_topic_path(model), class: 'edit_button') +
      check_box_tag('topic_selected', model.id, false, class: 'topic_checkbox')
    end
  end
end
