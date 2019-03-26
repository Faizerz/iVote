class FollowersController < ApplicationController
  def index

  end
  def create
    Follower.create(followed_id: params[:followed_id].to_i, follower_id: params[:user_id].to_i)
  end
end
