require 'spec_helper'

describe "Books", :js => false do
  let!(:book) { FactoryGirl.create :book }

  it "shows a book's author and title" do
    visit book_path(book)
    expect(page).to have_content book.title
    expect(page).to have_content book.author
  end
end


