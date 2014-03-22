require 'spec_helper'

describe "Books", :js => false do
  let!(:my_user) { create(:user) }
  let!(:my_book) { create(:book) }
  let!(:book2) { create(:book) }
  let!(:books) { [my_book, book2] }


  it "a user can view a book's profile" do
    before (:each) do
      session[:id] = my_user.id
    end
    visit book_path(my_book)
    expect(page).to have_content my_book.title
    expect(page).to have_content my_book.author
  end

  it "a user can view all books in the database" do
    visit books_path
    books.each do |book|
      expect(page).to have_content book.title
    end
  end
end



