class AddColumnsMailAndLanguageToUser < ActiveRecord::Migration
  def change
    add_column :users, :mail, :string
    add_column :users, :language, :string
  end
end
