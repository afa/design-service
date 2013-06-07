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

  register_form = ->
    $('form #postRequest').click ->
      unless $(this).closest('form').get(0).checkValidity()
        return false

      $(this).closest('form').ajaxSubmit
        beforeSubmit: (a,f,o)->
          o.dataType = 'json'
        complete: (XMLHttpRequest, textStatus)->
          if XMLHttpRequest.status == 200 || XMLHttpRequest.status == 201
            inp = $('form input[type=file]')
            $('form').replaceWith(XMLHttpRequest.responseText)
            $('form input[type=file]').replaceWith(inp)
            $('form #postRequest').click ->
              $(this).closest('form').ajaxSubmit
                beforeSubmit: (a,f,o)->
                  o.dataType = 'json'
                complete: (XMLHttpRequest, textStatus)->
                  ;

  register_form()