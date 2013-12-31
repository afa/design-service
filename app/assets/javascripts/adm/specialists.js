$(function(){
	$('.set_specialist').click(function(){
		var body = $(this).parent().parent();
		var id = body.find('.specialist_id').attr('value');
		var surname = body.find('.specialist_surname').val();
		var email = body.find('.specialist_email').val();
		var phone = body.find('.specialist_phone').val();

		$.post("/adm/specialist/set", {id: id, surname: surname,
			email: email, phone: phone}, function(){
				body.find('.show_input').css('display', 'block');
				body.find('.edit_input').css('display', 'none');
				body.find('.set_specialist').css('display', 'none');
				body.find('.del_specialist').css('display', 'none');
				body.find('.edit_specialist').css('display', 'block');

				body.find('.show_input_surname').html(body.find('.specialist_surname').val());
				body.find('.show_input_email').html(body.find('.specialist_email').val());
				body.find('.show_input_phone').html(body.find('.specialist_phone').val());

				message_success("Данные успешно обновлены.");
		});
	});

	$('.del_specialist').click(function(){
		var body = $(this).parent().parent();
		var id = body.find('.specialist_id').attr('value');
		if (confirm("Вы хотите удалить этого специалиста?"))
		{
			$.post("/adm/specialist/del", {id: id}, function(){
				body.remove();
			});
		}
	});

	$('.edit_specialist').click(function(){
		var el = $(this).parent().parent();
		el.find('.show_input').css('display', 'none');
		el.find('.edit_input').css('display', 'block');
		el.find('.set_specialist').css('display', 'block');
		el.find('.del_specialist').css('display', 'block');
		el.find('.edit_specialist').css('display', 'none');
	});

	$('.specialist_new').click(function(){
		window.location.href = "/adm/specialist/new";
	});
});
