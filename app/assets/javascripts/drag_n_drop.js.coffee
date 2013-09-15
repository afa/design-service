# Drag-n-drop ability. Files which were dropped will be putted in usual file-field
window.register_drag_n_drop = (attach_box)->
  dropZone = attach_box.find('.dropZone')
  attach_form = attach_box.find('form')
  attachment_input = attach_form.find('input[type=file]')
  dropZone_hint = attach_box.find('.hint')

  dropZone_hint.text('Вы можете перетащить файлы сюда')

  if typeof(window.FileReader) == 'undefined'
    dropZone_hint.text('Перетаскивание файлов не поддерживается браузером!')
    dropZone.addClass('error')

  attachment_input.change (event)->
    files = event.target.files
    if files.length == 0
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

  dropZone.on('drop', (event) ->
    event.preventDefault()
    dropZone.removeClass('hover')
    files = event.originalEvent.dataTransfer.files
    if files.length > 1
      dropZone_hint.text('Вы можете загрузить только один файл за раз!')
      dropZone.addClass('error')
      return false
    attachment_input.prop('files', files)
  )

  dropZone.on('dragover', ->
    dropZone.addClass('hover')
    false
  )

  dropZone.on('dragleave', ->
    dropZone.removeClass('hover')
    false
  )
