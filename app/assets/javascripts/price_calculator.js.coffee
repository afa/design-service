window.register_price_calculator = (calc_container, timeout) ->
  worker = ->
    $.ajax(url: '/orders/' + calc_container.data('order') + '/get_price')
    .success (data) ->
      if data['price']?
        $('.count', calc_container).html(data['price']);
        $('.hint', calc_container).html('');
      else
        setTimeout(worker, timeout);
    .error ->
      setTimeout(worker, timeout);
  if calc_container.data('order')?
    worker()
