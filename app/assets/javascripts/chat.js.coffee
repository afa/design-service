//= require jquery.slimscroll

window.register_chat = ->
  black_content = ->
    $('body').animate({scrollTop:0},"slow")
    $("#black_content").css("height",$(document).height())
    $("#black_content").css("display","block")

  scroll_to_last = ->
    $('.msg_content').animate({"scrollTop": $('.msg_content')[0].scrollHeight},"slow")

  $(".msg").click ->
    msg_dialog_id = $(this).attr('id');
    name_order = $(this).parent().find('.name span').html();
    $('.order_name').html(name_order);
    black_content();
    $('.left_bar').slimscroll({ size: '7px', width:'220px', height:'520px' } );
    $('.msg_content').slimscroll({ size: '7px', width:'500px', height:'400px' });
    $("#msg_dialog").css("display","block");
    scroll_to_last();
    $('body').css('overflow','hidden');

  $('img[name="submit"]', '.send_msg').click (event)->
    event.preventDefault();
    data = jQuery.param
      message:
        text:  $('#msg_form textarea[name="text"]').val()
    scroll_to_last();
    $.ajax
      url: $('#msg_form').data('url')
      dataType: 'json'
      data: data
      type: 'POST'
      success: ->
        $('#msg_form').resetForm()
      error: ->
        alert('Не получилось отправить сообщение')

  $(".close_fly_window").click ->
    $('body').css('overflow','auto');
    $(this).parent().css("display","none").parent().css("display","none");
