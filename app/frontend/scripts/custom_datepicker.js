$(document).on('turbolinks:load', function () {
  $('#event_datetime').datepicker({
    timepicker: true,
    minDate: new Date()
  });
});
