//= require jquery.slimscroll

window.register_chat = ->
  black_content = ->
    $('body').animate({scrollTop:0},"slow")
    $("#black_content").css("height",$(document).height())
    $("#black_content").css("display","block")

  load_messages = (url)->
    $.ajax
      url: url
      dataType: 'json'
      type: 'GET'
      success: (response) ->
        $('#msg_dialog .msg_content').html(response['msgs_text'])
        $('#msg_dialog .left_bar .name').html(response['executor_name'])
        $('#msg_dialog .left_bar .photo').html('<img src="' + response['executor_avatar_url'] + '">')
        scroll_to_last()
      error: ->
        alert('Не получилось загрузить сообщения')

  scroll_to_last = ->
    $('.msg_content').animate({"scrollTop": $('.msg_content')[0].scrollHeight},"slow")

  $(".msg").click (event)->
    url = $(event.target).data('msgUrl')
    $('#msg_form').data('msg_send_url', url)
    load_messages(url)
    name_order = $(this).parent().find('.name span').html();
    $('.order_name').html(name_order);
    black_content();
    $('.left_bar').slimscroll({ size: '7px', width:'220px', height:'520px' } );
    $('.msg_content').slimscroll({ size: '7px', width:'500px', height:'400px' });
    $("#msg_dialog").css("display","block");
    $('body').css('overflow','hidden');

  $('img[name="submit"]', '.send_msg').click (event)->
    event.preventDefault();
    url = $('#msg_form').data('msg_send_url')
    data = jQuery.param
      message:
        text:  $('#msg_form textarea[name="text"]').val()
    scroll_to_last();
    $.ajax
      url: url
      dataType: 'json'
      data: data
      type: 'POST'
      success: ->
        $('#msg_form').resetForm()
        load_messages(url)
      error: ->
        alert('Не получилось отправить сообщение')

  $(".close_fly_window").click ->
    $('body').css('overflow','auto');
    $(this).parent().css("display","none").parent().css("display","none");
