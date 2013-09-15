# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

//= require orderable

$(document).ready ->
  hide_or_show_question = ->
    if $("span.plan_refactor.gen_proekt input[type='radio'][value='true']").get(0).checked
      $('#second_ques').css('display','none')

    if $("span.plan_refactor.gen_proekt input[type='radio'][value='false']").get(0).checked
      $('#second_ques').css('display','block')

  $("span.plan_refactor.gen_proekt input[type='radio']").change ->
    hide_or_show_question()
  hide_or_show_question()
