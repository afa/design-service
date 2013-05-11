window.register_price_updater = (calc_container, timeout) ->
  worker = ->
    $.ajax(url: '/orders/' + calc_container.data('order') + '/get_price')
    .success (data) ->
      if data['price']?
        $('.count', calc_container).html(data['price']);
      else
        setTimeout(worker, timeout);
    .error ->
      setTimeout(worker, timeout);
  if calc_container.data('order')?
    worker()