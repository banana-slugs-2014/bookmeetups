var Bookmeetups = Bookmeetups || {};

$(document).ready(function() {
  $('body').on("ajax:success", '.open-new-message', function(event,response){
    $('.messages').prepend(response);
  });
  $('body').on("ajax:success", '#new_message', function(event, response){
    $('.messages').prepend(response);
    $('form').remove();
  })
});