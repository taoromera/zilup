class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :hashed_password
      t.text :profile_photo
      t.string :wishlist
      t.boolean :android_or_iphone
      t.string :country

      t.timestamps
    end
  end
end
