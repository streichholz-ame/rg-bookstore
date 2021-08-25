$(document).ready(function () {
  $('.book-rating').click(function() {
    labelID = $(this).attr('for');
    $('#'+labelID).trigger('click');
  });


  $('.book-rating').on('click', function () {
    var star = $(this).children('i')
    if(star.hasClass('fa-star-o')){
      star.removeClass('fa-star-o')
      star.addClass('fa-star')
    }
    else{
      star.addClass('fa-star-o')
      star.removeClass('fa-star')
    }
  });

  $('.book-rating').on('click', function () {
    labelID = $(this).attr('for');
    var radio_btn = $('#' + labelID)

    for(i = 1; i<=5; i++){
      if(i <= radio_btn.val()){
        $(document).find('label[for=review_rating_' + i + ']').find('i').addClass('fa-star').removeClass('fa-star-o')
      }
      else{
        $(document).find('label[for=review_rating_' + i + ']').find('i').addClass('fa-star-o').removeClass('fa-star')
      }
    }
  });
})