//= require active_admin/base
//= require ajax_submit
//= require js-routes

$(document).ready ->
  register_ajax_reloadable_handler = (selector)->
    $(selector).click (event)->
      target = $(event.target).closest(selector)
      ajax_request(target.data('url'), 'POST', '',
        success: (response)->
          element_to_reload = target.closest('.ajax_reloadable')
          element_to_reload.replaceWith(response['text'])
          register_ajax_reloadable_handler(selector)
        error: ->
          alert('Operation failed')
      )
  register_ajax_reloadable_handler('.remote_link.post')
