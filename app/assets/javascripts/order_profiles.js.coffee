# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/



$(document).ready ->
  $(".progress_block").each ->
    presentage = parseInt($(this).find(".value").html())
    len = 155 * presentage / 100
    $(this).find(".progress_bar").css "width", len


  $("div.make_comments ul").each ()->
    nthis = $(this)
    rating = (rate)->
      $(nthis).parent().find('.rating').val(rate)

    activate_star = (s,items)->
      $(nthis).find('li').removeClass('active_star')
      $(nthis).find('li').each ->
        $(this).addClass "active_star"  if s <= items
        s++

    rating($(nthis).find("li.active_star").length)
    $(nthis).find("li").mouseenter ()->
      activate_star(0,$(this).index())
      
    $(nthis).find("li").click ()->
      rating($(nthis).find("li.active_star").length)

    $(nthis).mouseleave ()->
      activate_star(1,parseInt($(this).parent().find('.rating').val()))