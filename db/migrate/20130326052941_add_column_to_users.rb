class AddColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :ranking_since, :timestamp
  end
end
