# In html there should be single `#black_content` and a number of `.black_content_blocks`
# .black_content_block contain blocks which will be rendered in #black_content one at a time
# to show block you invoke:
#   show_fly_window('.certain_block_selector')
# to hide you invoke:
#   close_fly_window()

get_black_content_block = ->
  blocks = $('.black_content_blocks')
  if blocks.length == 0
    new_block = $('<div class="black_content_blocks"/>')
    $('body').append(new_block)
    new_block
  else
    blocks.first()

window.close_fly_window = ->
  rendered_element = $("#black_content").children()
  $("#black_content").hide()
  get_black_content_block().append(rendered_element)

window.show_fly_window_by_element = (element_to_render)->
  close_fly_window()
  black_content = $("#black_content")
  black_content.append(element_to_render)
  black_content.css(height: $(document).height()).show()
  $('body').animate({scrollTop: 0}, 'slow')
  element_to_render.show()

window.show_fly_window = (element_name) ->
  show_fly_window_by_element( $('.black_content_blocks').find(element_name).first() )

window.show_fly_window_from_url = (obtain_form_url, customize_window)->
  customize_window ||= {}
  customize_window['preprocess'] ||= (window_element)-> window_element
  customize_window['postprocess'] ||= (window_element)-> window_element
  ajax_request(obtain_form_url, 'GET', '',
    success: (data, status, xhr)->
      form_html = $(data['form_html'])
      form_html = customize_window['preprocess'](form_html)
      form_html.find('.close_fly_window').click ->
        form_html.remove()
      show_fly_window_by_element(form_html)
      customize_window['postprocess'](form_html)
    error: ->
      ;
  )

$(document).ready ->
  $(document).on('click', ".close_fly_window", close_fly_window)
