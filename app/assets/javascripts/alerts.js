$(document).on('page:load ready', function () {

  $('.datetimepicker').datetimepicker({
    format: 'YYYY-MM-DD'});

  $('.new-button').on('click', function () {
    console.log("new-button click")
    $('.form-new').hide();
    var itemId = $(this).attr('data-id')
    var formName = "#form-new-" + itemId
    $(formName).toggle();

  });

  $('#alert_alert_type').on('change', function () {
  	if ($('#alert_alert_type').val() == 'closure') {
  	  $('#field-reason').hide();
  	  //$('#field-description').hide();
  	} else {
  	  $('#field-reason').hide();
      $('#field-reason').val('');
  	  //$('#field-description').show();
  	}
  });

  $('#alert_reason').on('change', function () {
    if ($('#alert_reason').val()) {
      console.log('in the reason if statement')
      var description = "Parking area closed due to " + $('#alert_reason').val() + '.'
      $('#alert_description').val(description);
    } else {
      $('#alert_description').val('');
    }
  });

});