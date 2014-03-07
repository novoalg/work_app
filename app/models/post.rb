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
  attr_accessible :description, :subname, :title, :user_id, :url
  belongs_to :user
  belongs_to :subreddit
  has_many :comments #, :foreign_key => "user_id"
  validates :user_id, :presence => true
  validates :title, :presence => true
  URL_REGEX_MASTER = /^(http:\/\/www\.[a-zA-Z0-9]+\.[a-z]{2,3}|www\.[a-zA-Z0-9]+\.[a-z]{2,3}|[a-zA-Z0-9]+\.[a-z]{2,3})/ 
  validates :url, :format => { :with => URL_REGEX_MASTER } 
  validates :subname, :presence => true

    
end
