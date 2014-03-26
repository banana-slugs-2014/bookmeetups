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
  },

  hideNewMessage: function(){
    this.view.removeNewMessageForm();
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

  removeNewMessageForm: function(){
    this.hideNewMessageForm();
    this.removeCancelButton();
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

  hideNewMessageForm: function(){
    $(this.selectors.newMessageForm).hide();
  },

  showCreateMessageLink: function(){
    $(this.selectors.openMessageLink).show();
  },

  removeCancelButton: function(){
    $(this.selectors.cancelNewMessageButton).hide();
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
    this.cancelMessageCreation();
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
  },

  cancelMessageCreation: function(){
    var self = this;
    $('body').on('click', self.eventSelectors.cancelNewMessageSelector, function(event){
      event.preventDefault();
      self.controller.hideNewMessage();
    });
  }
};

Bookmeetups.Animator = function(selectors){
  this.selectors = selectors;
};

Bookmeetups.Animator.prototype = {
  landingSplash: function(){
    var self = this;
    $(this.selectors.splashWords).fadeIn(1500, function(){
      $(self.selectors.buttons).fadeIn(1000);
    });
  }
};

$(document).ready(function() {
  var eventSelectors = {
    openMessageFormSelector: '.open-new-message',
    newMessageFormSelector: '#new_message',
    cancelNewMessageSelector: '.cancel'
  };

  var viewSelectors = {
    messagesContainer: '.messages',
    openMessageLink:   '.open-new-message',
    newMessageForm:    '#new_message',
    cancelNewMessageButton: '.cancel'
  };

  var animatorSelectors = {
    splashWords: '.landing h1',
    buttons:     '.hero-btn'
  };

  Bookmeetups.view = new Bookmeetups.View(viewSelectors);
  Bookmeetups.controller = new Bookmeetups.Controller(Bookmeetups.view);
  new Bookmeetups.Binder(Bookmeetups.controller, eventSelectors).bind();
  new Bookmeetups.Animator(animatorSelectors).landingSplash();

  $('body').on('mouseenter', '.book-display', function(e){
    $(e.target).parents('.book-display').find('.title').fadeIn(200);
    $(e.target).parents('.book-display').find('.cover').css('opacity', '.1');
    $(e.target).parents('.book-display').find('.meetup').css('opacity', '1');
  });

  $('body').on('mouseleave', '.book-display', function(e){
    $(e.target).parents('.book-display').find('.title').fadeOut(200);
    $(e.target).parents('.book-display').find('.cover').css('opacity', '1');
    $(e.target).parents('.book-display').find('.meetup').css('opacity', '0');
  });



});