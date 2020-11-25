class SessionsController < ApplicationController
  def new 
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id 
      flash[:notice] = "Welcome back, #{user.name}"
      redirect_to session[:intended_route] || events_path
      session[:intended_route] = nil
    else
      flash.now[:alert] = 'Invalid user/password combination!'
      render :new
    end
  end

  def destroy 
    session[:user_id] = nil
    flash[:notice] = 'Signed out successfuly!'
    redirect_to signin_path
  end
  
end