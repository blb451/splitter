$(document).ready(function() {

  $('.top-users-link').click(function(){
    $('#top-users-list').show();
    $('#album-list').hide();
    $('#news-feed-list').hide();

  });

  $('.album-list-link').click(function(){
    $('#album-list').show();
    $('#top-users-list').hide();
    $('#news-feed-list').hide();

  });

  $('.news-feed-link').click(function(){
    $('#news-feed-list').show();
    $('#top-users-list').hide();
    $('#album-list').hide();


  });

  $(function() {
    return $('.music-table').infinitePages({
      loading: function() {
        return $(this).text('Loading next page...');
      },
      error: function() {
        return $(this).button('There was an error, please try again');
      }
    });
  });


  $('.newspagination').hide()


});
