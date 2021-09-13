$(document).on('turbolinks:load', function(){
  $('#use-billing-address').click(function(e){
    var checked = $('#use-billing-address').attr("checked");
    if (checked){
      $('.shipping-form').css('display', 'inline');
      $('#use-billing-address').attr('checked', false);
    }
    else {
      $('.shipping-form').css('display', 'none');
      $('#use-billing-address').attr('checked', true);
    }
  })

})
