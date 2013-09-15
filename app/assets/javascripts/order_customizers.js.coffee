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

  #///////////
  $(".close_fly_window").click ->
    $(this).parent().css("display", "none").parent().css "display", "none"

  #////KEY_BOARD///
  $(".color_keyboard ul li").click ->
    $("div.color_keyboard ul *").removeClass "selected"
    $("#selected_color").val $(this).attr("value")
    $(this).addClass "selected"

  $('.interior ul li:last-child label').append($('.interior ul + input[type="text"]'))
  $('.interior input[type="text"]').change ->
    $('.interior input[type="radio"]').last().get(0).checked = true
