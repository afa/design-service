# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

//= require orderable

$(document).ready ->
  selectChecked = (select) ->
    $(".warning_show").each ->
      checker = $(this).is(':checked');
      li_near = $(this).parent().next('li');
      if checker is true
        li_near.show()
        $('ol.eng_systems li.'+ $(this).attr('id')).show()

      else
        li_near.hide()
        $('ol.eng_systems li.'+$(this).attr('id')).hide()

  selectChecked(this);
  $(".warning_show").on( "click", selectChecked );


 