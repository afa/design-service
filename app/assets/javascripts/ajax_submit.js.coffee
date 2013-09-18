# method: 'GET' or 'POST' or 'PUT' or 'DELETE'
window.ajax_request = (url, method, data, callbacks)->
  multipart_ajax_request(url, method, data, callbacks)

window.ajax_sendform = (form_selector, method, callbacks)->
  multipart_ajax_sendform(form_selector, method, callbacks)

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
    error: callbacks['error'] || (xhr, textStatus, error)-> {}

window.multipart_ajax_sendform = (form_selector, method, callbacks)->
  $(form_selector).each (idx, form)->
    multipart_ajax_request(form.action, method, new FormData(form), callbacks)

$(document).ready ->
  $('.put.submit').click (event)->
    event.preventDefault()
    ajax_sendform($(event.target).closest('form'), 'PUT',
      success: ->
        alert('Изменения сохранены')
      error: ->
        alert('Не получилось отправить форму')
    )
  $('.post.submit').click (event)->
    event.preventDefault()
    ajax_sendform($(event.target).closest('form'), 'POST',
      success: ->
        alert('Изменения сохранены')
      error: ->
        alert('Не получилось отправить форму')
    )
  $('.not_ajax.submit').click (event)->
    $(event.target).closest('form').get(0).submit()
