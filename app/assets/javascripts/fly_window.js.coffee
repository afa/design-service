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
  $('body').animate({scrollTop:0},"slow")
  element_to_render.show()

window.close_fly_window = ->
  rendered_element = $("#black_content").children()
  $("#black_content").hide()
  $('.black_content_blocks').first().append(rendered_element)

window.show_fly_form_from_url = (obtain_form_url, element_name, customize_form)->
  customize_form ||= {}
  customize_form['preprocess'] ||= (form)->
    form
  customize_form['postprocess'] ||= (form)->
    form
  ajax_request(obtain_form_url, 'GET', '',
    success: (data, status, xhr)->
      form_html = $(data['form_html'])
      form_html = customize_form['preprocess'](form_html)
      form_html.find('.close_fly_window').click ->
        form_html.remove()
      $('.black_content_blocks').first().append(form_html)
      show_fly_window(element_name)
      customize_form['postprocess'](form_html)
    error: ->
      ;
  )

$(document).ready ->
  $(document).on('click', ".close_fly_window", close_fly_window)
