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
    var currentValue = Number($('.book-count-input').val());

    if (currentValue > 1) {
      $('.book-count-input').val(currentValue -= 1)
    }
  })

  $('#plus').click(function(){
    $(event.preventDefault());
    var currentValue = Number($('.book-count-input').val());

    if (currentValue < 10) { 
      $('.book-count-input').val(currentValue += 1)
    }
  })

})
