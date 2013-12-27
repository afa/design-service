$(function(){
	$('.set_client').click(function(){
		var body = $(this).parent().parent();
		var id = body.find('.client_id').attr('value');
		var name = body.find('.client_name_'+id).val();
		var surname = body.find('.client_surname').val();
		var username = body.find('.client_username').val();
		var email = body.find('.client_email').val();
		var phone = body.find('.client_phone').val();

		$.post("/adm/client/set_client", {id: id, name: name, surname: surname, username: username,
			email: email, phone: phone}, function(){
				message_success("Данные успешно обновлены.");
			});
	});

	$('.del_client').click(function(){
		var body = $(this).parent().parent();
		var id = body.find('.client_id').attr('value');
		if (confirm("Вы хотите удалить этого клиента?"))
		{
			$.post("/adm/client/del", {id: id}, function(){
				body.remove();
			});
		}
	});
});