# Drag-n-drop ability. Files which were dropped will be putted in usual file-field
window.register_drag_n_drop = (attach_box, loaded_files)->

  reload_attachments_list = (text)->
    loaded_files.html(text)
    loaded_files.change()

  dropZone = attach_box.find('.dropZone')
  attach_form = attach_box.find('form')
  attachment_input = attach_form.find('input[type=file]')
  dropZone_hint = attach_box.find('.hint')

  if Modernizr.draganddrop && !!window.FileReader
    dropZone_hint.text('Вы можете перетащить файлы сюда')
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
  else
    dropZone_hint.text('Выбрать файлы')

  attachment_input.change (event)->
    files = event.target.files
    if files.length == 0
      dropZone.removeClass('drop')
      if Modernizr.draganddrop && !!window.FileReader
        dropZone_hint.text('Вы можете перетащить файлы сюда')
      else
        dropZone_hint.text('Выбрать файлы')
    else if files.length == 1
      file = files[0]
      # max file size - 100 Mb
      maxFileSize = 100000000
      if (file.size > maxFileSize)
        dropZone_hint.text('Файл слишком большой!')
        dropZone.addClass('error')
        return false
      else
        dropZone.removeClass('error')
        dropZone_hint.text('Вы добавили файл ' + file.name)
        dropZone.addClass('drop')
        send_file(attach_box.find('form'),
          success: (data, textStatus, xhr)->
            reload_attachments_list(data['list_of_attachments'])
        )
