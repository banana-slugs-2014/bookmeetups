class BooksController < ApplicationController
  before_filter :redirect_unless_logged_in  # Good

  def index
    @books = Book.all
    render "index", layout: true
  end

  def show
    @book = Book.find(params[:id])
    # Why do this?  #include? returns true or false on its own
    # Further the name sucks.  @button is a result of
    # current_user.books.include?  No, it's not.
    #
    # @show_button might be a good thing to call it or
    #_@is_eligible_to_see_button
    @button = ((current_user.books.include? @book) ? true : false)


    # These two calculations should be extracted to a class
    #
    # Imagine a NearbyFriendsFinder.new(current_user, @book).friends
    #
    # call.
    @nearby_friends = current_user.friends(@book)

    # similarly, a DistantFriendsFinder?  That's good OO, my friends.
    @distant_friends = @book.users - [current_user] - @nearby_friends
    render "show", layout: true
  end

  def create
  end

end
