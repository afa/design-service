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
});