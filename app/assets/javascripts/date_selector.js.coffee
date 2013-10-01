$(document).ready ->
  $('.more_details ul.files li').hover(
    ->
      $(this).children('span').css('color','#ffffff').css('background-color','#000000')
    ->
      $(this).children('span').css('color','#a5a0a0').css('background-color','#333333')
  )

  image_path = $('#datepicker').data('image-path')
  $('#datepicker').datepicker(
    showOn: 'button'
    buttonImage: image_path
    buttonImageOnly: true
  )
