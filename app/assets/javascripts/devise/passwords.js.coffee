$(document).ready ->
  $('.submit_button').click (event)->
    $(event.target).closest('form').get(0).submit()
