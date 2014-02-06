$(function(){
	$('.del_specialist_from_group').click(function(){
		if(confirm("Удалить этого специалиста из группы?"))
		{
			var body = $(this).parent().parent();
			var specialist_id = body.find('.specialist_id').attr('value');
			var group_id = $('#group_id').attr('value');
			$.post('/adm/specialist/del_from_group', {group_id: group_id, specialist_id: specialist_id}, function(data){
				body.remove();
			});
		}
	});

	$('.select_specialization').change(function(){
		$.post("/adm/specialists/get_by_specialization?specialization_id="+$(this).val(), function(data){
			$('.select_specialists').html(data['data']);
			$('.select_specialists').parent().parent().css('display', 'block');
		}, "json");
	});

	/*$('.select_groups').change(function(){
		$.getJSON("/adm/specialist/" + $(this).val() + "/get_by_group_and_specialization?specialization_id="+$('.select_specialization').val()+"&group_id="+$(this).val(), function(data){
			$('.select_specialists').html(data['data']);
			$('.select_specialists').css('display', 'block');
		});
	});*/

	$('.select_specialists').bind('change', function(){
		var el = $(this);
		$('#select_specialist_id').attr('value', el.val());
		//$.getJSON("/adm/specialist/" + $(this).val() + "/get_price?order_id="+$('#order_id').attr('value'), function(data){
			//$('#select_specialist_id').attr('value', el.val());
		//});
	});

	$('.add_spec_to_group').click(function(){
		var group_id = $('#group_id').attr('value');
		var specialist_id = $('#select_specialist_id').attr('value');
		$.post("/adm/specialist/add_request_to_group", {group_id: group_id, specialist_id: specialist_id}, function(){
			location.reload();
		});
	});

	$('.add_in_group_from_request').click(function(){
		var group_id = $('#group_id').attr('value');
		var specialist_id = $(this).next().attr('value');
		if(confirm("Назначить данного специалиста в группу?"))
		{
			$.post("/adm/specialist/add_to_group", {group_id: group_id, specialist_id: specialist_id}, function(){
				location.reload();
			});
		}
	});

	$('.del_request_specialist_from_group').click(function(){
		var id = $(this).next().attr('value');
		if(confirm("Назначить данного специалиста в группу?"))
		{
			$.post("/adm/specialist/del_request", {request_id: id}, function(){
				location.reload();
			});
		}
	});

	$('.add_group').click(function(){
		var name = $('.group_name').val();
		var specialization_id = $('.select_specialization').val();

		if(name == '')
			message_error('Не все поля введены');
		else
		{
			$.post('/adm/group/add', {name: name, specialization_id: specialization_id}, function(data){
				if(data['status'] == "true")
					window.location.href = "/adm/group/"+data['id'];
				else
					message_error('Данные введены не корректно');
			});
		}
	});
});