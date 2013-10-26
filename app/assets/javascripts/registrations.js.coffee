//= require login_box

$(document).ready ->
  if $('body').is('.create_action, .new_action')
    show_fly_window('#register')
