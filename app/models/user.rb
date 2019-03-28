class User < ApplicationRecord

  has_many :votes
  has_many :polls, through: :votes
  has_many :polls
  belongs_to :profile_picture

  has_secure_password

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true
  validates :email, presence: true, uniqueness: true


  def followers
    Follower.where("followed_id = #{id}")
  end

  def following
    Follower.where("follower_id = #{id}")
  end

  def self.search(search)
    if search
      found = User.where(username: search)
      if found.empty?
        User.all
      end
    else
      User.all
    end
  end
end
