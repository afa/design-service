# Singular file upload (for the only file input element on page)

window.registerDropZoneSingleFileHandlers = (dropZone) ->
  dropZone_hint = $('.hint', dropZone)
  dropZone_hint.text('Вы можете перетащить файлы сюда')
  maxFileSize = 100000000; # max file size - 100 Mb

  if typeof(window.FileReader) == 'undefined'
    dropZone_hint.text('Не поддерживается браузером!')
    dropZone.addClass('error')

  drop_handler = (event) ->
    event.preventDefault()

    dropZone.removeClass('hover')

    files = event.dataTransfer.files
    if (files.length > 1)
      dropZone_hint.text('Вы можете загрузить только один файл!')
      dropZone.addClass('error')
      return false

    file = files[0]

    if (file.size > maxFileSize)
      dropZone_hint.text('Файл слишком большой!')
      dropZone.addClass('error')
      return false

    dropZone.removeClass('error')
    dropZone_hint.text('Вы добавили файл ' + file.name)
    dropZone.addClass('drop')

    $("input[type='file']", dropZone).prop('files', files)

  dropZone[0].ondrop = drop_handler

  dropZone[0].ondragover = ->
    dropZone.addClass('hover')
    false
  dropZone[0].ondragleave =  ->
    dropZone.removeClass('hover')
    false

#  upload = (file)->
#    xhr = new XMLHttpRequest()
#    xhr.upload.addEventListener('progress', uploadProgress, false)
#    xhr.onreadystatechange = stateChange
#    xhr.open('POST', '/attachments')
#    xhr.setRequestHeader('X-Filename', file.name)
#    xhr.send(file)

#  uploadProgress = (event)->
#    percent = parseInt(event.loaded / event.total * 100);
#    dropZone_hint.text('Загрузка: ' + percent + '%');

#  stateChange = (event)->
#    if (event.target.readyState == 4)
#      if (event.target.status == 200)
#        dropZone_hint.text('Загрузка успешно завершена!')
#      else
#        dropZone_hint.text('Произошла ошибка!')
#        dropZone.addClass('error')

#  $("input[type='file']", dropZone).change (event) ->
#    upload(event.target.files[0])
