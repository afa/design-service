$(function(){
	$('.select_specialization').change(function(){
		$.getJSON("/adm/specialist_group/" + $(this).val() + "/get_by_specialist", function(data){
			$('.select_groups').html(data['data']);
			$('.select_groups').parent().parent().css('display', 'block');
		});
	});

	$('.select_groups').change(function(){
		$.getJSON("/adm/specialist/" + $(this).val() + "/get_by_group_and_specialization?specialization_id="+$('.select_specialization').val()+"&group_id="+$(this).val(), function(data){
			$('.select_specialists').html(data['data']);
			$('.select_specialists').parent().parent().css('display', 'block');
		});
	});

	$('.select_specialists').change(function(){
		var el = $(this);
		$.getJSON("/adm/specialist/" + $(this).val() + "/get_price?order_id="+$('#order_id').attr('value'), function(data){
			$('#select_specialist_id').attr('value', el.val());
			$('.specialist_price').attr('value', data['data'])
		});
	});

	$('.send_moderator_message').click(function(){
		var type = $(this).next().attr('value');
		var sender_id = $(this).next().next().attr('value');
		var id = $(this).next().next().next().attr('value');
		var text = $(this).prev().prev().val();

		if(confirm("Отправить это сообщение в чат?"))
		{
			$.post("/adm/order/send_message", {type: type, sender_id: sender_id, text: text, id: id}, function(data){
				location.reload();
			});
		}
	});
});