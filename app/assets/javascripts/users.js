$(document).ready(function() {

  $('.users-album-view-link').click(function(){
    console.log("on click");
    $('#users-album-view').show(0);
    $('#users-followers-view').hide(0);
    $('#users-following-view').hide(0);
  });

  $('.users-followers-link').click(function(){
    console.log("on click");
    $('#users-followers-view').show(0);
    $('#users-album-view').hide(0);
    $('#users-following-view').hide(0);
  });

  $('.users-following-link').click(function(){
    console.log("on click");
    $('#users-following-view').show(0);
    $('#users-album-view').hide(0);
    $('#users-followers-view').hide(0);
  });

});
