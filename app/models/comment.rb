# == Schema Information
#
# Table name: comments
#
#  id           :integer          not null, primary key
#  content      :string(255)
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  reply        :string(255)
#  post_id      :integer
#  subreddit_it :integer
#

class Comment < ActiveRecord::Base
  attr_accessible :content, :user_id, :post_id, :karma, :subreddit_id
  validates :content, :presence => true
  validates :user_id, :presence => true
  validates :post_id, :presence => true
  default_scope :order => 'karma DESC' && 'created_at DESC'
  has_many :votes
  has_many :replies
  belongs_to :post
  belongs_to :user

  def increase_karma()
    self.karma += 1 
    self.save!
  end
  
  def decrease_karma()
    self.karma -= 1 
    self.save!
  end
end
