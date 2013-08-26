# method: 'GET' or 'POST' or 'PUT' or 'DELETE'
window.ajax_request = (url, method, data, callbacks)->
  $.ajax
    url: url
    dataType: 'json'
    data: data
    type: method
    success: callbacks['success'] || (data, textStatus, xhr)-> {}
    error: callbacks['error'] || (data, textStatus, xhr)-> {}

window.ajax_sendform = (form_selector, method, callbacks)->
  $(form_selector).each (idx, form)->
    ajax_request(form.action, method, new FormData(form), callbacks)


# all requests made this way are multipart
window.multipart_ajax_request = (url, method, data, callbacks)->
  $.ajax
    url: url
    dataType: 'json'
    contentType: false
    processData: false
    data: data
    type: method
    success: callbacks['success'] || (data, textStatus, xhr)-> {}
    error: callbacks['error'] || (data, textStatus, xhr)-> {}

window.multipart_ajax_sendform = (form_selector, method, callbacks)->
  $(form_selector).each (idx, form)->
    multipart_ajax_request(form.action, method, new FormData(form), callbacks)



################ FOR SPECIFIC ORDER FORMS ####################
# AJAX submission of attachment and form
window.attachment_and_form_ajax_submission = (order_form, attach_form, submit_button_selector, output_text_field)->
  order_form = $(order_form)
  attach_form = $(attach_form)

  $(submit_button_selector).click (event)->
    submit_button = event.target
    # form = $(submit_button).closest('form')

    send_form = ->
      multipart_ajax_sendform(order_form, 'PUT',
        success: (data, textStatus, xhr)->
          $(output_text_field).html(data['text'])
          $(output_text_field).trigger('change')
          alert('Изменения сохранены')
        error: ->
          alert('Не получилось отправить форму')
      )
    send_attach = ->
      if attach_form.find('input[type=file]').get(0).files.length != 0
        multipart_ajax_sendform(attach_form, 'POST',
          success: ->
            send_form()
            alert('Файл загружен')
            $(attach_form).get(0).reset()
          error: ->
            alert('Ошибка при загрузке файла')
        )
      else
        send_form()
    send_attach()

window.register_destroy_attachment_buttons = ->
  $('.delete_attachment').click (event)->
    attachment_url = $(event.target).data('attachment-url')
    ajax_request(attachment_url, 'DELETE', $.param({}),
      success: ->
        alert('Файл успешно удален')
        $(event.target).closest('li.attachment_item').remove()
      error: ->
        alert('Файл не удален')
    )
