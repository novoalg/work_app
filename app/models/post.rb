# == Schema Information
#
# Table name: posts
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :string(255)
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  url         :string(255)
#  subname     :string(255)
#  karma       :integer
#

class Post < ActiveRecord::Base
  attr_accessible :description, :subname, :title, :user_id, :url, :karma, :is_link
  belongs_to :user
  belongs_to :subreddit
  default_scope :order => 'posts.karma DESC' && 'posts.created_at DESC'
  #default_scope :order => 'posts.created_at DESC'
  has_many :votes
  has_many :comments #, :foreign_key => "user_id"
#  has_one :karma
  validates :user_id, :presence => true
  validates :title, :presence => true
  URL_REGEX_MASTER = /^(http:\/\/www\.[a-zA-Z0-9]+\.[a-z]{2,3}|www\.[a-zA-Z0-9]+\.[a-z]{2,3}|[a-zA-Z0-9]+\.[a-z]{2,3}|http:\/\/[a-zA-Z0-9]+)/ 
  validates :subname, :presence => true
  validates :url, :format => { :with => URL_REGEX_MASTER }, :if => :is_link?  

  def increase_karma()
    self.karma += 1 
    self.save!
  end
  
  def decrease_karma()
    self.karma -= 1 
    self.save!
  end
end
