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

Bookmeetups.View = function(selectors){
  this.selectors = selectors;
};

Bookmeetups.View.prototype = {
  renderNewMessageForm: function(form){
    this.displayNewMessageForm(form);
    this.hideCreateMessageLink();
  },

  renderNewMessage: function(newMessage){
    this.prependNewMessage(newMessage);
    this.removeNewMessageForm();
    this.showCreateMessageLink();
  },

  displayNewMessageForm: function(form){
    $(this.selectors.messagesContainer).prepend(form);
  },

  hideCreateMessageLink: function(){
    $(this.selectors.openMessageLink).hide();
  },

  prependNewMessage: function(newMessage){
    $(this.selectors.messagesContainer).prepend(newMessage);
  },

  removeNewMessageForm: function(){
    $(this.selectors.newMessageForm).remove();
  },

  showCreateMessageLink: function(){
    $(this.selectors.openMessageLink).show();
  }
};

Bookmeetups.Binder = function(controller, eventSelectors){
  this.controller = controller;
  this.eventSelectors = eventSelectors;
};

Bookmeetups.Binder.prototype = {
  bind: function(){
    this.createMessageForm();
    this.showCreatedMessage();
  },

  createMessageForm: function(){
    var self = this;
    $('body').on("ajax:success", self.eventSelectors.openMessageFormSelector, function(event,dataForm){
      self.controller.showNewMessage(dataForm);
    });
  },

  showCreatedMessage: function(){
    var self = this;
    $('body').on("ajax:success", self.eventSelectors.newMessageFormSelector, function(event, newMessage){
      self.controller.showCreatedMessageEvent(newMessage);
    });
  }
};

$(document).ready(function() {
  var eventSelectors = {
    openMessageFormSelector: '.open-new-message',
    newMessageFormSelector: '#new_message'
  };

  var viewSelectors = {
    messagesContainer: '.messages',
    openMessageLink:   '.open-new-message',
    newMessageForm:    '#new_message'
  };

  Bookmeetups.view = new Bookmeetups.View(viewSelectors);
  Bookmeetups.controller = new Bookmeetups.Controller(Bookmeetups.view);
  new Bookmeetups.Binder(Bookmeetups.controller, eventSelectors).bind();
});