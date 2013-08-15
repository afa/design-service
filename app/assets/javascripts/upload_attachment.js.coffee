window.prepare_form_data = (input_fields)->
  form_data = new FormData
  $(input_fields).each ->
    if($(this).attr('type') == 'file')
      form_data.append(this.name, this.files[0])
    else
      form_data.append(this.name, this.value)
  form_data

# method: 'GET' or 'POST' or 'PUT'
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

window.upload_attachment = (file_input, upload_url, callbacks) ->
  form_data = new FormData()
  form_data.append('attachment[file]', $(file_input).get(0).files[0])
  $.ajax
    url: upload_url
    dataType: 'json'
    contentType: false
    processData: false
    data: form_data
    type: 'POST'
    success: callbacks['success'] || ->{ }
    error: callbacks['error'] || ->{ }
