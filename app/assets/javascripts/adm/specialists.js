$(function(){
	$('.set_specialist').click(function(){
		var body = $(this).parent().parent();
		var id = body.find('.specialist_id').attr('value');
		var surname = body.find('.specialist_surname').val();
		var email = body.find('.specialist_email').val();
		var phone = body.find('.specialist_phone').val();

		$.post("/adm/specialist/set", {id: id, surname: surname,
			email: email, phone: phone}, function(){
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
});
