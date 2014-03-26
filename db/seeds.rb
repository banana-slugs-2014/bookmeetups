titles = ["Shades of Grey", "Rant", "Jane Eyre", "American Gods", "Reaper Man", "Harry Potter and the Sorcerer's Stone", "The Bourne Identity: Jason Bourne", "The Strategy of Indirect Approach", "Don Quixote", "Ulysses", "War and Peace", "The Count of Monte Cristo", "To the Lighthouse", "The Grapes of Wrath", "The Iliad", "Halo: First Strike", "Assassin's Apprentice: The Farseer Trilogy", "Catch-22", "Band of Brothers: E Company, 506th Regiment, 101st Airborne from Normandy to Hitler's Eagle's Nest",
 "Pride and Prejudice", "Practical Object-Oriented Design in Ruby: An Agile Primer", "Design Patterns in Ruby", "As I Lay Dying", "The Fellowship of the Ring: Being the First Part of The Lord of the Rings",
  "The Hobbit", "The Divine Comedy", "All the King's Men", "The Call of the Wild", "Animal Farm", "Oedipus Rex", "The Hunger Games", "Dune", "Ender's Game", "To Kill a Mockingbird", "The Complete Chronicles of Narnia",
  "Memoirs of a Geisha", "Crime and Punishment", "The Alchemist"]
authors = ["Jasper Fforde", "Chuck Palahniuk", "Charlotte Bronte", "Neil Gaiman", "Terry Prachett", "J.K. Rowling", "Robert Ludlum", "B. H. Liddell Hart", "Miguel de Cervantes Saavedra", "James Joyce", "Leo Tolstoy" "Alexandre Dumas", "Virginia Woolf", "John Steinbeck", "Homer", "Eric Nylund", "Robin Hobb", "Joseph Heller", "Stephen E. Ambrose", "Jane Austen",
 "Sandi Metz", "Russ Olsen", "William Faulkner", "J.R.R. Tolkien", "J.R.R. Tolkien", "Dante Alighieri", "Robert Penn Warren", "Jack London", "George Orwell", "Sophocles", "Suzanne Collins", "Frank Herbert", "Orson Scott Card",
  "Harper Lee", "C. S. Lewis", "Arthur Golden", "Fyodor Dostoyevsky", "Paulo Coelho"]
google_id = %w( G2ULLW2R17IC i6kj0xH2H0QC Xqon3jNYhCIC zupOHdkcSvkC RXT-iRt5s9MC MovumAEACAAJ BebwoOZCPr0C qK43pwAACAAJ sI_UG8lLey0C -buuyh7pn_oC ZxN1qLTKPFwC Y6-cfv2vpAUC cncrrS9r2UcC l2mQQIN0KSQC OUbJC89bB2YC DmdFf5PnB4wC qdqsVz0Ky0IC Fy5WM44QHl0C jlFL20cX9HIC XkYJFbKMb0sC rk9sAQAAQBAJ QWOWqHANWoAC _-fRfuHupfAC aWZzLPhY4o0C pD6arNyKyi8C
2VY81Y0RIfMC mrfHr5H-0ysC 3abZ5NBhyqwC nkalO3OsoeMC -zSsekSKiT0C Yz8Fnw0PlEQC B1hSG45JCX4C Ojqi8KbWuLwC 78VrOOWSQ6UC f_0m7WiulUMC SOM54qQ6BgkC 0HZrq-4zA5QC FEL8DlqjYEkC )
isbn13 = [9781101159651, 9780307371966, 9780061792663, 9780061807053, 9780545582889, 9780307813787, 9781245060615, 9780142437230, 9781909676480, 9781935814863, 9781555763596, 9781909175488, 9781440637124, 9780374529055, 9780765367310, 9780553897487, 9781451632965, 9780743464116, 9781416503040, 9780321721334, 9780132702508, 9780307792167,
   9780547952017, 9780547951973, 9780871407214, 9780156004800, 9781604504385, 9780547370224, 9780299282530, 9780545229937, 9780441013593, 9781429963930, 9780061980268, 9780060281373, 9780375406782, 9781605205106, 9780061741241]

titles.each_with_index do |title, index|
   book = Book.new
   book.title = title
   book.author = authors[index]
   book.isbn = isbn13[index]
   book.google_id = google_id[index]
   book.save
end

l = Location.new
l.city = "San Francisco"
l.state = "CA"
l.zip = "94103"
l.latitude = 37.7726402
l.longitude = -122.4099154
l.save

new_l = Location.new
new_l.city = "San Francisco"
new_l.state = "CA"
new_l.zip = "94171"
new_l.latitude = 37.78
new_l.longitude = -122.42
new_l.save

far_l = Location.new
far_l.city = "La Canada"
far_l.state = "CA"
far_l.zip = "91011"
far_l.latitude = 34.2068182
far_l.longitude = -118.2000277
far_l.save

names = [ "Abe Lincoln", "Tom", "Afro Samurai", "Alien", "Animal", "Glen", "Audrey Hepburn", "A legit sorcerer", "Bart Simpson", "sam", "Batman", "Friendly Bear" ]

names.each do |name|
  u = User.new
  u.username = name
  u.password = "123"
  u.email = name + "@test.com"
  u.location = l
  u.save
  u.books << ( Book.all ).sample(30)
end
names = [ "Bob", "Bender", "Betty Boop", "Bob Marley", "Boba Fett", "Buddha",  "Che", "Chef", "Clint Eastwood", "Cloud Strife", "Sam", "James" ]

names.each do |name|
  u = User.new
  u.username = name
  u.password = "123"
  u.email = name + "@test.com"
  u.location = [new_l, far_l].sample
  u.save
  u.books << ( Book.all ).sample(rand(25-30))
end

names = [ "Dalek Dan", "Shebob", "Deadpool", "Stan", "Dilbert", "Doc Brown", "Einstein", "Charles" ]

names.each do |name|
  u = User.new
  u.username = name
  u.password = "123"
  u.email = name + "@test.com"
  u.location = [new_l, far_l].sample
  u.save
  u.books << ( Book.all ).sample(rand(15-30))
end