# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

//= require orderable

get_total = (max_time) ->
  check_stat = ->
    return ''

  robo_count = ->
    return 850

  time_start = ->
    yet= max_time--
    total = check_stat()
    if(yet>=0)
      $("#calculator").val('Осталось '+yet+' минут')
    else
      total = robo_count() 

    if(total!="")
      abortTimer()
      $("#calculator").val(total+' рублей')
      $("#calculator").removeClass('grey')
      $("#calculator").addClass('green')
      $(".order_zakaz").show()
      
       
  abortTimer = -> 
    clearInterval tid
  tid = setInterval(time_start, 2000)

$(document).ready ->
  $("#count_start").click ->
    max_time = 15
    $(this).fadeOut(800)
    $("#calculator").val('Осталось ' + max_time + ' минут')
    get_total(max_time-1)


