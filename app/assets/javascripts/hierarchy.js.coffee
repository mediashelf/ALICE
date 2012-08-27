$ ->
  $('li.policy_area.hide_sub_areas > .expandable_nav_link').live 'click', ->
    $(this).parent('li.policy_area').removeClass('hide_sub_areas').addClass('show_sub_areas')

  $('li.policy_area.show_sub_areas > .expandable_nav_link').live 'click', ->
    $(this).parent('li.policy_area').removeClass('show_sub_areas').addClass('hide_sub_areas')

  $('.sub_category_checkbox').change ->
    $(this).parent().toggleClass('selected')
