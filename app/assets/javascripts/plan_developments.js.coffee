# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

//= require drag_n_drop
//= require price_calculator
//= require ajax_submit

$(document).ready ->
  order_form = $('form#all_forms')
  attach_box = $('.attach_box')
  attach_form = attach_box.find('form')
  attach_box.offset( order_form.find('.attach_place_for_box').offset() )
  attachment_and_form_ajax_submission(
      order_form
      attach_form
      order_form.find('.postRequest')
      $('.loaded_files.enabled')
  )

  $('.loaded_files.enabled').on 'change', ->
    register_destroy_attachment_buttons()
  register_destroy_attachment_buttons()
  register_drag_n_drop(attach_box.find('.dropZone'), attach_form.find('input[type=file]'), attach_box.find('.hint'))

  # register_price_calculator($('.calcContainer'), 5000)
