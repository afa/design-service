//= require jquery.slimscroll
//= require ajax_submit
//= require attachment_submit


$(document).ready ->
  $('.msg').click (event) ->
    messages_url = $(event.target).data('messages-url')

    send_message = (msg_form)->
      if $(msg_form).find('textarea').val().trim().length == 0
        return false
      data = new FormData(msg_form)
      ajax_request(messages_url, 'POST', data,
        success: ->
          #msg_form.reset()
          show_chat()
        error: ->
          alert('Не получилось отправить сообщение')
      )

    make_attachment_forms_remote = (form_selector)->
      form = $(form_selector)
      set_filename = (files)->
        if files.length != 0
          form.find('.filename').html(files[0].name)
        else
          form.find('.filename').html('')
      form.find('.submit').click (event)->
        event.preventDefault()
        send_file(form, success: show_chat)
      form.find('input[type=file]').change (event)->
        set_filename(event.target.files)

    show_chat = ->
      show_fly_window_from_url(messages_url,
        preprocess: (window_element)->
          make_attachment_forms_remote( window_element.find('form.attachment_upload') )
          window_element.find('.remove_attachment').click (event)->
            attachment_url = $(event.target).data('attachment-url')
            destroy_attachment(attachment_url, success: show_chat)

          window_element.find('.send_msg').click (event)->
            event.preventDefault()
            send_message($(event.target).closest('form').get(0))

          window_element
        postprocess: (window_element)->
          window_element.find('.left_bar').slimscroll( size: '7px', width:'220px', height:'520px' )
          window_element.find('.msg_content').slimscroll( size: '7px', width:'500px', height:'400px' )
          scroll_to_last(window_element)
      )
    show_chat()

  scroll_to_last = (window_element)->
    message_list = window_element.find('.msg_content')
    message_list.animate({"scrollTop": message_list.get(0).scrollHeight}, "slow")
    window_element
