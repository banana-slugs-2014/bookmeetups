=begin comment

This is a badly named model / table.  What, in the name of tarnation, is a UserBook?  A book the User wrote?

Why not a BookCollection (belongs to a user, belongs to a book)
or a Favorite (belongs to a user, belongs to a book)

Famously "naming things" is one of the hard probelsm in computer science.  I mean, we as human
society know it's really hard.  In the Torah it's the first thing that The Creator has man do.
It's essential to the human experience.  I'm not even playing.  Picking good names will save
you and your peers much pain.

Calling it UserBook makes me think you went to the ActiveRecord association
Rails guide and read the section on has_and_belongs_to_many but then
incorrectly applied it where has_many :through is more fitting.

=end

 class UserBook < ActiveRecord::Base
  belongs_to :user
  belongs_to :book

  #Might want to change this.  Sometimes subtle jokes like this slip past into
  #the final project.
  #
  validates_uniqueness_of :user_id, :scope => :book_id, :msg => "No dupes yo"
end
