class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.integer :friend_id
      t.references :user

      t.timestamps
    end
    add_index :friends, :user_id
  end
end
