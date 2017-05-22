$(document).on('page:load ready', function () {

  $('.datetimepicker').datetimepicker({
    format: 'YYYY-MM-DD'});

  $('.new-button').on('click', function () {
    console.log("new-button click")
    $('.form-new').hide();
    $('.form-edit').hide();
    var itemId = $(this).attr('data-alertable-id')
    var itemType = $(this).attr('data-alertable_type')
    console.log("itemId, itemType: " + itemId + ", " + itemType)
    var formName = "#form-new-" + itemId
    $(formName).toggle();
  });

  $('.edit-button').on('click', function () {
    console.log("edit-button click")
    $('.form-new').hide();
    $('.form-edit').hide();
    var itemId = $(this).attr('data-alertable-id')
    var itemType = $(this).attr('data-alertable_type')
    var alertId = $(this).attr('data-alert-id')
    console.log("itemId, itemType: " + itemId + ", " + itemType)
    var formName = "#form-edit-" + itemId + '-' + alertId
    $(formName).toggle();
  });

  $('.cancel-button').on('click', function () {
    $('.form-new').hide();
    $('.form-edit').hide();
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
    var itemId = $(this).attr('data-alertable-id');
    var alertId = $(this).attr('data-alert-id');
    var value = $(this).val();
    console.log("Value = " + value + " + itemId = " + itemId)
    var fieldDescription = "#field-description-" + itemId + '-' + alertId;
    if (value) {
      console.log('in the reason if statement')
      var description = "Parking area closed due to " + value + '.'
      $(fieldDescription).val(description);
    } else {
      $(fieldDescription).val('');
    }
  });

});