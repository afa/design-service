# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

//= require jquery.mousewheel
//= require lightbox/lightbox-2.6.min.js

$(document).ready ->
  specialization = $('#specialization_data').data('specialization')
  $('li.' + specialization).addClass('selected')

  previous = (container)->
    inner_container = container.find('> ul')
    imageWidth = inner_container.find('> li:first').outerWidth(true)
    if inner_container.position().left < 0 && !inner_container.is(':animated')
      inner_container.animate(left : '+=' + imageWidth + 'px')


  next = (container)->
    inner_container = container.find('> ul')
    totalImages = inner_container.find('> li').length
    imageWidth = inner_container.find('> li:first').outerWidth(true)
    totalWidth = imageWidth * totalImages
    visibleImages = Math.round(container.width() / imageWidth)
    visibleWidth = visibleImages * imageWidth
    stopPosition = (visibleWidth - totalWidth)
    if inner_container.position().left > stopPosition && !inner_container.is(':animated')
      inner_container.animate(left : '-=' + imageWidth + 'px');

  $('.gallery').each (ind, gallery)->
    gallery_content = $(gallery).find('.content')
    inner_container = gallery_content.find('> ul')

    totalImages = inner_container.find('> li').length
    imageWidth = inner_container.find('> li:first').outerWidth(true)
    totalWidth = imageWidth * (totalImages+1)

    inner_container.width(totalWidth)
    inner_container.mousewheel (event, delta)->
      if delta > 0
        previous(gallery_content)
      else
        next(gallery_content)

    gallery_content.mousewheel ->
      false

    $(gallery).find('.left_controller').click ->
      previous(gallery_content)
    $(gallery).find('.right_controller').click ->
      next(gallery_content)
