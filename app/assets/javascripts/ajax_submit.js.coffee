# method: 'GET' or 'POST' or 'PUT' or 'DELETE'
window.ajax_request = (url, method, data, callbacks)->
  multipart_ajax_request(url, method, data, callbacks)

window.ajax_sendform = (form_selector, method, callbacks)->
  multipart_ajax_sendform(form_selector, method, callbacks)

# all requests made this way are multipart
window.multipart_ajax_request = (url, method, data, callbacks)->
  callbacks ||= {}
  $.ajax
    url: url
    dataType: 'json'
    contentType: false
    processData: false
    data: data
    type: method
    success: callbacks['success'] || (data, textStatus, xhr)-> {}
    error: callbacks['error'] || (xhr, textStatus, error)-> {}

window.multipart_ajax_sendform = (form_selector, method, callbacks)->
  $(form_selector).each (idx, form)->
    multipart_ajax_request(form.action, method, new FormData(form), callbacks)

$(document).ready ->
  $('.put.submit').click (event)->
    event.preventDefault()
    ajax_sendform($(event.target).closest('form'), 'PUT',
      success: (data, status, xhr)->
        alert('Изменения сохранены')
        ($(event.target).data('ajax-success') || ->{})(data,status,xhr)
      error: (xhr, status, error)->
        alert('Не получилось отправить форму')
        ($(event.target).data('ajax-error') || ->{})(xhr,status,error)
    )
  $('.post.submit').click (event)->
    event.preventDefault()
    ajax_sendform($(event.target).closest('form'), 'POST',
      success: (data, status, xhr)->
        alert('Изменения сохранены')
        ($(event.target).data('ajax-success') || ->{})(data,status,xhr)
      error: (xhr, status, error)->
        alert('Не получилось отправить форму')
        ($(event.target).data('ajax-error') || ->{})(xhr,status,error)
    )
  $('.not_ajax.submit').click (event)->
    $(event.target).closest('form').get(0).submit()
