class AddOverallScoreColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :overall_score, :integer
  end
end
