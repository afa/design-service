$(document).ready ->

  make_new = (x) ->
    x.append('<li><input class="textlines_default textline_l6"></li>')
    check_empty_fields()

  check_before_add = (path) ->
    c=0
    pare = path.parent().parent()
    $(pare).find('li input').each ->
      if($(this).val().length<3)
        c++
    if(c==0)    
      make_new(pare)

  check_empty_fields  = () ->
    $('.textline_l6')
    .focusout ->
      if($(this).val().length<3)
        $(this).parent().remove()
      check_before_add($(this))    

    .blur ->
      check_before_add($(this))


  $('.refuce_order').click ->
    $(this).parent().fadeOut 500, ->
      $(this).parent().find('.order_refuce').fadeIn 600
      $(this).hide 400, ->
        $(this).remove()


  check_empty_fields()
