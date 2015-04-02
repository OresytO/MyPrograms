/**
 *
 *
 * @author OrestO
 * @since 3/26/2015
 */

function sendContent(url) {
  $('.content').load('/rebok3J' + url);
}

$(document).ready(function () {
  $(document).on('submit', 'form.ajaxSubmitForm', function () {
    $.ajax({
      url: $(this).attr('action'),
      type: $(this).attr('method'),
      dataType: 'json',
      data: $(this).serialize(),
      success: function (data) {
        alert('Submitted');
      },
      error: function (xhr, err) {
        alert('Error');
      }
    });
    return false;
  });
  $('table.dataTable').dataTable({
    "scrollY": "440px",
    "scrollCollapse": true/*,
    "jQueryUI": true*/
  });
  $('input.datePicker').datepicker();
  $(window).scroll(function() {
    if ($(this).scrollTop() > 1){
      $('.header').addClass("sticky");
    }
    else{
      $('.header').removeClass("sticky");
    }
  });
});