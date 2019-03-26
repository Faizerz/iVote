class User < ApplicationRecord

  has_many :votes
  has_many :polls, through: :votes
  has_many :polls

  has_secure_password

  validates :username, presence: true, uniqueness: true

  def followers
    Follower.where("followed_id = #{id}")
  end

  def following
    Follower.where("follower_id = #{id}")
  end
end
