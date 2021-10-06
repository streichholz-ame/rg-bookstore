$(document).on('turbolinks:load', function(){
  $('.cart-minus').on('click', function(event){
    $(event.preventDefault()); 
    var currentItem = $(this).parents('.input-group');
    updateBookQuantity('minus', currentItem)
  })

  $('.cart-plus').on('click', function(event){
    $(event.preventDefault()); 
    var currentItem = $(this).parents('.input-group');
    updateBookQuantity('plus', currentItem)
  })

  function updateBookQuantity(symbol, currentItem){
    var itemCount = $('.book-count-input').val()
    var itemId = $(currentItem).find('.current-item-id').val()

    if(symbol == 'plus'){
      $.ajax({
        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
        type: "PUT",
        url: "/order_items/" + itemId,
        data: { item_quantity: itemCount, plus: true }
      });
    }
    else{
      $.ajax({
        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
        type: "PUT",
        url: "/order_items/" + itemId,
        data: { item_quantity: itemCount, minus: true }
      });
    }
  }
})
