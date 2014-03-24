class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.boolean :unread, :default => true
      t.text :text
      t.belongs_to :meetup
      t.timestamps
    end
  end
end
