# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

//= require chat
//= require completion_percent
//= require date_selector
//= require order_profiles

$(document).ready () ->
  $(".left_msg_area .def_msg").add(".left_msg_area .msg_content").on 'click', () ->
    oid = $(event.target).closest(".left_msg_area").attr("data")
    show_fly_window_from_url oid
