//= require jquery.slimscroll
//= require ajax_submit
//= require attachment_submit

$(document).ready ->
  $(".msg").click (event)->
    messages_url = $(event.target).data('messages-url')
    order_url = $(event.target).data('order-url')
    $('#msg_dialog').data('messages-url', messages_url)
    $('#msg_dialog').data('order-url', order_url)
    load_chat()
    show_chat()

  $(".close_fly_window").click ->
    close_chat()

  $('.send_msg').click (event)->
    event.preventDefault()
    send_message($(event.target).closest('form').get(0))

  fill_chat_box = (data)->
    msg_dialog = $('#msg_dialog')
    msg_dialog.find('.msg_content').html(data['msgs_text'] || '')
    msg_dialog.find('.left_bar .name').html(data['executor_name'] || '')
    msg_dialog.find('.left_bar .photo').html('<img src="' + (data['executor_avatar_url'] || '') + '">')
    msg_dialog.find('.attachments_list').html(data['attachment_previews_text'] || '')
    msg_dialog.find('.order_name').html(data['attached_to_name'] || '')
    make_attachment_forms_remote(msg_dialog.find('form.attachment_upload'))
    register_destroy_attachment_in_chat_buttons(msg_dialog.find('.remove_attachment'))

  load_chat = ->
    messages_url = $('#msg_dialog').data('messages-url')
    ajax_request(messages_url, 'GET', '',
      success: (response) ->
        fill_chat_box(response)
        scroll_to_last()
      error: ->
        alert('Не получилось загрузить сообщения')
    )
    $('#msg_dialog').find('.order_info').click ->
      window.location.href = $('#msg_dialog').data('order-url')

  send_message = (msg_form)->
    messages_url = $('#msg_dialog').data('messages-url')
    if $(msg_form).find('textarea').val().trim().length == 0
      return false
    data = new FormData(msg_form)
    ajax_request(messages_url, 'POST', data,
      success: ->
        msg_form.reset()
        load_chat()
      error: ->
        alert('Не получилось отправить сообщение')
    )

  show_chat = ->
    $('#msg_dialog').find('.left_bar').slimscroll( size: '7px', width:'220px', height:'520px' )
    $('#msg_dialog').find('.msg_content').slimscroll( size: '7px', width:'500px', height:'400px' )
    show_fly_window('#msg_dialog')
    # $('body').css('overflow','hidden');  ## hide main window scrolling

  close_chat = ->
    fill_chat_box({})
    # $('body').css('overflow','auto')  ## return scrollbar

  scroll_to_last = ->
    message_list = $('#msg_dialog').find('.msg_content')
    message_list.animate({"scrollTop": message_list.get(0).scrollHeight}, "slow")

  make_attachment_forms_remote = (form_selector)->
    form = $(form_selector)
    set_filename = (files)->
      if files.length != 0
        form.find('.filename').html(files[0].name)
      else
        form.find('.filename').html('')
    form.find('.submit').click (event)->
      event.preventDefault()
      send_file(form, success: load_chat)
    form.find('input[type=file]').change (event)->
      set_filename(event.target.files)

  register_destroy_attachment_in_chat_buttons = (button_selector)->
    $(button_selector).click (event)->
      attachment_url = $(event.target).data('attachment-url')
      destroy_attachment(attachment_url, success: load_chat)

  # Not used yet (due to url obtaining issues)
  load_messages = (url)->
    ajax_request(url, "GET", '',
      success: (response) ->
        $('#msg_dialog .msg_content').html(response['msgs_text'])
        scroll_to_last()
      error: (response) ->
        alert('Не получилось загрузить сообщения')
    )

  # Not used yet (due to url obtaining issues)
  load_attachments = (url)->
    ajax_request(url, "GET", '',
      success: (response) ->
        msg_dialog = $('#msg_dialog')
        msg_dialog.find('.attachments_list').html(response['attachment_previews_text'])
        make_attachment_forms_remote(msg_dialog.find('form.attachment_upload'))
        register_destroy_attachment_in_chat_buttons(msg_dialog.find('.remove_attachment'))
      error: (response) ->
        alert('Не получилось загрузить сообщения')
    )
