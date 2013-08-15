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
