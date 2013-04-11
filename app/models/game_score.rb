class GameScore < ActiveRecord::Base
  belongs_to :user
  attr_accessible :game_id, :ranking, :user_id, :best_score_1, :best_score_2, :best_score_3
end
