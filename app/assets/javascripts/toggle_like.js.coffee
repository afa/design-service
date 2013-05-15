window.register_toggle_like = (link_element) ->
  $(link_element)
  .click ->
    $.ajax(url: '/specialists/' + link_element.data('specialist') + '/toggle_like.json', type: 'POST')
    .success (data) ->
      $('.hint', link_element).html(data['toggle_like_text'])
