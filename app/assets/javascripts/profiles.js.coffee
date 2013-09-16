# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

//= require completion_percent
//= require orders
//= require ajax_submit

$(document).ready ->
  $('.presentage_blocks').each ->
    draw_percentage_box(this, '.value_present', '.presentage')
