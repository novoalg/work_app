# == Schema Information
#
# Table name: users
#
#  id             :integer          not null, primary key
#  username       :string(255)
#  email          :string(255)
#  remember_token :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  admin          :boolean
#  karma          :integer          default(0)
#  link_karma     :integer          default(0)
#

class User < ActiveRecord::Base
  attr_accessible :email, :username, :karma, :link_karma, :password, :password_confirmation
  validates :username, :uniqueness => true, :presence => true, :length => { :minimum => 3, :maximum => 30 }
  has_many :subreddits, :dependent => :destroy
  has_many :votes
  has_many :replies
  has_many :comments
  #has_many :post
  has_many :subscriptions
  belongs_to :post
  belongs_to :vote
  belongs_to :reply
  belongs_to :subscription
  #before_save { |user| user.email = email.downcase }
  #before_save :create_remember_token
  #VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  #validates :email, :uniqueness => true, :presence => true, :format => { :with => VALID_EMAIL_REGEX }
  extend FriendlyId
  friendly_id :username
  def to_param
    "#{username}".parameterize
  end

  
  def has_voted?(post)
        self.votes.where("post_id = ?", post.id).any? 
  end
 
  def has_comment_voted?(comment)
        self.votes.where("comment_id = ?", comment.id).any? 
  end

  def has_reply_voted?(reply)
        self.votes.where("reply_id = ?", reply.id).any?
  end

  def has_subbed?(subreddit)
        self.subscriptions.where("subreddit_id = ?", subreddit.id).any?
  end


  private 

   def create_remember_token
     self.remember_token = SecureRandom.base64.tr("+/", "-_")
   end
end
