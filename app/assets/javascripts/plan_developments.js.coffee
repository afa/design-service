# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

//= require multiple_file_drop
//= require price_calculator
//= require register_ajax_submit

$(document).ready ->
  filegrabber = $('.multiattach')
  unless filegrabber.size() == 0
    registerDropZoneMultipleFileHandlers(filegrabber)

  register_price_calculator($('.calcContainer'), 5000)
  register_ajax_submit('.multiattach .loaded_files', 'form#all_forms .postRequest')
