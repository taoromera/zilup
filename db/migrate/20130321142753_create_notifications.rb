class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :from
      t.timestamp :sent_date
      t.text :mssg_content
      t.references :user
      t.timestamps
    end
    add_index :notifications, :user_id
  end
end
