$(document).on('turbolinks:load', function(){
  $('.cart-minus').on('click', function(event){
    $(event.preventDefault()); 
    var current_item = $(this).parents('.input-group');
    updateBookQuantity('minus', current_item)
  })

  $('.cart-plus').on('click', function(event){
    $(event.preventDefault()); 
    var current_item = $(this).parents('.input-group');
    updateBookQuantity('plus', current_item)
  })

  function updateBookQuantity(symbol, current_item){
    var item_count = $('.book-count-input').val()
    var item_id = $(current_item).find('.current-item-id').val()

    if(symbol == 'plus'){
      $.ajax({
        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
        type: "PUT",
        url: "/order_items/" + item_id,
        data: { item_quantity: item_count, plus: true }
      });
    }
    else{
      $.ajax({
        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
        type: "PUT",
        url: "/order_items/" + item_id,
        data: { item_quantity: item_count, minus: true }
      });
    }
  }
})