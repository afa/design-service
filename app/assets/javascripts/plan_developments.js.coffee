# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

//= require single_file_drop
//= require price_calculator

$(document).ready ->
  filegrabber = $('.dropZone.single')
  unless filegrabber.size() == 0
    registerDropZoneSingleFileHandlers(filegrabber)

  register_price_calculator($('.calcContainer'), 5000)