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

	$('.client_new_password').click(function(){
		var id = $('#client_id').attr('value');
		var password = $(this).prev().val();
		$.post("/adm/client/set_password", {id: id, password: password}, function(data){
			if(data['status'] == "success")
			{
				message_success(data['message']);
				$('.client_new_password').prev().val('');
			}
			else
				message_error(data['message']);
		});
	});

	$('.add_client').click(function(){
		var name = $('.client_name').val();
		var surname = $('.client_surname').val();
		var login = $('.client_login').val();
		var password = $('.client_password').val();
		var email = $('.client_email').val();
		var phone = $('.client_phone').val();

		if(name == '' || surname == '' || login == '' || password == '' || email == '')
			message_error('Не все поля введены');
		else
		{
			$.post('/adm/client/add', {name: name, surname: surname, login: login, 
				password: password, email: email, phone: phone}, function(data){
				if(data['status'] == "true")
					window.location.href = "/adm/client/"+data['id'];
				else
					message_error('Данные введены не корректно');
			});
		}
	});
});
