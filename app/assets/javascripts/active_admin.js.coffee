//= require active_admin/base
//= require ajax_submit

$(document).ready ->
  $('.remote_link.post').click ->
    ajax_request($(this).data('url'), 'POST', '', {})
