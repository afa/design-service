# In html there should be single `#black_content` and a number of `.black_content_blocks`
# .black_content_block contain blocks which will be rendered in #black_content one at a time
# to show block you invoke:
#   show_fly_window('.certain_block_selector')
# to hide you invoke:
#   close_fly_window()

window.show_fly_window = (element_name) ->
  element_to_render = $('.black_content_blocks').find(element_name)
  black_content = $("#black_content")
  black_content.append( element_to_render )
  black_content.css(height: $(document).height()).show()
  element_to_render.show()

window.close_fly_window = ->
  rendered_element = $("#black_content").children()
  $("#black_content").hide()
  $('.black_content_blocks').first().append( rendered_element )

$(document).ready ->
  $(document).on('click', ".close_fly_window", close_fly_window)
