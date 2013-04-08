class Game < ActiveRecord::Base
  attr_accessible :category, :description, :difficulty, :players, :title
end
