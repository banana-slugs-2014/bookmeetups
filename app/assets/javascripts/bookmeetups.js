var Bookmeetups = Bookmeetups || {};

Bookmeetups.Controller = function(view){
  this.view = view;
};

Bookmeetups.Controller.prototype = {
  showNewMessage: function(form){
    this.view.renderNewMessageForm(form);
  },

  showCreatedMessageEvent: function(newMessage){
    this.view.renderNewMessage(newMessage);
  }
};

Bookmeetups.View = function(){};

Bookmeetups.View.prototype = {
  renderNewMessageForm: function(form){
    this.displayNewMessageForm(form);
    this.hideCreateMessageLink();
  },

  displayNewMessageForm: function(form){
    $('.messages').prepend(form);
  },

  hideCreateMessageLink: function(){
    $('.open-new-message').hide();
  },

  renderNewMessage: function(newMessage){
    this.prependNewMessage(newMessage);
    this.removeNewMessageForm();
    this.showCreateMessageLink();
  },

  prependNewMessage: function(newMessage){
    $('.messages').prepend(newMessage);
  },

  removeNewMessageForm: function(){
    $('#new_message').remove();
  },

  showCreateMessageLink: function(){
    $('.open-new-message').show();
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
    var self = this;
    $('body').on("ajax:success", '#new_message', function(event, newMessage){
      self.controller.showCreatedMessageEvent(newMessage);
    });
  }
};

$(document).ready(function() {
  Bookmeetups.view = new Bookmeetups.View();
  Bookmeetups.controller = new Bookmeetups.Controller(Bookmeetups.view);
  new Bookmeetups.Binder(Bookmeetups.controller).bind();
});