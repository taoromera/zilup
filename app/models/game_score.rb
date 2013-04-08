class GameScore < ActiveRecord::Base
  belongs_to :user
  attr_accessible :game_id, :max_score, :ranking
end
