var Bookmeetups = Bookmeetups || {};


Bookmeetups.Controller = function(view){
  this.view = view;
};

Bookmeetups.Controller.prototype = {
  showNewMessage: function(form){
    this.view.displayNewMessageForm(form);
    this.view.hideCreateMessageLink();
  },

  showCreatedMessageEvent: function(newMessage){
    this.view.prependNewMessage(newMessage);

    $('form').remove();
    $('.open-new-message').show();
  }
};

Bookmeetups.View = function(controller){
  this.controller = controller;
};

Bookmeetups.View. prototype = {
  displayNewMessageForm: function(formHTML){
    $('.messages').prepend(formHTML);
  },

  hideCreateMessageLink: function(){
    $('.open-new-message').hide();
  },

  prependNewMessage: function(newMessage){
    $('.messages').prepend(newMessage);
  }
};

Bookmeetups.Binder = function(controller){
  this.controller = controller;
};

Bookmeetups.Binder.prototype = {
  bind: function(){
    this.createMessageForm();
    this.showCreatedMessage();
  },

  createMessageForm: function(){
    var self = this;
    $('body').on("ajax:success", '.open-new-message', function(event,dataForm){
      self.controller.showNewMessage(dataForm);
    });
  },

  showCreatedMessage: function(){
    var self = this
    $('body').on("ajax:success", '#new_message', function(event, newMessage){
      self.controller.showCreatedMessageEvent(newMessage);
    });
  }
};


$(document).ready(function() {

  Bookmeetups.view = new Bookmeetups.View;
  Bookmeetups.controller = new Bookmeetups.Controller(Bookmeetups.view);

  new Bookmeetups.Binder(Bookmeetups.controller).bind();
});