$(document).ready ->
  $('.percentage_blocks').each (idx, element)->
    percentage = parseInt($(element).find('.value_percent').html())
    len = 200 * percentage/100
    $(element).find('.percentage').css(width: len)
