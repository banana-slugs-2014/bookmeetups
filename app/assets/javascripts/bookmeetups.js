var Bookmeetups = Bookmeetups || {};

$(document).ready(function() {
  $('body').on("ajax:success", '.open-new-message', function(event,response){
    $('.messages').prepend(response);
    $('.open-new-message').hide();
  });
  $('body').on("ajax:success", '#new_message', function(event, response){
    $('.messages').prepend(response);
    $('form').remove();
    $('.open-new-message').show();
  });
});