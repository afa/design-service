# Drag-n-drop ability. Files which were dropped will be putted in usual file-field
window.register_drag_n_drop = (attach_box, loaded_files)->

  reload_attachments_list = (text)->
    loaded_files.html(text)
    loaded_files.change()

  dropZone = attach_box.find('.dropZone')
  attach_form = attach_box.find('form')
  attachment_input = attach_form.find('input[type=file]')
  dropZone_hint = attach_box.find('.hint')

  attach_url = attach_form.attr('action')

  send_files = (files)->
    $.each files, (idx, file)->
      maxFileSize = 100*1024*1024 # max file size - 100 Mb
      if (file.size > maxFileSize)
        alert('Максимальный размер файла - 100mb')
        return false

      data = new FormData
      data.append('attachment[file]', file)
      multipart_ajax_request attach_url, 'POST', data,
        success: (data, textStatus, xhr)->
          reload_attachments_list(data['list_of_attachments'])
          alert('Файл загружен')
        error: (xhr, textStatus, error)->
          alert('Не удалось загрузить файл')


  dropZone_hint.text('Вы можете перетащить файлы сюда или выбрать файлы, кликнув на иконку слева')
  dropZone.on('drop', (event) ->
    event.preventDefault()
    dropZone.removeClass('hover')
    send_files event.originalEvent.dataTransfer.files
  )

  dropZone.on('dragover', ->
    dropZone.addClass('hover')
    false
  )

  dropZone.on('dragleave', ->
    dropZone.removeClass('hover')
    false
  )

  attachment_input.change (event)->
    send_files event.target.files
    attach_form.reset()
