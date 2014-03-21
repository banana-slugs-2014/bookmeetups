titles = ["Shades of Grey", "Rant", "Jane Eyre", "American Gods", "Reaper Man", "Harry Potter and the Sorcerer's Stone", "The Bourne Identity: Jason Bourne", "The Strategy of Indirect Approach"]
authors = ["Jasper Fforde", "Chuck Palahniuk", "Charlotte Bronte", "Neil Gaiman", "Terry Prachett", "J.K. Rowling", "Robert Ludlum", "B. H. Liddell Hart"]
google_id = ["G2ULLW2R17IC", "i6kj0xH2H0QC", "Xqon3jNYhCIC", "zupOHdkcSvkC", "RXT-iRt5s9MC", "MovumAEACAAJ", "BebwoOZCPr0C", "qK43pwAACAAJ"]
isbn13 = [9781101159651, 9780307371966, 9780061792663, 9780061807053, 9780545582889, 9780307813787, 9781245060615]

titles.each_with_index do |title, index|
   book = Book.new
   book.title = title
   book.author = authors[index]
   book.isbn = isbn13[index]
   book.google_id = google_id[index]
end