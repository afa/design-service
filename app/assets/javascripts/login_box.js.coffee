//= require ajax_submit
//= require fly_window

reg_stage_2 = (data, status, xhr) ->
  close_fly_window()
  $(data.stage2).appendTo($(".black_content_blocks"))
  show_fly_window('#register_stage2')
  return false

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

  $('body.unregistered form#new_user input.submit_button').click ->
    event.preventDefault()
    ajax_sendform($(event.target).closest('form'), 'POST', success: reg_stage_2)
