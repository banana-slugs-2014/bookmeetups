var Bookmeetups = Bookmeetups || {};

//BEGIN CONTROLLER//
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
//END CONTROLLER//

//BEGIN VIEW//
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
//END VIEW//

//BEGIN BINDER//
Bookmeetups.Binder = function(controller, eventSelectors, animator){
  this.controller = controller;
  this.eventSelectors = eventSelectors;
  this.animator = animator;
};

Bookmeetups.Binder.prototype = {
  bind: function(){
    this.createMessageForm();
    this.showCreatedMessage();
    this.cancelMessageCreation();
    this.animateBookMouseEnter();
    this.animateBookMouseLeave();
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
  },

  animateBookMouseEnter: function(){
    var self = this;
    $('body').on('mouseenter', '.book-display', function(e){
      event.preventDefault();
      self.animator.mouseEnterAnimation(e);
    });
  },

  animateBookMouseLeave: function(){
    var self = this;
    $('body').on('mouseleave', '.book-display', function(e){
      event.preventDefault();
      self.animator.mouseLeaveAnimation(e);
    });
  }
};
//END BINDER//


//START ANIMATOR//
Bookmeetups.Animator = function(selectors){
  this.selectors = selectors;
};

Bookmeetups.Animator.prototype = {
  landingSplashAnimation: function(){
    var self = this;
    $(this.selectors.splashWords).fadeIn(1500, function(){
      $(self.selectors.buttons).fadeIn(1000);
    });
  },

  mouseEnterAnimation: function(event){
    this.fadeInBookTitle(event);
    this.reduceBookCoverOpacity(event);
    this.displayMeetupsLink(event);
  },

  mouseLeaveAnimation: function(event){
    this.fadeOutBookTitle(event);
    this.increaseBookCoverOpacity(event);
    this.removeMeetupsLink(event);
  },

  fadeInBookTitle: function(book){
    $(book.target).parents(this.selectors.bookContainer).find(this.selectors.titleText).fadeIn(200);
  },

  reduceBookCoverOpacity: function(book){
    $(book.target).parents(this.selectors.bookContainer).find(this.selectors.coverImage).css('opacity', '.1');
  },

  displayMeetupsLink: function(book){
    $(book.target).parents(this.selectors.bookContainer).find(this.selectors.meetupLink).css('opacity', '1');
  },

  fadeOutBookTitle: function(book){
    $(book.target).parents(this.selectors.bookContainer).find(this.selectors.titleText).fadeOut(200);
  },

  increaseBookCoverOpacity: function(book){
    $(book.target).parents(this.selectors.bookContainer).find(this.selectors.coverImage).css('opacity', '1');
  },

  removeMeetupsLink: function(book){
    $(book.target).parents(this.selectors.bookContainer).find(this.selectors.meetupLink).css('opacity', '0');
  }
};
//END ANIMATOR//

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
    splashWords:   '.landing h1',
    buttons:       '.hero-btn',
    bookContainer: '.book-display',
    titleText:     '.title',
    meetupLink:    '.meetup',
    coverImage:    '.cover'
  };

  Bookmeetups.view = new Bookmeetups.View(viewSelectors);
  Bookmeetups.controller = new Bookmeetups.Controller(Bookmeetups.view);
  Bookmeetups.animator = new Bookmeetups.Animator(animatorSelectors);
  new Bookmeetups.Binder(Bookmeetups.controller, eventSelectors, Bookmeetups.animator).bind();
  new Bookmeetups.Animator(animatorSelectors).landingSplashAnimation();
});