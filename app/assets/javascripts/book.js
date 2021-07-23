$(document).on('turbolinks:load', function(){
  $('#read-more-link').click(function(){
    $(event.preventDefault());
    $('#description').hide()
    $('#full_description').show()
  })

  $('#hide-read-more-link').click(function(){
    $(event.preventDefault());
    $('#description').show()
    $('#full_description').hide()
  })

  $('#minus').click(function(){
    $(event.preventDefault());
    var current_value = Number($('.book-count-input').val());

    if (current_value > 1) {
      $('.book-count-input').val(current_value -= 1)
    }
  })

  $('#plus').click(function(){
    $(event.preventDefault());
    var current_value = Number($('.book-count-input').val());

    if (current_value < 10) { 
      $('.book-count-input').val(current_value += 1)
    }
  })

})