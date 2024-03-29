class SessionsController < ApplicationController

  def new
    render :layout => false
  end

  # Log in from the PC
  def create
    user = User.authenticate(params[:username], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to players_path
    else
      @error_msg = "Invalid username or password"
      render "new", :layout => false
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end
  
  # Log in from the iPhone
  def log_in
    user = User.authenticate(params[:username], params[:password])
    if user
      session[:user_id] = user.id
      status = 1
      error_msg = ''
    else
      status = 1
      error_msg = 'Invalid username or password'
    end
    
    render :json => {:status => status, :error_msg => error_msg}
  end
  
  def sign_up
    user = User.where(:username => params[:username])
    
    # If username is taken, raise an error
    if !user.empty?
      render :json => {:status => 0, :error_msg => 'Username is taken. Please, choose another one.'}
    end
    
    # If username is available, try to create the account with the provided parameters
    begin 
      User.new_account(params)
      status = 1
      error_msg = ''
    rescue => e
      status = 0
      error_msg = e.record.errors.full_messages
    end  
        
    render :json => {:status => status, :error_msg => error_msg}
  end
  

end
