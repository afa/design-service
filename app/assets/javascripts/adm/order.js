$(function(){
	$('.select_specialization').change(function(){
		$.getJSON("/adm/specialist_group/" + $(this).val() + "/get_by_specialist", function(data){
			$('.select_groups').html(data['data']);
		});
	});

	$('.select_groups').change(function(){
		$.getJSON("/adm/specialist/" + $(this).val() + "/get_by_group_and_specialization", function(data){
			$('.select_specialists').html(data['data']);
		});
	});
});