$(document).ready(function() {
  $(".order-row").click(function() {
    window.location = $(this).data("href");
  });
})