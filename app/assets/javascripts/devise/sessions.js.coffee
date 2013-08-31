//= require ../login_box
window.black_content = ->
  $("#black_content").css("height",$(document).height())
  $("#black_content").css("display","block")


$(document).ready ->
  black_content()
  $("#login").css("display","block")