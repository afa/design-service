//= require ajax_submit

$(document).ready ->

  # отправка всей анкеты
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

  # отправка аватара и его отображение
  register_ajax_reloadable_handler = (selector)->
    $(selector).change (event)->
      $(this).next().attr('value', $(this).next().next().attr('value'))
      el = $(this)
      multipart_ajax_sendform($('.add_worksheet_form'), 'POST',
        success: (data, textStatus, xhr)->
          $('.user_avatar_field').attr('value', '0')
          el.parent().prev().find('.photo').html('<img src="'+data['photo']+'" style="width: 150px; height: 150px;">')
          el.next().next().next().attr('value', data['worksheet_field_id'])
          form.get(0).reset()
          file_field.change()
          success_handler = callbacks['success'] || ->{}
          success_handler(data, textStatus, xhr)
        error: (xhr, textStatus, error)->
          #error_handler = callbacks['error'] || ->{}
          #error_handler(xhr, textStatus, error)
      )
  register_ajax_reloadable_handler('.questionnaire_field_user_avatar')

  register_ajax_reloadable_handler = (selector)->
    $(selector).click (event)->
      $(this).parent().find('.border').removeClass('border')
      $(this).addClass('border')
  register_ajax_reloadable_handler('ul .images li')

  register_ajax_reloadable_handler = (selector)->
    $(selector).click (event)->
      body = $(this).parent()
      if body.find('.question_field_check_value').attr('value') == "false"
        body.find('.check_select_label_true').removeClass('hidden')
        body.find('.check_select_label_false').addClass('hidden')
        body.find('.question_field_check_value').attr('value', 'true')
        body.find('.knowledge_level').css('display', 'block')
      else
        body.find('.check_select_label_false').removeClass('hidden')
        body.find('.check_select_label_true').addClass('hidden')
        body.find('.question_field_check_value').attr('value', 'false')
        body.find('.knowledge_level').css('display', 'none')

  register_ajax_reloadable_handler('.check_select_label')

  register_ajax_reloadable_handler = (selector)->
    $(selector).click (event)->
      body = $(this).parent().parent()
      body.find('.check_select_level_value').attr('value', parseInt($(this).find('span').text()))
      body.find('li').removeClass('selected')
      this_level = $(this).attr('class')
      body.find('li').each (index, element) ->
        return false if $(element).attr('class') == this_level
        $(element).addClass('selected')
      $(this).addClass('selected')

  register_ajax_reloadable_handler('.check_select_level li')

  register_ajax_reloadable_handler = (selector)->
    $(selector).click (event)->
      number_next = $(this).next().attr('value')
      data_id = $(this).next().next().attr('value')
      body = $(this).parent().parent()
      str = '<li class="experience_field1">'
      str += body.find('.experience_field1').html()
      str += '</li>'
      str += '<li class="experience_field2">'
      str += body.find('.experience_field2').html()
      str += '</li>'
      str += '<li class="experience_field3">'
      str += body.find('.experience_field3').html()
      str += '</li>'

      $(this).parent().before(str)
      body1 = $(this).parent().prev().prev().prev()
      body1.find('.experience_name').attr('name', 'question_field[experience_name_'+number_next+'-'+data_id+']')

      body2 = $(this).parent().prev().prev()
      body2.find('.experience_position').attr('name', 'question_field[experience_position_'+number_next+'-'+data_id+']')

      body3 = $(this).parent().prev()
      body3.find('.experience_description1').attr('name', 'question_field[experience_description_'+number_next+'_1-'+data_id+']')
      body3.find('.experience_description2').attr('name', 'question_field[experience_description_'+number_next+'_2-'+data_id+']')
      body3.find('.experience_description3').attr('name', 'question_field[experience_description_'+number_next+'_3-'+data_id+']')

      $(this).next().attr('value', (parseInt(number_next) + 1))
  register_ajax_reloadable_handler('.add_new_fields_experience')

  register_ajax_reloadable_handler = (selector)->
    $(selector).click (event)->
      number_next = $(this).next().attr('value')
      data_id = $(this).next().next().attr('value')
      body = $(this).parent().parent()
      str = '<li class="experience_field1">'
      str += body.find('.experience_field1').html()
      str += '</li>'
      str += '<li class="experience_field4">'
      str += body.find('.experience_field4').html()
      str += '</li>'
      str += '<li class="experience_field2">'
      str += body.find('.experience_field2').html()
      str += '</li>'
      str += '<li class="experience_field3">'
      str += body.find('.experience_field3').html()
      str += '</li>'

      $(this).parent().before(str)
      body1 = $(this).parent().prev().prev().prev().prev()
      body1.find('.experience_name').attr('name', 'question_field[experience_name_'+number_next+'-'+data_id+']')

      body2 = $(this).parent().prev().prev()
      body2.find('.experience_position').attr('name', 'question_field[experience_position_'+number_next+'-'+data_id+']')

      body3 = $(this).parent().prev()
      body3.find('.experience_description1').attr('name', 'question_field[experience_description_'+number_next+'_1-'+data_id+']')
      body3.find('.experience_description2').attr('name', 'question_field[experience_description_'+number_next+'_2-'+data_id+']')
      body3.find('.experience_description3').attr('name', 'question_field[experience_description_'+number_next+'_3-'+data_id+']')

      body4 = $(this).parent().prev().prev().prev()

      body4.find('.experience_date_start').attr('name', 'question_field[experience_date_start_'+number_next+'-'+data_id+']')
      body4.find('.experience_date_end').attr('name', 'question_field[experience_date_end_'+number_next+'-'+data_id+']')

      body4.find('.experience_location_country').attr('name', 'question_field[experience_country_'+number_next+'-'+data_id+']')
      body4.find('.experience_location_region').attr('name', 'question_field[experience_region_'+number_next+'-'+data_id+']')
      body4.find('.experience_location_city').attr('name', 'question_field[experience_city_'+number_next+'-'+data_id+']')

      $(this).next().attr('value', (parseInt(number_next) + 1))
  register_ajax_reloadable_handler('.add_new_fields_experience_max')

  register_ajax_reloadable_handler = (selector)->
    $(selector).click (event)->
      $(this).parent().next().attr('value', $(this).next().attr('value'))
  register_ajax_reloadable_handler('.question_field_yes_no')

  register_ajax_reloadable_handler = (selector)->
    $(selector).click (event)->
      number_next = $(this).next().attr('value')
      data_id = $(this).next().next().attr('value')
      body = $(this).parent().parent()
      str = '<li class="value_field">'
      str += body.find('.value_field').html()
      str += '</li>'

      $(this).parent().before(str)
      body1 = $(this).parent().prev()
      body1.find('.experience_name').attr('name', 'question_field[experience_name_'+number_next+'-'+data_id+']')
      body1.find('.span_empty').html(number_next + '.')

      $(this).next().attr('value', (parseInt(number_next) + 1))
  register_ajax_reloadable_handler('.add_new_fields_value')