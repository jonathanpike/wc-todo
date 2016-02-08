$(document).on('ready page:load', function() {
  $(".best_in_place").best_in_place();
  $(".my-form, #completed, .delete, .all-complete, .clear").on("ajax:success", function(e, data, status, xhr) {
    location.reload();
  });
});