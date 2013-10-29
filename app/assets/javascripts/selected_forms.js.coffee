# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

//= require orderable

$(document).ready ->
  #////IMAGE HOVER///
  $(".img_").mouseenter ->
    $(this).parent().find(".heading").addClass "heading_h"
    $(this).parent().find(".black_opacity").addClass "black_opacity_on"
  $(".black_opacity").mouseleave ->
    $(".black_opacity_on").removeClass "black_opacity_on"
    $(this).parent().parent().find(".heading").removeClass "heading_h"

  #////KEY_BOARD///
  $(".color_keyboard ul li").click ->
    $("div.color_keyboard ul *").removeClass "selected"
    $("#selected_color").val $(this).attr("value")
    $(this).addClass "selected"
  $(".color_keyboard").find("ul li").each ->
    if($(this).attr('value')==$("#selected_color").val())
      $(this).addClass "selected"

  #////RADIO BUTTONS ANY FIELD///

  # room materials
  $(document).on 'nested:fieldAdded', (event)->
    field = event.field
    room_name_field = field.find('.room_name')
    room_name_field.val('например, Кухня')
    room_name_field.css('color','#999999')

  $('.rooms').on 'change', '.fields', ->
    unless $(this).next().is('.fields')
      $('.add_room').click()
    false

  $('.rooms').on 'change blur', '.room_name', ->
    if $(this).val().length == 0
      $(this).val('например, Кухня');
      $(this).css('color','#999999');

  $('.rooms').on 'focusin', '.room_name', ->
    if $(this).val() == 'например, Кухня'
      $(this).val('');
      $(this).css('color','#000000');

  $('.add_room').click() # one empty room to fill (should be done after nested:fieldAdded handler created)
