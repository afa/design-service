# Multiple files upload

window.registerDropZoneMultipleFileHandlers = (dropZone) ->
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
      dropZone_hint.text('Извините, вы можете загрузить не более одного файла за раз!')
      dropZone.addClass('error')
      return false

    file = files[0]
    if file.size > maxFileSize
      dropZone_hint.text('Файл ' + file.name + ' слишком большой!')
      dropZone.addClass('error')
      return false

    dropZone.removeClass('error')

    dropZone_hint.text('Вы добавили файл ' + file.name)
    dropZone.addClass('drop')

    free_slots = ->
      result = []
      for inp in $('input[type="file"]')
        result.push(inp)  unless inp.files && inp.files[0] && inp.files[0].name
      result

    if files.length > free_slots().length
      for i in [0...(files.length - free_slots().length)]
        $('.add_nested_fields', dropZone).trigger('click')

    free_slots()[0].files = files

  dropZone[0].ondrop = drop_handler

  dropZone[0].ondragover = ->
    dropZone.addClass('hover')
    false
  dropZone[0].ondragleave =  ->
    dropZone.removeClass('hover')
    false

  $(document).on 'nested:fieldRemoved', (event) ->
    field = event.field
    if field.find('input[type="file"]')[0].files[0]  &&  field.find('input[type="file"]')[0].files[0].name
      dropZone_hint.text('Вы удалили файл ' + field.find('input[type="file"]')[0].files[0].name)
