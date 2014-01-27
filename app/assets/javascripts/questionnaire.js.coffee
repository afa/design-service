//= require ajax_submit

$(document).ready ->

  register_ajax_reloadable_handler = (selector)->
    $(selector).click (event)->
      multipart_ajax_sendform($('.add_worksheet_form'), 'POST',
        success: (data, textStatus, xhr)->
          form.get(0).reset()
          file_field.change()
          success_handler = callbacks['success'] || ->{}
          success_handler(data, textStatus, xhr)
        error: (xhr, textStatus, error)->
          #error_handler = callbacks['error'] || ->{}
          #error_handler(xhr, textStatus, error)
      )
  register_ajax_reloadable_handler('#add_worksheet')

  register_ajax_reloadable_handler = (selector)->
    $(selector).click (event)->
      $(this).parent().find('.border').removeClass('border')
      $(this).addClass('border')
  register_ajax_reloadable_handler('ul .images li')

  register_ajax_reloadable_handler = (selector)->
    $(selector).click (event)->
      el = $(this).next();
      if el.attr('value') == "false"
        el.attr('value', 'true')
        el.parent().find('.knowledge_level').css('display', 'block')
      else
        el.attr('value', 'false')
        el.parent().find('.knowledge_level').css('display', 'none')

  register_ajax_reloadable_handler('.check_select_label')

  register_ajax_reloadable_handler = (selector)->
    $(selector).click (event)->
      $(this).parent().parent().find('.check_select_level_value').attr('value', parseInt($(this).find('span').text()))
  register_ajax_reloadable_handler('.check_select_level li')