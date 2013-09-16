# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

//= require orders
//= require ajax_submit

$(document).ready ->
  $('.specialist_img_').click ->
    $('body').animate({scrollTop:0},"slow")
    show_fly_window('.avatar_form')

  $('.change_text.bio_info').click ->
    $('body').animate({scrollTop:0},"slow")
    show_fly_window('.bio_info_form')

  $('.change_text.work_info').click ->
    $('body').animate({scrollTop:0},"slow")
    show_fly_window('.work_info_form')

  fill_specialist_info = (profile)->
    $('.info_specialist p.bio_info').text(profile['bio_info'])
    $('.info_specialist p.work_info').text(profile['work_info'])

  $('.bio_info_form .submit').data('ajax-success', (data, status, xhr)->
    fill_specialist_info(data)
    close_fly_window()
  )
  $('.work_info_form .submit').data('ajax-success', (data, status, xhr)->
    fill_specialist_info(data)
    close_fly_window()
  )
