# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

//= require multiple_file_drop
//= require price_calculator

$(document).ready ->
  filegrabber = $('.dropZone.multiple')
  unless filegrabber.size() == 0
    registerDropZoneMultipleFileHandlers(filegrabber)

  register_price_calculator($('.calcContainer'), 5000)

  registerAjaxSubmit = (element_to_restore)->
    $('form #postRequest').click ->
      unless $(this).closest('form').get(0).checkValidity()
        return false

      $(this).closest('form').ajaxSubmit
        beforeSubmit: (a,f,o)->
          o.dataType = 'json'
        complete: (XMLHttpRequest, textStatus)->
          if XMLHttpRequest.status == 200 || XMLHttpRequest.status == 201
            # file inputs lose information when form is replaced
            to_save = $(element_to_restore)
            $('form').replaceWith(XMLHttpRequest.responseText)
            $(element_to_restore).replaceWith(to_save)
            $('form #postRequest').click ->
              unless $(this).closest('form').get(0).checkValidity()
                return false
              $(this).closest('form').ajaxSubmit
                beforeSubmit: (a,f,o)->
                  o.dataType = 'json'
                complete: (XMLHttpRequest, textStatus)->
                  ;

  registerAjaxSubmit('form .dropZone.multiple')