$(document).on('ready page:load', function() {
  $(".best_in_place").best_in_place();

  $(".my-form").bind("ajax:success", function(e, data, status, xhr) {
    var $this = $(this);
    $this.find('input:text,textarea').val('').focus();
  });
});