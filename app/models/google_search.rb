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
      if newbook.save
        results << newbook
      else
        found = Book.find_by_google_id(book.id)
        results << found if found
      end
    end
    results
  end

end