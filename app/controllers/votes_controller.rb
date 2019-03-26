class VotesController < ApplicationController
  def create
    voting_user = User.find_by(username: current_user.username)
    @vote = Vote.create(user_id: voting_user.id, poll_id: params[:poll_id].to_i, vote: params[:button])

    voted_on_poll_id = params[:poll_id].to_i
    poll_user_id = Poll.find(voted_on_poll_id).user_id
    poll_creator = User.find_by(id: poll_user_id)

    voter_current_score = voting_user.score
    creator_current_score = poll_creator.score

    voting_user.update(score: (voter_current_score + 2))
    poll_creator.update(score: (creator_current_score + 1))

    redirect_to polls_path
  end
end
