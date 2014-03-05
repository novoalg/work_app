# == Schema Information
#
# Table name: posts
#
#  id           :integer          not null, primary key
#  title        :string(255)
#  description  :string(255)
#  subreddit_id :integer
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  url          :string(255)
#

class Post < ActiveRecord::Base
  attr_accessible :description, :subreddit_id, :title, :user_id, :url
  belongs_to :user
  validates :user_id, :presence => true
  validates :title, :presence => true
  validates :subreddit_id, :presence => true
  
end
