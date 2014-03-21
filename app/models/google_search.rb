class GoogleSearch
  def self.search(terms, opts)
    books = GoogleBooks.search( terms, opts )
  end

  def self.search_and_add(terms, opts)
    results = []
    books = self.search(terms, opts)
    books.each do |book|
      newbook = Book.new
      newbook.title = book.title
      newbook.google_id = book.id
      newbook.author = book.authors
      newbook.isbn = book.isbn
      results << newbook if newbook.save
    end
    results
  end

end