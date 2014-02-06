root = exports ? this
root.success_standart = (data, status, xhr) ->
  location.reload()
  return false

root.error_standart = (data, status, xhr) ->
  alert('Error')
  return false

root.success_standart_dynamic = (data, status, xhr) ->
  $('.msg-ok').find('p').html(data['text']);
  $('.msg-ok').css('display', 'block');
  return false