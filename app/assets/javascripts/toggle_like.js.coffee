window.register_toggle_like = (controller_name, link_element) ->
  $(link_element)
  .click ->
    $.ajax(url: '/' + controller_name + '/' + link_element.data('resource-id') + '/toggle_like.json', type: 'POST')
    .success (data) ->
      $('.hint', link_element).html(data['toggle_like_text'])

window.register_updownvote = (controller_name, upvote_link_element, downvote_link_element) ->
  $(upvote_link_element)
  .click (event)->
    $.ajax(url: '/' + controller_name + '/' + event.target.data('resource-id') + '/upvote.json', type: 'POST')
    .success (data) ->
      $('.hint', upvote_link_element).addClass('active')
      $('.hint', downvote_link_element).removeClass('active')
  $(downvote_link_element)
  .click ->
    $.ajax(url: '/' + controller_name + '/' + event.target.data('resource-id') + '/downvote.json', type: 'POST')
    .success (data) ->
      $('.hint', downvote_link_element).addClass('active')
      $('.hint', upvote_link_element).removeClass('active')