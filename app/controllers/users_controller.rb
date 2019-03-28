class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update]
  before_action :authentication_required, except: [:new, :create]

  def index
    @users = User.all
  end

  def leaderboard
    @users = User.all
    @user = User.find(current_user.id)
  end

  def upgrade
    @user = User.find(current_user.id)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      session[:user_id] = @user.id
      redirect_to @user
    else
      flash[:user_error] = @user.errors.full_messages
      redirect_to new_user_path
    end
  end

  def edit

  end

  def update
    @user = User.find(params[:id])
    if @user.valid?
      @user.update(user_params)
      redirect_to @user
      flash[:update_success] = 'Profile successfully updated!'
    else
      flash[:user_error] = @user.errors.full_messages
      render :edit
    end
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :user_type, :password, :email)
  end
end
