$(function(){
	$('.close_msg').click(function(){
		$(this).parent().css('display', 'none');
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