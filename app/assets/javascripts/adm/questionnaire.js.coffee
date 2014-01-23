//= require adm/headers

$(document).ready ->

  register_ajax_reloadable_handler = (selector)->
    $(selector).click (event)->
      $.post '/adm/questionnaire/set_headers', {id: $('#questionnaire_id').attr('value'), name: $('#questionnaire_name').val(), specialization_id: $('.select_specialization').val()}, success_standart
  register_ajax_reloadable_handler('.save_header_data')

  register_ajax_reloadable_handler = (selector)->
    $(selector).click (event)->
      body = $(this).parent();
      position = body.find('.field_position').val();
      location = body.find('.field_location').val();
      is_necessarily = body.find('.field_is_necessarily').val();
      questionnaire_fields_questionnaire_id = body.find('.questionnaire_fields_questionnaire_id').attr('value');
      value = body.find('.field_value').val();

      $.post '/adm/questionnaire_fields_questionnaire/set_field', {position: position, location: location, is_necessarily: is_necessarily, questionnaire_fields_questionnaire_id: questionnaire_fields_questionnaire_id, value: value}, success_standart_dynamic
  register_ajax_reloadable_handler('.save_field_in_questionnaire')

  register_ajax_reloadable_handler = (selector)->
    $(selector).click (event)->
      $.post '/adm/questionnaire/add_field', {id: $('#questionnaire_id').attr('value'), questionnaire_field_id: $('.select_field_for_add').val()}, success_standart
  register_ajax_reloadable_handler('.add_field_in_questionnaire')

  register_ajax_reloadable_handler = (selector)->
    $(selector).click (event)->
      body = $(this).parent();
      questionnaire_fields_questionnaire_id = body.find('.questionnaire_fields_questionnaire_id').attr('value');

      $.ajax({
        type: "DELETE",
        url: '/adm/questionnaire_fields_questionnaire/'+questionnaire_fields_questionnaire_id,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: success_standart,
        error: error_standart
      })
  register_ajax_reloadable_handler('.del_field_from_questionnaire')