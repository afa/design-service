# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

//= require single_file_drop
//= require price_calculator
//= require register_ajax_submit

$(document).ready ->
  filegrabber = $('.singleattach')
  unless filegrabber.size() == 0
    registerDropZoneSingleFileHandlers(filegrabber)

  register_price_calculator($('.calcContainer'), 5000)

  register_ajax_submit('.singleattach', 'form .postRequest')