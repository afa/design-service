$(function(){
	$('.select_orders').change(function(){
		window.location.href = "/adm/orders?page=1&filter=" + $(this).val();
	});

	check_new_orders();
});


function check_new_orders()
{
	window.setTimeout(function(){
		console.info(111);
		$.post('/adm/order/check_new', function(data){
			var order_last_id = $('#order_last_id').attr('value');
			if(parseInt(order_last_id) < parseInt(data['order_last_id']))
			{
				$('#order_last_id').attr('value', data['order_last_id']);
				message_success('Появились новые заказы, обновите страницу');
			}
			check_new_orders();
		}, "json");
	}, 5000);
}