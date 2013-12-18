//=require ajax_submit
//=require fly_window
# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
ld_succ = (data, stat, xhr) ->
 $('.page#' + data.what).html($(data.content))
 $(".page").hide()
 $('.page#' + data.what).show()
 $('.menu .menu_item.' + data.what).addClass('active')
 $('.menu .menu_item.active').off 'click'
 $('.menu .menu_item:not(.active)').on 'click', menu_click

ld_fail = () ->

menu_click = () ->
 $(event.target).parents(".menu").find(".menu_item.active").removeClass('active')
 makeAjaxCall('/personal_account/' + $(event.target).closest(".menu_item").attr('data') + '.json', ld_succ, ld_fail)

ajax_lnk = (data, status, xhr) ->
 close_fly_window()
 $(data.content).appendTo($(".black_content_blocks"))
 show_fly_window("#" + data.what)
 ajax_lnk_prepare()

ajax_lnk_prepare = () ->
 $('a.ajax').off 'click'
 $("a.ajax").on "click", () ->
  event.stopPropagation()
  makeAjaxCall(this.href, ajax_lnk, () -> alert('connection error'))
  event.preventDefault()
$(document).ready ->
 $('.menu .menu_item:not(.active)').on 'click', menu_click
 ajax_lnk_prepare()
