# Here we should use string of query as an argument, not an element because after form reloading we need to search an element again
# submit element must be an image but not input[type=image]
window.register_ajax_submit = (element_to_set, submit_button)->
  $(submit_button).click ->
    form = $(this).closest('form')
    unless form.get(0).checkValidity()
      return false

    form.ajaxSubmit
      beforeSubmit: (a,f,o)->
        o.dataType = 'json'
      complete: (xhr, textStatus)->
        if xhr.status == 200 || xhr.status == 201
          $(element_to_set).html(xhr.responseText)
