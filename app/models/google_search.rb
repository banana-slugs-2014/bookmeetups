class GoogleSearch
  def search(term, opts)
    books = GoogleBooks.search( term, opts )
  end

  def search_and_add(term, opts)
    results = []
    books = search(terms, {:count => 5})
    books.each do |book|
      newbook = Book.new
      newbook.title = book.title
      newbook.google_id = book.id
      newbook.author = book.author
      newbook.isbn = book.isbn
      newbook.save
      results << newbook
    end
    results
  end

end