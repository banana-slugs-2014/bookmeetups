 class UserBook < ActiveRecord::Base
  belongs_to :user
  belongs_to :book

  #Might want to change this.  Sometimes subtle jokes like this slip past into
  #the final project.
  #
  validates_uniqueness_of :user_id, :scope => :book_id, :msg => "No dupes yo"
end
