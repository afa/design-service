# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

//= require orders
//= require portfolios
//= require ajax_submit

$(document).ready ->
  fill_specialist_info = (profile)->
    $('.info_specialist p.bio_info').text(profile['specialist']['bio_info'])
    $('.info_specialist p.work_info').text(profile['specialist']['work_info'])
    $('.specialist_img_ img').replaceWith(profile['avatar'])
    portfolios_html = profile['portfolios'].reduce(
      (result, portfolio)->
        result + portfolio['portfolio_html']
      ''
    )
    $('.portfolios').html(portfolios_html)

  reload_profile = ->
    ajax_request(Routes.profile_path(format: 'json'), 'GET', '',
      success: (data, status, xhr)->
        fill_specialist_info(data)
        close_fly_window()
    )

  $('.bio_info_form .submit').data('ajax-success', reload_profile)
  $('.work_info_form .submit').data('ajax-success', reload_profile)
  $('.avatar_form .submit').data('ajax-success', reload_profile)


  $('.specialist_img_').click ->
    show_fly_window('.avatar_form')

  $('.change_text.bio_info').click ->
    show_fly_window('.bio_info_form')

  $('.change_text.work_info').click ->
    show_fly_window('.work_info_form')

  $(document).on('ajax:success', '.new_portfolio_form', ->
    close_fly_window()
    reload_profile()
  )
  $(document).on('ajax:success', '.edit_portfolio_form', ->
    reload_profile()
  )
  $(document).on('ajax:success', '.delete_portfolio', reload_profile)

  $(document).on('click', '.add_portfolio', (event)->
    element = $(event.target)
    specialist_id = element.data('specialist-id')
    obtain_form_url = Routes.new_form_specialist_portfolios_path(specialist_id)
    show_fly_window_from_url(obtain_form_url)
  )

  make_photo_removable = (form_html)->
    form_html.find('ul.portfolio_list li').not(':last').each (index, item)->
      $(item).append('<span class="delete"></span>')
    form_html.on('click', 'ul.portfolio_list li span.delete', (event)->
      element = $(event.target).closest('li')
      portfolio_item_id = element.data('portfolio-item-id')
      portfolio_url = Routes.portfolio_item_path(portfolio_item_id)
      ajax_request(portfolio_url, 'DELETE', '',
        success: ->
          alert('Фотография успешно удалена')
          element.remove()
          reload_profile()
        error: ->
          alert('Не удалось удалить фотографию')
      )
    )
    form_html

  make_add_file_button = (form_html)->
    form_html.find('li.add input[type=file]').on('change', (event)->
      multipart_ajax_sendform($(event.target).closest('form'), 'POST',
        success: ->
          reload_profile()
          close_fly_window()
      )
    )
    form_html

  # postprocess should be used for actions that don't work on non-rendered elements
  # preprocess is made before showing flying box, so user won't see these actions
  $(document).on('click', 'span.edit_portfolio', (event)->
    element = $(event.target)
    portfolio_id = element.closest('ul.portfolio').data('portfolio-id')
    obtain_form_url = Routes.edit_form_portfolio_path(portfolio_id)
    show_fly_window_from_url(obtain_form_url,
      preprocess: (form_html)->
        make_photo_removable(form_html)
        make_add_file_button(form_html)
        form_html
      postprocess: (form_html)->
        form_html.find('.images_preview_content').offset( form_html.find('.images_preview_box').offset() )
        form_html
    )

  )
