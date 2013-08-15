# Here we should use string of query as an argument, not an element because after form reloading we need to search an element again
# submit element must be an image but not input[type=image]
//= require upload_attachment

window.register_ajax_submit = (element_to_set, submit_button)->
  $(submit_button).click ->
    form = $(this).closest('form')
    upload_url = form.attr('action')
    unless form.get(0).checkValidity()
      return false

    data = prepare_form_data($('input', form))
    multipart_ajax_request upload_url, 'PUT', data,
      success: (data, textStatus, xhr)->
        $(element_to_set).html(data['text'])
      error: ->
        alert('Не получилось отправить форму');
