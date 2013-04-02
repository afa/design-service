$(document).ready ->
  dropZone = $('#dropZone')
  maxFileSize = 1000000; # максимальный размер файла - 1 мб.

  if typeof(window.FileReader) == 'undefined'
    dropZone.text('Не поддерживается браузером!')
    dropZone.addClass('error')
    
  dropZone[0].ondragover = ->
    dropZone.addClass('hover')
    false
  
  dropZone[0].ondragleave = ->
    dropZone.removeClass('hover')
    false

  dropZone[0].ondrop = (event) ->
    event.preventDefault()
    
    dropZone.text('Вы положили файл!')
    dropZone.removeClass('error')
    
    dropZone.removeClass('hover')
    dropZone.addClass('drop')
    file = event.dataTransfer.files[0]
          
    if (file.size > maxFileSize)
      dropZone.text('Файл слишком большой!')
      dropZone.addClass('error')
      false
    
    xhr = new XMLHttpRequest()
    xhr.upload.addEventListener('progress', uploadProgress, false)
    xhr.onreadystatechange = stateChange
    xhr.open('POST', '/upload.php')
    xhr.setRequestHeader('X-FILE-NAME', file.name)
    xhr.send(file)
  
  uploadProgress = (event) ->
    percent = parseInt(event.loaded / event.total * 100)
    dropZone.text('Загрузка: ' + percent + '%')

  stateChange = (event) ->
    if event.target.readyState == 4
      if event.target.status == 200
        dropZone.text('Загрузка успешно завершена!')
      else
        dropZone.text('Произошла ошибка!')
        dropZone.addClass('error')