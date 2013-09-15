# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

//= require orderable

$(document).ready ->
  $('.attach_box').append( $('.attach_info_block') )
  $(".warning_show").click ->
    checker = $(this).is(':checked');
    li_near = $(this).parent().next('li');
    if checker is true
      li_near.css("display","block");
    else
      li_near.css("display","none");
