window.draw_percentage_box = (element, value_selector, box_selector) ->
  percentage = parseInt($(element).find(value_selector).html());
  len = 200 * percentage/100;
  $(element).find(box_selector).css('width', len);
