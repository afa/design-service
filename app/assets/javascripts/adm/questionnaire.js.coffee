//= require adm/headers
//= require attachment_submit

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

  register_ajax_reloadable_handler = (selector)->
    $(selector).click (event)->
      body = $(this).parent();
      question_id = body.find('.question_id').attr('value');
      name = body.find('.question_name').val();
      count_all = body.find('.question_count_all').val();
      count_true = body.find('.question_count_true').val();
      position = body.find('.question_position').val();

      $.ajax({
        type: "PUT",
        url: '/adm/question/'+question_id,
        dataType: "json",
        data: {name: name, count_all: count_all, count_true: count_true, position: position},
        success: success_standart_dynamic,
        error: error_standart
      })
  register_ajax_reloadable_handler('.save_question_headers')

  register_ajax_reloadable_handler = (selector)->
    $(selector).click (event)->
      $.post '/adm/question/add_field', {question_id: $(this).next().attr('value'), display: $(this).parent().find('.display_for_add_in_question').val()}, success_standart
  register_ajax_reloadable_handler('.add_field_in_question')

  register_ajax_reloadable_handler = (selector)->
    $(selector).click (event)->
      body = $(this).parent().parent();
      kind = body.find('.question_new_kind').val();
      $.post '/adm/question', {kind: kind, questionnaire_id: $('#questionnaire_id').attr('value')}, success_standart
  register_ajax_reloadable_handler('.add_question')

  register_ajax_reloadable_handler = (selector)->
    $(selector).click (event)->
      body = $(this).parent().parent();
      if confirm('Удалить вопрос?')
        $.ajax({
          type: "DELETE",
          url: '/adm/question/'+body.find('.question_id').attr('value'),
          dataType: "json",
          success: success_standart,
          error: error_standart
        })
  register_ajax_reloadable_handler('.del_question')

  register_ajax_reloadable_handler = (selector)->
    $(selector).click (event)->
      $.post '/adm/question_field/set_name', {name: $(this).prev().val(), id: $(this).next().attr('value')}, success_standart
  register_ajax_reloadable_handler('.save_question_field_name')

  register_ajax_reloadable_handler = (selector)->
    $(selector).change (event) ->
      console.info(event.target.files)
      files = event.target.files

      send_file($(this).parent(), (data)->
        
      )
  register_ajax_reloadable_handler('.photo_for_test')

  register_ajax_reloadable_handler = (selector)->
    $(selector).click (event)->
      $.ajax({
          type: "DELETE",
          url: '/adm/question_field/'+$(this).next().attr('value'),
          dataType: "json",
          success: success_standart,
          error: error_standart
        })
  register_ajax_reloadable_handler('.del_question_field')