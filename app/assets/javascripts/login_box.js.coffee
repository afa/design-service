//= require fly_window

$(document).ready ->
  $(".login_panel .registration").click ->
    show_fly_window('#register')

  $(".login_panel .login").click ->
    show_fly_window('#login')

  $('.goto_register').click ->
    close_fly_window()  
    if($(this).parent().parent().attr('id')=='register')
      show_fly_window('#login')
    else
      show_fly_window('#register')



