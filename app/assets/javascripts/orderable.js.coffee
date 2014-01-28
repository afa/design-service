# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

//= require ajax_submit
//= require attachment_submit
//= require drag_n_drop
//= require price_calculator

$(document).ready ->
  $('li.' + $('body').attr('id')).addClass('selected')

  register_destroy_attachment_buttons = ->
    $('.delete_attachment').click (event)->
      attachment_url = $(event.target).data('attachment-url')
      destroy_attachment(attachment_url,
        success: ->
          $(event.target).closest('li.attachment_item').remove()
      )

  register_destroy_attachment_buttons()
  $('.loaded_files.enabled').on('change', register_destroy_attachment_buttons)

  $('.order_fields').each ->
    order_fields = $(this)
    order_form = order_fields.find('form.orderable')
    loaded_files = order_fields.find('.loaded_files')
    attach_place_for_box = order_form.find('.attach_place_for_box')
    attach_box = order_fields.find('.attach_box')

    attach_box.offset(attach_place_for_box.offset())
    attach_place_for_box.after(loaded_files)
    attach_box.append( order_fields.find('.attach_info_block') )
    attach_place_for_box.after($('.attach_info_block'))

    order_form.find('.submit').click (event)->
      event.preventDefault()

    order_form.find('.reset').click (event)->
      # To be rewritten (create new draft instead)
      event.preventDefault()
      $(event.target).closest('form').get(0).reset() # don't work
      $(event.target).closest('form').trigger('reset')

    register_drag_n_drop(attach_box, loaded_files)
  #register_price_calculator($('.calcContainer'), 5000)

  # interiors' markup need some changes with JS
  $('.interior ul li:last-child label').append($('.interior ul + input[type="text"]'))
  $('.interior input[type="text"]').change ->
    $('.interior input[type="radio"]').last().get(0).checked = true

  selectCheckedEngineeringSystems = (select) ->
    $('.warning_show').each ->
      checker = $(this).is(':checked')
      li_near = $(this).parent().next('li')
      if checker is true
        li_near.show()
        $('ol.eng_systems li.'+ $(this).attr('id')).show()
        $(this).focusin()
      else
        li_near.hide()
        $('ol.eng_systems li.'+$(this).attr('id')).hide()

  selectCheckedEngineeringSystems(document)
  $('.warning_show').on('click', selectCheckedEngineeringSystems)



  selectChecked_what_attach = () ->
    s=0
    $('.what_to_attach').each ->
      checker = $(this).is(':checked')
      if checker is true
        s++
        $('ol.selected_forms li.'+ $(this).attr('id')).show()
        $('html,body').animate({scrollTop: $('.attach_box').offset().top},'fast')
      else
        s--
        $('ol.selected_forms li.'+$(this).attr('id')).hide()
    if(s==-5)
      $('span.attach_info_block.caution').hide()
    else  
      $('span.attach_info_block.caution').show()
  selectChecked_what_attach(document) 
  $('.what_to_attach').on('click',selectChecked_what_attach)

