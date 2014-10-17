class UsersController < ApplicationController
  before_action :require_login, only: [:new, :edit, :change_password]
  before_action :require_admin, only: [:new]
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

  def change_password
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(user_params)
    redirect_to root_path
  end

  def destroy
    User.find(params[:id]).remove

    redirect_to root_path
  end

  private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :old_password, :role_id)
    end
end