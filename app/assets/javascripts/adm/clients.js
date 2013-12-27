$(function(){
	$('.set_client').click(function(){
		$(this).parent().parent().parent().submit();
		console.info(111);
	});
});