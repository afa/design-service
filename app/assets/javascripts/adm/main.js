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