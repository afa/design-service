# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

//= require multiple_file_drop

$(document).ready ->
  filegrabber = $('.dropZone.multiple')
  unless filegrabber.size() == 0
    registerDropZoneMultipleFileHandlers(filegrabber)