//= require adm/headers

$(document).ready ->

  register_ajax_reloadable_handler = (selector)->
    $(selector).click (event)->
      $.post '/adm/questionnaire/set_headers', {id: $('#questionnaire_id').attr('value'), name: $('#questionnaire_name').val(), specialization_id: $('.select_specialization').val()}, success_standart
  register_ajax_reloadable_handler('.save_header_data')