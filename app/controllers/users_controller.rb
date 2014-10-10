class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Welcome to the site!"
      redirect_to root_path
    else
      flash[:alert] = "There was a problem creating your account. Please try again."
      redirect_to :back
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def destroy
    User.find(params[:id]).remove

    redirect_to root_path
  end

  private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end