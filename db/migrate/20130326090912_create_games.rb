class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :title
      t.integer :players
      t.text :description
      t.string :category
      t.integer :difficulty

      t.timestamps
    end
  end
end
