//= require login_box

$(document).ready ->
  $('.postRequest').click (event)->
    ajax_sendform($(event.target).closest('form'), 'POST',
      success: ->
        alert('Информация успешно сохранена');
      error: ->
        alert('Не удалось поменять ваш профиль')
    )

  show_fly_window('#register')
