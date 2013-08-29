# Multiple files upload
window.register_drag_n_drop = (dropZone, attachment_input, dropZone_hint) ->
  dropZone = $(dropZone)
  dropZone_hint = $(dropZone_hint)
  dropZone_hint.text('Вы можете перетащить файлы сюда')

  $(attachment_input).change (event)->
    files = event.target.files
    if files.length > 1
      dropZone_hint.text('Вы можете загрузить только один файл за раз!')
      dropZone.addClass('error')
      return false
    else if files.length == 0
      dropZone.removeClass('drop')
      dropZone_hint.text('Вы можете перетащить файлы сюда')
    else if files.length == 1
      file = files[0]
      # max file size - 100 Mb
      maxFileSize = 100000000
      if (file.size > maxFileSize)
        dropZone_hint.text('Файл слишком большой!')
        dropZone.addClass('error')
        return false

      dropZone.removeClass('error')
      dropZone_hint.text('Вы добавили файл ' + file.name)
      dropZone.addClass('drop')

  if typeof(window.FileReader) == 'undefined'
    dropZone_hint.text('Перетаскивание файлов не поддерживается браузером!')
    dropZone.addClass('error')

  drop_handler = (event) ->
    event.preventDefault()
    dropZone.removeClass('hover')

    files = event.dataTransfer.files
    if files.length > 1
      dropZone_hint.text('Вы можете загрузить только один файл за раз!')
      dropZone.addClass('error')
      return false

    $(attachment_input).prop('files', files)

  dropZone.get(0).ondrop = drop_handler

  dropZone.get(0).ondragover = ->
    dropZone.addClass('hover')
    false

  dropZone.get(0).ondragleave = ->
    dropZone.removeClass('hover')
    false

  $(attachment_input).onchange = ->
    files = $(attachment_input).get(0).files
    if files.length == 0
      dropZone_hint.text('Вы можете перетащить файлы сюда')
    else if files.length == 1
      dropZone_hint.text('Вы добавили файл ' + files.get(0).name)
