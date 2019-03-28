class PollsController < ApplicationController
  def index
    if params[:filter]
      @filter = params[:filter]
      array = []
    else
      @polls = Poll.all.reverse
    end

    if @filter == 'all'
      @polls = Poll.all.reverse
    elsif @filter == 'follow'
      user_ids = Follower.where(follower_id: current_user.id).map{|f| f.followed_id}
      user_ids.each do |id|
        Poll.where(user_id: id).each do |p|
          array << p
        end
      end
      @polls = array.reverse
    elsif @filter == 'polls'
      Poll.all.each do |p|
        p.votes.map{|v| v.user_id}.exclude?(current_user.id)? array << p : nil
      end
      @polls = array.reverse
    elsif @filter == 'answers'
      ids = current_user.votes.map{|p| p.poll_id}
      ids.each do |id|
        array << Poll.find(id)
      end
      @polls = array.reverse
    end
  end

  def show
    @poll = Poll.find(params[:id])
  end

  def new
    @poll = Poll.new
  end

  def create
    @poll = Poll.create(poll_params)
    creating_user = User.find(session[:user_id])
    current_score = creating_user.score
    if creating_user.user_type == 'free'
      creating_user.update(score: (current_score - 10))
    end
    redirect_to @poll
  end

  def filter

  end

  private

  def poll_params
    params.require(:poll).permit(:user_id, :question, :answer_one, :answer_two)
  end
end
