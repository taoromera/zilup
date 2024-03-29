class User < ActiveRecord::Base
  attr_accessible :hashed_password, :username, :password, :profile_photo, :wishlist, :android_or_iphone, :country, :mail, :language, :overall_score, :overall_ranking, :ranking_since
  attr_accessor :password
  
  has_many :notifications, :foreign_key => 'user_id'
  has_many :game_scores, :foreign_key => 'user_id'
  has_many :friends, :foreign_key => 'user_id'
  
  validates_presence_of :password
  validates :password, :length => { :in => 6..20 }
  validates_presence_of :username
  
  # Return the user record if the password is correct and nil if it isn't.
  def self.authenticate(username, password)
    # Because we use bcrypt we can't do this query in one part, first
    # we need to fetch the potential user
    user = find_by_username(username)
    # Then compare the provided password against the hashed one in the db.
    if user && (BCrypt::Password.new(user.hashed_password).is_password? password)
      # If they match we return the user 
      return user
    else
      # If we get here it means either there's no user with that username, or the wrong
      # password was provided. But we don't want to let an attacker know which. 
      return nil
    end
  end
  
  # Create a new user account
  def self.new_account(params)
    user = User.create(:username => params[:username], 
                       :hashed_password => BCrypt::Password.create(params[:password]), 
                       :mail => params[:mail], 
                       :country => params[:region], 
                       :language => params[:language],
                       :overall_score => 0,
                       :overall_ranking => (User.last.nil? ? 0 : User.last[:id]) + 1,
                       :ranking_since => Time.now(),
                       :android_or_iphone => 0,
                       :password => params[:password]
                       )
      user.save!
  end
  
    
  def ranking_since_time(time)
    elapsed_time = (Time.now.utc - time.utc.to_time).to_i
    
    # <1 min
    if (elapsed_time/60).to_i == 0
      str = elapsed_time.to_i.to_s + ' s'
    # 1 min < time < 1 hour
    elsif (elapsed_time/3600).to_i == 0
      str = (elapsed_time/60).to_i.to_s + ' m'
    # 1 hour < time < 1 day
    elsif (elapsed_time/3600/24).to_i == 0
      hours = (elapsed_time/3600).to_i
      minutes = ((elapsed_time-hours*3600)/60).to_i
      str = hours.to_s + ' h ' + minutes.to_s + ' m'
    # 1 day < time < 1 year
    elsif (elapsed_time/3600/24/365).to_i == 0
      days = (elapsed_time/3600/24).to_i
      minutes = ((elapsed_time-days*3600*24)/3600).to_i    
      str = days.to_s + ' d ' + minutes.to_s + ' h'
    # > 1 year
    else
      years = (elapsed_time/3600/24/365).to_i
      days =  ((elapsed_time-years*3600*24*365)/3600/24).to_i
      str =  years.to_s + ' y ' + days.to_s + ' d'
    end
    
    return str
  end
  
  def pts_to_next_ranking(current_user)
    # If user is already #1, return 0
    if current_user.overall_ranking == 1
      return '0'
    end

    # How many points to I need to go up one position in the ranking?
    pts = User.where(:overall_ranking => current_user.overall_ranking - 1).first[:overall_score] - current_user.overall_score
  end

  private
  
end
