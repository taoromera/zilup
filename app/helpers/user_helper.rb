module UserHelper

  def show_difficulty(difficulty)
    html = ''
    case difficulty
      when 0 
        html << '<span class="star star_0"></span>'
      when 1 
        html << '<span class="star star_1"></span>'
      when 2 
        html << '<span class="star star_2"></span>'
      when 3 
        html << '<span class="star star_3"></span>'
      else
        html << '<span class="star star_0"></span>'
      end
      
      return html.html_safe
  end
  
  def show_rank(game)
    
    # If user has still not downloaded this game, show the download button instead of the ranking
    if @other_games.include? game
      return ''
    end
    
    rank = current_user.game_scores.where('game_id = (?)', game[:id]).first[:ranking]
    html = ''
    case rank
      when 1 
        html << '<div class="ribon black">#1</div>'
      when 2
        html << '<div class="ribon">#2</div>'
      when 3
        html << '<div class="ribon">#3</div>'
      else
        html << '<div class="l"><i>#</i><span>' + rank.to_s + '</span></div>'
      end
      
      return html.html_safe
  end
  
  def show_score(game)
    # If user has still not downloaded this game, show the download button instead of the ranking
    if @other_games.include? game
      return ''
    end
    
    score = current_user.game_scores.where('game_id = (?)', game[:id]).first[:max_score]
    html = '<div class="l"><i>pts</i><span>' + score.to_s + '</span></div>'
    return html.html_safe
  end
  
  def friends_playing_game(game)
    # Get friends ids
    friends_id = @current_user.friends

    # Find how many among my friends are playing this game
    nr_friends = GameScore.where("user_id IN (?) AND game_id = ?", friends_id, game[:id]).count
  
    return nr_friends.to_s
  end
  

  
end
