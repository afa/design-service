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
  attach_box.css("position":"absolute", "top": "300"+"px" ,"z-index": "10", "float":"left","margin-left":"120"+"px" )
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



  #////IMAGE HOVER///
  $(".img_").mouseenter ->
    $(this).parent().find(".heading").addClass "heading_h"
    $(this).parent().find(".black_opacity").addClass "black_opacity_on"

  $(".black_opacity").mouseleave ->
    $(".black_opacity_on").removeClass "black_opacity_on"
    $(this).parent().parent().find(".heading").removeClass "heading_h"

  
  #///////////
  $(".close_fly_window").click ->
    $(this).parent().css("display", "none").parent().css "display", "none"

  #////KEY_BOARD///  
  $(".color_keyboard ul li").click ->
    $("div.color_keyboard ul *").removeClass "selected"
    $("#selected_color").val $(this).attr("value")
    $(this).addClass "selected"  

  $('.interior ul li:last-child label').append($('.interior ul + input[type="text"]')) 