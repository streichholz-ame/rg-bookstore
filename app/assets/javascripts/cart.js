$(document).on('turbolinks:load', function(){

  $(this).find('.cart_item').find('#minus').click(function(){
    $(event.preventDefault()); 
    var input = $(this).next()
    var current_value = Number(input.val());
    if (current_value > 1) {
      input.val(current_value -= 1)
    }
  })

  $('.cart_item').find('#plus').click(function(event){
    $(event.preventDefault());
    var input = $(this).prev()
    var current_value = Number(input.val());
    if (current_value < 10) { 
      input.val(current_value += 1)
    }
  })

})