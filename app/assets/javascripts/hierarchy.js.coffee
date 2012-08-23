$ ->
  $('.expandable_nav_link').click ->
    coll = $(this).siblings('ol')
    _.map(coll, (e) -> $(e).toggle())

  $('.sub_category_checkbox').change ->
    $(this).parent().toggleClass('selected')
