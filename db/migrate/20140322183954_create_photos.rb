class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :name,       :null => false
      t.binary :data,       :null => false
      t.string :filename
      t.string :mime_type
      t.belongs_to :user
      t.timestamps
    end
  end
end
