# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

//= require orderable

ajax_post = (ajaxUrl, dataHash, functionSuccess, functionFailure) ->
  $.ajax
    type: "POST"
    url: ajaxUrl
    
    #contentType: "application/json; charset=utf-8",
    data: $.param(dataHash)
    dataType: "json"
    processData: false
    success: functionSuccess
    error: functionFailure

empty_cb = () ->

count_cb = (data, status, xhr) ->
  if(window.max_time >= 0)
    $("#calculator").val("Осталось " + window.max_time + " минут")
    if(typeof(data.price) != 'undefined')
      abortTimer()
      show_price(data)
  else
    ajax_post(window.time_auto, {}, manual_cb, empty_cb)

manual_cb = (data, status, xhr) ->
  abortTimer()
  show_price(data)

show_price = (data) ->
  $("#calculator").removeClass("grey").addClass("green")
  $("#calculator").val(data.price)
  $(".order_zakaz").show()

start_count = () ->
  event.preventDefault()
  $('.black_content_blocks').append($('#order_mode'))
  window.max_time = 15
  window.time_start = $("span#count_start a.start").attr("href")
  window.time_auto = $("span#count_start a.auto").attr("href")
  $(this).fadeOut(800)
  $("#calculator").val("Осталось " + window.max_time + " минут")
  window.time_tid = setInterval(time_count, 1000)

time_count = () ->
  window.max_time--
  ajax_post(window.time_start, {}, count_cb, empty_cb)

abortTimer = () ->
  clearInterval window.time_tid
#  tid = setInterval(time_start, 2000)

$(document).ready ->
  $("#count_start").on("click", start_count)
    #event.preventDefault()
    #max_time = 15
    #$(this).fadeOut(800)
    #$("#calculator").val('Осталось ' + max_time + ' минут')
    #get_total(max_time-1)

  $("body.unregistered .order_zakaz span").click ->
    show_fly_window('#order_mode')

  $("#order_mode .login").click ->
    close_fly_window() 
    show_fly_window('#login')

  $("#order_mode .register").click ->
    close_fly_window() 
    show_fly_window('#register') 

  $("body.unregistered .put.submit").off("click")
  $("body.unregistered .put.submit").on("click", ->
    event.preventDefault()
    if($("#plan_development_flat_area").val().length == 0)
      $("#plan_development_flat_area").addClass("red_border").focus()
      return false
    else
      $("#plan_development_flat_area").removeClass("red_border")
    ajax_sendform($(this).closest("form"), "PUT",
    success: (data,status,xhr) ->
      close_fly_window()
      $("#register form").append("<input type=\"hidden\" name=\"merge_order_to_user\" value=\"1\">")
      $("#login form").append("<input type=\"hidden\" name=\"merge_order_to_user\" value=\"1\">")
      show_fly_window("#register")
    error: (xhr,status,error) ->
      alert("Не получилось отправить форму")
    )
    return false
  )
