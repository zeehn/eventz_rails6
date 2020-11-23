class UsersController < ApplicationController
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
      redirect_to @user 
    else
      render :new 
    end
  end

  def edit 
    @user = User.find(params[:id])
  end 
  
  def update 
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = 'Account updated successfully!'
      redirect_to @user 
    else
      render :edit 
    end
  end

  def destroy 
    @user = User.find(params[:id])
    @user.destroy
    flash[:alert] = 'Account deleted successfully!'
    redirect_to events_url
  end
  
  private 
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end