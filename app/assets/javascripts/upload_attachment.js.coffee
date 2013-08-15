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
