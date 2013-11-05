//= require fly_window

$(document).ready ->
  $(".login_panel .registration").click ->
    show_fly_window('#register')
    event.preventDefault()

  $(".login_panel .login").click ->
    show_fly_window('#login')
    event.preventDefault()

  $('.goto_register').click ->
    show_fly_window('#register')

  $('.goto_login').click ->
    show_fly_window('#login')
