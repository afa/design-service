# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
//= require upload_attachment

$ ->
  form = $('form.has_attachments')
  upload_url = form.data('attachment-upload-url')
  $('input[type="submit"]', form).click (event)->
    event.preventDefault()

    $('input[type="file"]', form).each ->
      upload_attachment this, upload_url,
        success: ->
          alert('ok')
        error: ->
          alert('fail')

window.make_attachment_forms_remote = (submit_element)->
  $(submit_element).click (event)->
    event.preventDefault()
    form = $(event.target).closest('form')
    form_data = prepare_form_data('input', form)
    url = $(form).get(0).action
    $('input[type="file"]', form).each ->
      multipart_ajax_request(url, 'POST', form_data,
        success: ->
          alert('Файл загружен')
        error: ->
          alert('Ошибка загрузки фалйа')
      )
