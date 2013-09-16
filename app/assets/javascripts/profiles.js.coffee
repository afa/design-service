# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

//= require orders
//= require ajax_submit

$(document).ready ->
  $('.change_text.bio_info').click ->
    show_fly_window('.bio_info_form')
  $('.change_text.work_info').click ->
    show_fly_window('.work_info_form')
