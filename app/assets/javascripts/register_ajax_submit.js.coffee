# Here we should use string of query as an argument, not an element because after form reloading we need to search an element again
window.register_ajax_submit = (element_to_restore, submit_button)->
  $(submit_button).click ->
    unless $(this).closest('form').get(0).checkValidity()
      return false

    $(this).closest('form').ajaxSubmit
      beforeSubmit: (a,f,o)->
        o.dataType = 'json'
      complete: (XMLHttpRequest, textStatus)->
        if XMLHttpRequest.status == 200 || XMLHttpRequest.status == 201
          # file inputs lose information when form is replaced
          to_save = $(element_to_restore)
          $(element_to_restore).closest('form').replaceWith(XMLHttpRequest.responseText)
          $(element_to_restore).replaceWith(to_save)
          $(submit_button).click ->
            unless $(this).closest('form').get(0).checkValidity()
              return false
            $(this).closest('form').ajaxSubmit
              beforeSubmit: (a,f,o)->
                o.dataType = 'json'
              complete: (XMLHttpRequest, textStatus)->
                ;