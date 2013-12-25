$(function(){
	$('.select_orders').change(function(){
		window.location.href = "/adm/orders?page=1&filter=" + $(this).val();
	});
});