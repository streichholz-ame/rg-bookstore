$(document).on('turbolinks:load', function(){
  $('#destroy-account-checkbox').click(function(e){
    var checked = $('#destroy-account-checkbox')[0].hasAttribute('checked');
    if (checked){
      $('#destroy-account-btn').attr('disabled', true);
      $('#destroy-account-checkbox').attr('checked', false);
    }
    else {
      $('#destroy-account-btn').attr('disabled', false);
      $('#destroy-account-checkbox').attr('checked', true);
    }
  })
})
