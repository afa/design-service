$(function(){
	$('.group_new').click(function(){
		window.location.href = "/adm/group/new";
	});

	$('.edit_group').click(function(){
		var el = $(this).parent().parent();
		el.find('.show_input').css('display', 'none');
		el.find('.edit_input').css('display', 'block');
		el.find('.set_group').css('display', 'block');
		el.find('.del_group').css('display', 'block');
		el.find('.edit_group').css('display', 'none');
	});

	$('.set_group').click(function(){
		var body = $(this).parent().parent();
		var id = body.find('.group_id').attr('value');
		var name = body.find('.groupt_name').val();

		$.post("/adm/group/set", {id: id, name: name}, function(){
				body.find('.show_input').css('display', 'block');
				body.find('.edit_input').css('display', 'none');
				body.find('.set_group').css('display', 'none');
				body.find('.del_group').css('display', 'none');
				body.find('.edit_group').css('display', 'block');

				body.find('.show_input_name').html(name);

				message_success("Данные успешно обновлены.");
		});
	});
});