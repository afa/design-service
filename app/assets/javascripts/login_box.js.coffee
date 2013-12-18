//= require ajax_submit
//= require fly_window

reg_stage_2 = (data, status, xhr) ->
  $(data.stage2).appendTo($(".black_content_blocks"))
  show_fly_window('#register_stage2')
  return false

$(document).ready ->
  $(".login_panel .registration").click ->
    show_fly_window('#register')
    return false

  $(".login_panel .login").click ->
    show_fly_window('#login')
    return false

  $('.goto_register').click ->
    show_fly_window('#register')
    return false

  $('.goto_login').click ->
    show_fly_window('#login')
    return false

  $('body.unregistered form#new_user input.submit_button').click (event) ->
    event.preventDefault()
    ajax_sendform($(event.target).closest('form'), 'POST', success: reg_stage_2)

