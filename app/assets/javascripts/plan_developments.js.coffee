# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

//= require orderable

request_total = (ajaxUrl, dataHash, functionSuccess, functionFailure) ->
  $.ajax
    type: "POST"
    url: ajaxUrl
    
    #contentType: "application/json; charset=utf-8",
    data: $.param(dataHash)
    dataType: "json"
    processData: false
    success: functionSuccess
    error: functionFailure


get_total = (max_time) ->

  time_start = ->
    yet= max_time--
    manual = $('span#count_start a.start').attr('href')
    auto = $('span#count_start a.auto').attr('href')
    total = request_total(manual,{})      #check price validate
    if(yet>=0)
      $("#calculator").val('Осталось '+yet+' минут')
    else
      total = request_total(auto,{})      #auto price generate

 
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
    $('.black_content_blocks').append($('#order_mode'))
    event.preventDefault()
    max_time = 15
    $(this).fadeOut(800)
    $("#calculator").val('Осталось ' + max_time + ' минут')
    get_total(max_time-1)

  $(".order_zakaz span").click ->
    show_fly_window('#order_mode')


  $("#order_mode .login").click ->
    close_fly_window() 
    show_fly_window('#login')

  $("#order_mode .register").click ->
    close_fly_window() 
    show_fly_window('#register') 