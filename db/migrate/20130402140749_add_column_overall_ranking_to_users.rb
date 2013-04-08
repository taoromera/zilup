class AddColumnOverallRankingToUsers < ActiveRecord::Migration
  def change
    add_column :users, :overall_ranking, :integer
  end
end
