$(function(){
	$('.close_msg').click(function(){
		$(this).parent().css('display', 'none');
	});

	$('.edit_client').click(function(){
		var el = $(this).parent().parent();
		el.find('.show_input').css('display', 'none');
		el.find('.edit_input').css('display', 'block');
		el.find('.set_client').css('display', 'block');
		el.find('.del_client').css('display', 'block');
		el.find('.edit_client').css('display', 'none');
	});

	$('.log_in').click(function(){
		var login = $('.login').val();
		var password = $('.password').val();
		$.post("/client/autorization", {login: login, password: password}, function(data){
			
		});
	});

	$('a[name=modal]').click(function(e) {
		e.preventDefault();
		var id = $(this).attr('href');
		var maskHeight = $(document).height();
		var maskWidth = $(window).width();
		$('#mask').css({'width':maskWidth,'height':maskHeight});
		$('#mask').fadeIn(1000);
		$('#mask').fadeTo("slow",0.8);
		var winH = $(window).height();
		var winW = $(window).width();
		$(id).css('top',  winH/2-$(id).height()/2);
		$(id).css('left', winW/2-$(id).width()/2);
		$(id).fadeIn(2000);
	});
	$('.window .close').click(function (e) {
		e.preventDefault();
		$('#mask, .window').hide();
	});
	$('#mask').click(function () {
		$(this).hide();
		$('.window').hide();
	});
});

function message_success(text)
{
	$('.msg-ok').find('p').html(text);
	$('.msg-ok').css('display', 'block');
}

function message_error(text)
{
	$('.msg-error').find('p').html(text);
	$('.msg-error').css('display', 'block');
}