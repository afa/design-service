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

  $('img', '.send_msg').click ->
    data = $('#msg_form').serialize();
    scroll_to_last();
    alert(data);

  $(".close_fly_window").click ->
    $('body').css('overflow','auto');
    $(this).parent().css("display","none").parent().css("display","none");
