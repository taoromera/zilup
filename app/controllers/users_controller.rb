class UsersController < ApplicationController

  def login
    @user = User.new
  end
  
  def players_info
  
    @current_user = User.find(session[:user_id])
    @first_user = User.order("overall_score DESC").first
    @second_user = User.order("overall_score DESC").limit(2)[1]
    @third_user = User.order("overall_score DESC").limit(3)[2]
  end
  
  def my_page
    @current_user = User.find(session[:user_id])

    # Check what button has been pressed: games, friends or king
    @view = params[:view]
    
    # Get the user's games ordered by ranking
    @user_games_id = @current_user.game_scores.order(:ranking).pluck(:game_id)
    
    # A user games array is never empty, because he must sign up from within one of our games, so there is at least 1 game
    my_games_unordered = Game.find(@user_games_id).group_by(&:id)
    @my_games = @user_games_id.map { |i| my_games_unordered[i].first }
    
    @other_games = Game.where('id NOT IN (?)', (@user_games_id.blank? ? '' : @user_games_id)).all
    @all_games = @my_games + @other_games
    
    # 4 games in each row in the view
    @rows = (@all_games.count / 4).to_i + 1
    
    # Only until we have the script that loads players as you scroll down!!
    @my_friends = User.find(@current_user.friends.pluck(:friend_id), :limit => 96)

    # 4 players in each row in the view
    @rows_friends = (@my_friends.count / 4).to_i + 1   
  end
  
    
  def games_info
    @current_user = User.find(session[:user_id])
    
    # Get the user's games ordered by ranking
    @user_games_id = @current_user.game_scores.order(:ranking).pluck(:game_id)
    
    # A user games array is never empty, because he must sign up from within one of our games, so there is at least 1 game
    my_games_unordered = Game.find(@user_games_id).group_by(&:id)
    @my_games = @user_games_id.map { |i| my_games_unordered[i].first }
    
    @other_games = Game.where('id NOT IN (?)', (@user_games_id.blank? ? '' : @user_games_id)).all
    @all_games = @my_games + @other_games
    
    # 4 games in each row in the view
    @rows = (@all_games.count / 4).to_i + 1

  end
  
  def get_user_info
    begin 
      current_user = User.find(session[:user_id])
    # Something went wrong. Return an empty response and an error code
    rescue => e
      render :json => {:username => [],
                       :profile_photo => [], 
                       :wishlist_nr => [], 
                       :notification_nr => [], 
                       :overall_ranking => [], 
                       :overall_score => [], 
                       :points_to_rank_up => [], 
                       :country => [], 
                       :status => 0,
                       :error_msg => e.record.errors.full_messages
                       }
    end
    
    wishlist_nr = current_user[:wishlist].split(',').count
    notification_nr = current_user.notifications.count
    points_to_rank_up = current_user.pts_to_next_ranking(current_user)

    render :json => {:username => current_user[:username], 
                     :profile_photo => current_user[:profile_photo], 
                     :wishlist_nr => wishlist_nr, 
                     :notification_nr => notification_nr, 
                     :overall_ranking => current_user[:overall_ranking], 
                     :overall_score => current_user[:overall_score], 
                     :points_to_rank_up => points_to_rank_up, 
                     :country => current_user[:country], 
                     :status => 1,
                     :error_msg => ''
                     }
  end
  
end
