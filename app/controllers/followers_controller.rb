class FollowersController < ApplicationController
  def index; end

  def create
    if params[:todo] == 'follow'
      Follower.create(followed_id: params[:button].to_i, follower_id: current_user.id)
    elsif params[:todo] == 'unfollow'
      Follower.find_by(followed_id: params[:button].to_i, follower_id: current_user.id).destroy()
    end
    redirect_to users_path
  end
end
