# Singular file upload (for the only file input element on page)

$(document).ready ->
  dropZone = $('#dropZone')
  maxFileSize = 100000000; # max file size - 100 Mb

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
    file = event.dataTransfer.files[0]
    
    dropZone.text('Вы добавили файл' + file.name)
    dropZone.removeClass('error')
    
    dropZone.removeClass('hover')
    dropZone.addClass('drop')

    if (event.dataTransfer.files.length > 1)
      dropZone.text('Вы можете загрузить только один файл!')
      dropZone.addClass('error')
      false
    
    if (file.size > maxFileSize)
      dropZone.text('Файл слишком большой!')
      dropZone.addClass('error')
      false

    file_input = $("input[type='file']")
    file_input.prop("files", file)