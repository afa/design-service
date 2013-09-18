//= require fly_window

$(document).ready ->
  $(".login_panel .registration").click ->
    show_fly_window('#register')

  $(".login_panel .login").click ->
    show_fly_window('#login')
