class CreateGameScores < ActiveRecord::Migration
  def change
    create_table :game_scores do |t|
      t.integer :game_id
      t.integer :max_score
      t.integer :ranking
      t.references :user

      t.timestamps
    end
    add_index :game_scores, :user_id
  end
end
