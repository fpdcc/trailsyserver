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

  $('.cancel-button').on('click', function () {
    $('.form-new').hide();
  });

  $('.alert_alert_type').on('change', function () {
    var itemId = $(this).attr('dataid');
    var value = $(this).val();
    var formGroupReason = "#form-group-reason-" + itemId;
    var fieldNameReason = "#field-reason-" + itemId;
  	if (value == 'closure') {
  	  $(formGroupReason).show();
  	  //$('#field-description').hide();
  	} else {
  	  $(fieldNameReason).val('');
      $(formGroupReason).hide();
  	  //$('#field-description').show();
  	}
  });

  $('.alert_reason').on('change', function () {
    console.log("reason change")
    var itemId = $(this).attr('dataid');
    var value = $(this).val();
    console.log("Value = " + value + " + itemId = " + itemId)
    var fieldDescription = "#field-description-" + itemId;
    if (value) {
      console.log('in the reason if statement')
      var description = "Parking area closed due to " + value + '.'
      $(fieldDescription).val(description);
    } else {
      $(fieldDescription).val('');
    }
  });

});