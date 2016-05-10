# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->

  $('#starts_at_visible').datepicker({
        changeMonth: true,
        changeYear: true,
        dateFormat: "mm/dd/yy",
        yearRange:  "1900:+0",
        altField:   "#starts_at",
        altFormat:  "yy-mm-dd",
        duration:   "fast"
  });
  $('#ends_at_visible').datepicker({
        changeMonth: true,
        changeYear: true,
        dateFormat: "mm/dd/yy",
        yearRange:  "1900:+0",
        altField:   "#ends_at",
        altFormat:  "yy-mm-dd",
        duration:   "fast"
  });


$(document).ready(ready)
$(document).on('page:load', ready)

