class CreateUserBooks < ActiveRecord::Migration
  def change
    create_table :user_books do |t|
      t.belongs_to :user
      t.belongs_to :book
    end
  end

end
