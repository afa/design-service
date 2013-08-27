//= require jquery.slimscroll
//= require ajax_submit

window.register_chat = ->
  make_attachment_forms_remote = (form_selector)->
    form = $(form_selector)
    form.find('.submit').click (event)->
      event.preventDefault()
      multipart_ajax_sendform(form, 'POST',
        success: ->
          alert('Файл загружен')
          form.get(0).reset()
          form.find('input[type=file]').trigger('change')
          messages_url = $('#msg_form').data('msg_send_url')
          load_chat(messages_url)
        error: ->
          alert('Не удалось загрузить файл')
      )
    form.find('input[type=file]').change ->
      files = this.files
      if files.length != 0
        form.find('.filename').html(files[0].name)
      else
        form.find('.filename').html('')

  register_destroy_attachment_buttons = (button_selector)->
    $(button_selector).click (event)->
      attachment_url = $(this).data('attachment-url')
      ajax_request(attachment_url, 'DELETE', $.param({}),
        success: ->
          alert('Файл удален')
          messages_url = $('#msg_form').data('msg_send_url')
          load_chat(messages_url)
        error: ->
          alert('Не удалось удалить файл')
      )

  black_content = ->
    $('body').animate({scrollTop:0},"slow")
    $("#black_content").css("height",$(document).height())
    $("#black_content").css("display","block")

  load_chat = (url)->
    $.ajax
      url: url
      dataType: 'json'
      type: 'GET'
      success: (response) ->
        $('#msg_dialog .msg_content').html(response['msgs_text'])
        $('#msg_dialog .left_bar .name').html(response['executor_name'])
        $('#msg_dialog .left_bar .photo').html('<img src="' + response['executor_avatar_url'] + '">')
        $('#msg_dialog .attachments_list').html(response['attachment_previews_text'])
        make_attachment_forms_remote('form.attachment_upload')
        register_destroy_attachment_buttons('.remove_attachment')
        scroll_to_last()
      error: ->
        alert('Не получилось загрузить сообщения')

  scroll_to_last = ->
    $('.msg_content').animate({"scrollTop": $('.msg_content')[0].scrollHeight},"slow")

  $(".msg").click (event)->
    messages_url = $(event.target).data('msgUrl')
    $('#msg_form').data('msg_send_url', messages_url)
    load_chat(messages_url)

    name_order = $(this).parent().find('.name span').html();
    $('.order_name').html(name_order);
    black_content();
    $('.left_bar').slimscroll({ size: '7px', width:'220px', height:'520px' } );
    $('.msg_content').slimscroll({ size: '7px', width:'500px', height:'400px' });
    $("#msg_dialog").css("display","block");
    $('body').css('overflow','hidden');

  $('img[name="submit"]', '.send_msg').click (event)->
    event.preventDefault();
    messages_url = $('#msg_form').data('msg_send_url')
    data = jQuery.param
      message:
        text:  $('#msg_form textarea[name="text"]').val()
    scroll_to_last();
    $.ajax
      url: messages_url
      dataType: 'json'
      data: data
      type: 'POST'
      success: ->
        $('#msg_form').resetForm()
        load_chat(messages_url)
      error: ->
        alert('Не получилось отправить сообщение')

  $(".close_fly_window").click ->
    $('#msg_dialog .msg_content').html('')
    $('#msg_dialog .left_bar .name').html('')
    $('#msg_dialog .left_bar .photo').html('')
    $('#msg_dialog .attachments_list').html('')
    $('body').css('overflow','auto');
    $(this).parent().css("display","none").parent().css("display","none");
