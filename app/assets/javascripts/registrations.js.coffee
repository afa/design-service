//= require ajax_submit

$(document).ready ->
  $('.postRequest').click (event)->
    #$(event.target).closest('form').get(0).submit()
    ajax_sendform($(event.target).closest('form'), 'POST',
      success: ->
        alert('Информация успешно сохранена');
      error: ->
        alert('Не удалось поменять ваш профиль')
    )
