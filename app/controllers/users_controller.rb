class UsersController < ApplicationController
  before_action :require_signin, except: [:new, :create]
  before_action :require_correct_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new 
    @user = User.new 
  end

  def create 
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Thanks for signing up!"
      session[:user_id] = @user.id 
      redirect_to @user 
    else
      render :new 
    end
  end

  def edit 
  end 
  
  def update 
    if @user.update(user_params)
      flash[:notice] = 'Account updated successfully!'
      redirect_to @user 
    else
      render :edit 
    end
  end

  def destroy 
    @user.destroy
    session[:user_id] = nil
    flash[:alert] = 'Account deleted successfully!'
    redirect_to events_url
  end
  
  private 
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def require_correct_user
    @user = User.find(params[:id])
    redirect_to events_url if !current_user?(@user)  
  end
end