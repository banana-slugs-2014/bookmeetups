require 'spec_helper'

describe "Books", :js => false do
  let!(:my_user) { create(:user) }
  let!(:my_book) { create(:book) }
  let!(:book2) { create(:book) }
  let!(:books) { [my_book, book2] }


  xit "a user can view a book's profile" do
    visit root_path
    fill_in('Username', :with => "test")
    fill_in('Password', :with => "123")
    click_on('Log In')
    visit book_path(my_book)
    expect(page).to have_content my_book.title
    expect(page).to have_content my_book.author
  end

  xit "a user can view all books in the database" do
    visit books_path
    books.each do |book|
      expect(page).to have_content book.title
    end
  end
end



