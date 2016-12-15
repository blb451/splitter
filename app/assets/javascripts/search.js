$(document).ready(function () {
  $(".spinner").hide();

  $(document).ajaxStart(function() {
    $('.index-list').hide()
    $('.album-show-page').hide()
    $('.artist-show-page').hide()
    $(".spinner").fadeIn('slow');
  }).ajaxStop(function() {
      $(".spinner").hide();
  });
});
