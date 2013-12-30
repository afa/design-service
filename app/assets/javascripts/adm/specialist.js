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

	$('.add_in_group').click(function(){
		var group_id = $('.select_group').val();
		var specialist_id = $('#specialist_id').attr('value');
		$.post("/adm/specialist/add_to_group", {group_id: group_id, specialist_id: specialist_id}, function(){
			location.reload();
		});
	});

	$('.del_group').click(function(){
		if(confirm("Удалить специалиста из группы?"))
		{
			var specialist_id = $('#specialist_id').attr('value');
			var group_id = $(this).next().attr('value');
			var el = $(this);
			$.post("/adm/specialist/del_from_group", {specialist_id: specialist_id, group_id: group_id}, function(){
				el.parent().parent().remove();
			});
		}
	});

	$('.left_portfolio_item').click(function(){
		var page = $(this).next().attr('value');
		var portfolio_id = $(this).next().next().attr('value');
		var el = $(this).parent().parent().parent();
		$.post('/adm/portfolio_item/get_next', {page: page, portfolio_id: portfolio_id}, function(data){
			var items = data['items'];
			$('.portfolio_items_body').html(items);
			if(items != '')
			{
				var left = parseInt(el.find('.left_portfolio_item').attr('value'));
				if(left > 1) el.find('.left_portfolio_item').attr('value', left - 1);
				var right = parseInt(el.find('.right_portfolio_item').attr('value'));
				el.find('.right_portfolio_item').attr('value', left - 1);
			}
		}, "json");
	});

	$('.right_portfolio_item').click(function(){
		var page = $(this).next().attr('value');
		var portfolio_id = $(this).next().next().attr('value');
		var el = $(this).parent().parent().parent();
		$.post('/adm/portfolio_item/get_next', {page: page, portfolio_id: portfolio_id}, function(data){
			var items = data['items'];
			$('.portfolio_items_body').html(items);
			if(items != '')
			{
				var left = parseInt(el.find('.left_portfolio_item').attr('value'));
				el.find('.left_portfolio_item').attr('value', left + 1);
				var right = parseInt(el.find('.right_portfolio_item').attr('value'));
				el.find('.right_portfolio_item').attr('value', left + 1);
			}
		}, "json");
	});

	$('.add_specialist').click(function(){
		var name = $('.client_name').val();
		var surname = $('.client_surname').val();
		var login = $('.client_login').val();
		var password = $('.client_password').val();
		var email = $('.client_email').val();
		var phone = $('.client_phone').val();
		var group_id = $('.select_group').val();
		var specialization_id = $('.select_specialization').val();

		if(name == '' || surname == '' || login == '' || password == '' || email == '' || group_id == 0 || specialization_id == 0)
			message_error('Не все поля введены');
		else
		{
			$.post('/adm/specialist/add', {name: name, surname: surname, login: login, 
				password: password, email: email, phone: phone, group_id: group_id, specialization_id: specialization_id}, function(data){
				if(data['status'] == "true")
					window.location.href = "/adm/specialist/"+data['id'];
				else
					message_error('Данные введены не корректно');
			});
		}
	});
});