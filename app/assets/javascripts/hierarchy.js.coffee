$ ->
  $('li.policy_area.hide_sub_areas > .expandable_nav').live 'click', ->
    $(this).parent('li.policy_area').removeClass('hide_sub_areas').addClass('show_sub_areas')

  $('li.policy_area.show_sub_areas > .expandable_nav').live 'click', ->
    $(this).parent('li.policy_area').removeClass('show_sub_areas').addClass('hide_sub_areas')

  $('li.sub_area.hide_topics > .expandable_nav').live 'click', ->
    $(this).parent('li.sub_area').removeClass('hide_topics').addClass('show_topics')

  $('li.sub_area.show_topics > .expandable_nav').live 'click', ->
    $(this).parent('li.sub_area').removeClass('show_topics').addClass('hide_topics')

  $('.sub_category_checkbox').change ->
    $(this).parent().toggleClass('selected')
