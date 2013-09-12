# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

//= require drag_n_drop
//= require price_calculator
//= require ajax_submit

$(document).ready ->
  order_form = $('form#all_forms')
  attach_box = $('.attach_box')
  attach_form= attach_box.find('form')
  attach_box.offset( order_form.find('.attach_place_for_box').offset() )
  $('.attach_place_for_box').after($('.loaded_files'))
  attachment_and_form_ajax_submission(
      order_form
      attach_form
      order_form.find('.postRequest')
      $('.loaded_files')
  )

  $('.loaded_files').on 'change', ->
    register_destroy_attachment_buttons()
  register_destroy_attachment_buttons()
  register_drag_n_drop(attach_box.find('.dropZone'), attach_form.find('input[type=file]'), attach_box.find('.hint'))

  $(".warning_show").click ->
    checker = $(this).is(':checked');
    li_near = $(this).parent().next('li');
    if checker is true
      li_near.css("display","block");
    else
      li_near.css("display","none");






