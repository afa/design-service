# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

//= require orderable

$(document).ready ->
  hide_or_show_question = ->
    chk_true = $("span.plan_refactor.gen_proekt input[type='radio'][value='true']").get(0)
    if typeof(chk_true) != 'undefined' && chk_true.checked
      $('#second_ques').hide()
    chk_false = $("span.plan_refactor.gen_proekt input[type='radio'][value='false']").get(0)
    if typeof(chk_false) != 'undefined' && chk_false.checked
      $('#second_ques').show()

  $("span.plan_refactor.gen_proekt input[type='radio']").change ->
    hide_or_show_question()
  $(".orderable").on('reset', (event)->
    event.preventDefault()
    hide_or_show_question()
  )
  hide_or_show_question()
